import 'package:flutter_riverpod/flutter_riverpod.dart';

final class RiverpodObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    super.didAddProvider(context, value);
    final provider = context.provider;
    print(
        'Provider added: ${provider.name ?? provider.runtimeType}, value: $value');
  }

  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue,
      Object? newValue) {
    super.didUpdateProvider(context, previousValue, newValue);
    final provider = context.provider;
    print(
        'Provider updated: ${provider.name ?? provider.runtimeType}, previous value: $previousValue, new value: $newValue');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    super.didDisposeProvider(context);
    final provider = context.provider;
    print('Provider disposed: ${provider.name ?? provider.runtimeType}');
  }
}
