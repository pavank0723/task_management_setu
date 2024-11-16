import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:task_management_setu/network/local/local.dart';
import 'package:task_management_setu/network/local/theme_service.dart';
import 'package:task_management_setu/repository/repository.dart';
import 'package:task_management_setu/route/route.dart' as route;

class MyApp extends StatefulWidget {

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarBrightness: Brightness.dark, // Dark text for status bar
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ThemeService()..init(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => ToDoRepository()),
          RepositoryProvider(create: (_) => DataBaseService.instance),
        ],
        child: Consumer<ThemeService>(
          builder: (context, notifier, child) {
            return MaterialApp(
              initialRoute: route.AppRoute.splashScreen,
              onGenerateRoute: route.AppRoute.controller,
              debugShowCheckedModeBanner: false,
              themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,

              //Our custom theme applied
              darkTheme:
                  notifier.isDark ? notifier.darkTheme : notifier.lightTheme,
              theme: ThemeData(
                useMaterial3: true,

                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme,
                ),
                canvasColor: Colors.transparent,
                textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
                elevatedButtonTheme:
                    ElevatedButtonThemeData(style: raisedButtonStyle),
                outlinedButtonTheme:
                    OutlinedButtonThemeData(style: outlineButtonStyle),
              ),
            );
          },
        ),
      ),
    );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);
