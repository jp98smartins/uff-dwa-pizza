/// Interface to be implemented by the module class.
abstract interface class AppModule {
  /// Method to register all dependencies of the module.
  void registerDependencies();
}

/// Interface to be implemented by the application class.
abstract interface class ModularApp {
  /// List of modules to be registered.
  ///
  /// This list should contain all modules that will be used in the application.
  List<AppModule> get modules;

  /// Method to register all modules dependencies.
  ///
  /// This method should be called in the main method of the application.
  void registerModules() {}
}
