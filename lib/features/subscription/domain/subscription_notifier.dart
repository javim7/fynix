import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fynix/features/subscription/data/subscription_repository.dart';

part 'subscription_notifier.g.dart';

/// Subscription state exposed to the rest of the app.
class SubscriptionState {
  const SubscriptionState({this.isPremium = false, this.isLoading = false});

  final bool isPremium;
  final bool isLoading;

  SubscriptionState copyWith({bool? isPremium, bool? isLoading}) =>
      SubscriptionState(
        isPremium: isPremium ?? this.isPremium,
        isLoading: isLoading ?? this.isLoading,
      );
}

@riverpod
class SubscriptionNotifier extends _$SubscriptionNotifier {
  @override
  Future<SubscriptionState> build() async {
    final isPremium =
        await ref.read(subscriptionRepositoryProvider).isPremium();
    return SubscriptionState(isPremium: isPremium);
  }

  Future<void> purchaseMonthly() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final info = await ref
          .read(subscriptionRepositoryProvider)
          .purchaseMonthly();
      final isPremium = info.entitlements.active.containsKey('premium');
      return SubscriptionState(isPremium: isPremium);
    });
  }

  Future<void> purchaseAnnual() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final info =
          await ref.read(subscriptionRepositoryProvider).purchaseAnnual();
      final isPremium = info.entitlements.active.containsKey('premium');
      return SubscriptionState(isPremium: isPremium);
    });
  }

  Future<void> restore() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final info =
          await ref.read(subscriptionRepositoryProvider).restorePurchases();
      final isPremium = info.entitlements.active.containsKey('premium');
      return SubscriptionState(isPremium: isPremium);
    });
  }
}
