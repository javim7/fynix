/**
 * Fynix — RevenueCat Webhook Handler
 *
 * Syncs subscription status changes from RevenueCat to Supabase.
 * Events handled: INITIAL_PURCHASE, RENEWAL, CANCELLATION, EXPIRATION, BILLING_ISSUE
 *
 * Webhook secret validation via X-RevenueCat-Signature header.
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

const REVENUECAT_WEBHOOK_SECRET = Deno.env.get('REVENUECAT_WEBHOOK_SECRET') ?? '';

type RevenueCatEvent =
  | 'INITIAL_PURCHASE'
  | 'RENEWAL'
  | 'CANCELLATION'
  | 'EXPIRATION'
  | 'BILLING_ISSUE'
  | 'PRODUCT_CHANGE'
  | 'UNCANCELLATION';

interface RevenueCatPayload {
  event: {
    type: RevenueCatEvent;
    app_user_id: string;
    expires_at_ms?: number;
    product_id?: string;
  };
}

function mapEventToStatus(eventType: RevenueCatEvent): {
  subscriptionStatus: string;
  subscriptionTier: string;
} {
  switch (eventType) {
    case 'INITIAL_PURCHASE':
    case 'RENEWAL':
    case 'UNCANCELLATION':
      return { subscriptionStatus: 'active', subscriptionTier: 'premium' };
    case 'CANCELLATION':
      return { subscriptionStatus: 'cancelled', subscriptionTier: 'premium' }; // still active until expiry
    case 'EXPIRATION':
      return { subscriptionStatus: 'expired', subscriptionTier: 'free' };
    case 'BILLING_ISSUE':
      return { subscriptionStatus: 'billing_issue', subscriptionTier: 'premium' };
    default:
      return { subscriptionStatus: 'free', subscriptionTier: 'free' };
  }
}

Deno.serve(async (req: Request) => {
  if (req.method !== 'POST') {
    return new Response('Method Not Allowed', { status: 405 });
  }

  const body = await req.text();

  // Validate webhook secret if configured
  if (REVENUECAT_WEBHOOK_SECRET) {
    const authHeader = req.headers.get('Authorization') ?? '';
    const token = authHeader.replace('Bearer ', '');
    if (token !== REVENUECAT_WEBHOOK_SECRET) {
      return new Response('Unauthorized', { status: 401 });
    }
  }

  const payload: RevenueCatPayload = JSON.parse(body);
  const { event } = payload;

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
  );

  const { subscriptionStatus, subscriptionTier } = mapEventToStatus(event.type);

  const expiresAt = event.expires_at_ms
    ? new Date(event.expires_at_ms).toISOString()
    : null;

  // RevenueCat app_user_id maps to Supabase user UUID
  const { error } = await supabase
    .from('users')
    .update({
      subscription_status: subscriptionStatus,
      subscription_tier: subscriptionTier,
      subscription_expires_at: expiresAt,
      revenuecat_customer_id: event.app_user_id,
      // Restore streak freeze on subscription renewal
      ...(event.type === 'INITIAL_PURCHASE' || event.type === 'RENEWAL'
        ? { streak_freezes_remaining: 1 }
        : {}),
    })
    .eq('id', event.app_user_id);

  if (error) {
    console.error('Failed to update subscription:', error);
    return new Response(JSON.stringify({ error: 'DB error' }), { status: 500 });
  }

  console.log(`Subscription updated for user ${event.app_user_id}: ${subscriptionStatus}`);

  return new Response(JSON.stringify({ status: 'ok' }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
