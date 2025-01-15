import 'dart:async';

import 'package:get_it/get_it.dart' as gi;

sealed class AppInjector {
  static final _injector = gi.GetIt.instance;

  static T get<T extends Object>({String? instanceName}) {
    return _injector.get<T>(instanceName: instanceName);
  }

  static bool isRegistered<T extends Object>({
    Object? instance,
    String? instanceName,
  }) {
    return _injector.isRegistered<T>(
      instance: instance,
      instanceName: instanceName,
    );
  }

  static void registerFactory<T extends Object>(
    T Function() inject, {
    String? instanceName,
  }) {
    return _injector.registerFactory<T>(
      inject,
      instanceName: instanceName,
    );
  }

  static void registerFactoryAsync<T extends Object>(
    Future<T> Function() inject, {
    String? instanceName,
  }) {
    return _injector.registerFactoryAsync<T>(
      inject,
      instanceName: instanceName,
    );
  }

  static T registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    FutureOr Function(T param)? dispose,
  }) {
    return _injector.registerSingleton<T>(
      instance,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  static void registerSingletonAsync<T extends Object>(
    Future<T> Function() inject, {
    String? instanceName,
    FutureOr Function(T param)? dispose,
  }) {
    return _injector.registerSingletonAsync<T>(
      inject,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  static void registerLazySingleton<T extends Object>(
    T Function() inject, {
    String? instanceName,
    FutureOr Function(T param)? dispose,
  }) {
    return _injector.registerLazySingleton<T>(
      inject,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  static void registerLazySingletonAsync<T extends Object>(
    Future<T> Function() inject, {
    String? instanceName,
    FutureOr Function(T param)? dispose,
  }) {
    return _injector.registerLazySingletonAsync<T>(
      inject,
      instanceName: instanceName,
      dispose: dispose,
    );
  }

  static Future<void> reset({bool dispose = true}) {
    return _injector.reset(dispose: dispose);
  }

  static FutureOr resetLazySingleton<T extends Object>({
    T? instance,
    String? instanceName,
    FutureOr Function(T)? disposingFunction,
  }) {
    return _injector.resetLazySingleton<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }

  static FutureOr unregister<T extends Object>({
    Object? instance,
    String? instanceName,
    FutureOr Function(T)? disposingFunction,
  }) {
    return _injector.unregister<T>(
      instance: instance,
      instanceName: instanceName,
      disposingFunction: disposingFunction,
    );
  }
}
