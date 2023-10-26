import 'package:get_it/get_it.dart';

class AppConfig {
  static final GetIt getIt = GetIt.instance;

  static void registerDependencies() {
    //getIt.registerSingleton<CalculatorBloc>(CalculatorBloc());
  }
}