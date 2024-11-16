import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_management_setu/repository/repository.dart';
import 'package:task_management_setu/ui/screen/to_do/add_to_do_screen/add_to_do_screen_bloc.dart';
import 'package:task_management_setu/ui/screen/to_do/view_to_do_screen/view_to_do_screen_bloc.dart';
import 'package:task_management_setu/ui/ui.dart';

class AppRoute {
  //#region Common
  static const String unKnownScreen = '/unKnownScreen';

  static const String splashScreen = '/';

  //#endregion

  static const String homeScreen = '/homeScreen';
  static const String addToDoScreen = '/addToDoScreen';
  static const String viewOrUpdateToDoScreen = '/viewOrUpdateToDoScreen';

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

      case AppRoute.addToDoScreen:
        return MaterialPageRoute(
            builder: (context) => ScreenUtilInit(
                  designSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                  minTextAdapt: true,
                  child: BlocProvider(
                    create: (context) => AddToDoScreenBloc(
                      instanceOf<ToDoRepository>(context),
                    ),
                    child: const AddToDoScreen(),
                  ),
                ),
            settings: settings);

      case AppRoute.viewOrUpdateToDoScreen:
        return MaterialPageRoute(
            builder: (context) => ScreenUtilInit(
                  designSize: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                  minTextAdapt: true,
                  child: BlocProvider(
                    create: (context) =>
                        ViewToDoScreenBloc(instanceOf<ToDoRepository>(context)),
                    child: ViewToDoDetail(
                      args: args as ViewToDoDetailArgs,
                    ),
                  ),
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
