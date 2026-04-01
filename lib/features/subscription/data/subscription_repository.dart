import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_repository.g.dart';

@riverpod
SubscriptionRepository subscriptionRepository(Ref ref) =>
    SubscriptionRepository();

class SubscriptionRepository {
  static const String _entitlementId = 'premium';
  static const String _monthlyProductId = 'fynix_premium_monthly';
  static const String _annualProductId = 'fynix_premium_annual';

  Future<bool> isPremium() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.active.containsKey(_entitlementId);
    } catch (_) {
      return false;
    }
  }

  Future<Offerings?> fetchOfferings() async {
    try {
      return Purchases.getOfferings();
    } catch (_) {
      return null;
    }
  }

  Future<CustomerInfo> purchaseMonthly() async {
    final offerings = await Purchases.getOfferings();
    final monthly = offerings.current?.monthly;
    if (monthly == null) throw Exception('Monthly offering not available');
    return Purchases.purchasePackage(monthly);
  }

  Future<CustomerInfo> purchaseAnnual() async {
    final offerings = await Purchases.getOfferings();
    final annual = offerings.current?.annual;
    if (annual == null) throw Exception('Annual offering not available');
    return Purchases.purchasePackage(annual);
  }

  Future<CustomerInfo> restorePurchases() async {
    return Purchases.restorePurchases();
  }
}
