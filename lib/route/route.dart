import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_setu/ui/ui.dart';

class AppRoute {
  //#region Common
  static const String unKnownScreen = '/unKnownScreen';

  static const String splashScreen = '/';

  //#endregion

  static const String homeScreen = '/homeScreen';

  static Route<dynamic> controller(RouteSettings settings) {
    final args = settings.arguments;
    T instanceOf<T>(BuildContext context) {
      return RepositoryProvider.of<T>(context);
    }

    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);
      case AppRoute.homeScreen:
        return MaterialPageRoute(
            builder: (context) => ScreenUtilInit(
                  designSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                  minTextAdapt: true,
                  child: const HomeScreen(),
                ),
            settings: settings);

      default:
        return MaterialPageRoute(
            builder: (context) => ScreenUtilInit(
                designSize: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
                minTextAdapt: true,
                child: const UnknownScreen()),
            settings: settings);
    }
  }
}
