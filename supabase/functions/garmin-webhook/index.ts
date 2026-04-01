/**
 * Fynix — Garmin Webhook Handler (Phase 2 Scaffold)
 *
 * Placeholder for Garmin Health API webhook integration.
 * Garmin uses OAuth1 and pushes activity summaries via webhook.
 *
 * TODO (Phase 2):
 * - Implement OAuth1 signature verification
 * - Parse Garmin activity summary JSON
 * - Map to Fynix workout schema
 * - Trigger xp-calculator
 */

Deno.serve(async (req: Request) => {
  if (req.method === 'GET') {
    // Garmin webhook verification
    return new Response(JSON.stringify({ status: 'coming_soon' }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  if (req.method !== 'POST') {
    return new Response('Method Not Allowed', { status: 405 });
  }

  console.log('Garmin webhook received — Phase 2 not yet implemented');

  // Accept the request so Garmin doesn't retry
  return new Response(JSON.stringify({ status: 'received', note: 'coming_in_phase_2' }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
});
