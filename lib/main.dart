import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:furniture/presentation/resources/language_manager.dart';
import 'package:furniture/presentation/resources/routes_manager.dart';
import 'package:furniture/presentation/resources/theme_constants.dart';
import 'package:furniture/presentation/resources/theme_manager.dart';

import 'core/app_prefs.dart';
import 'core/services/service_locator.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ServiceLocator().init();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ]
  );

  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  final ThemeManager _themeManager = sl<ThemeManager>();

  bool loggedIn = false;

  goNext() {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
      if (isUserLoggedIn)
        {loggedIn = true}
      else
        {loggedIn = false}
    });
  }

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    _appPreferences.isThemeDark().then((value) => {_themeManager.toggleTheme(value)});
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    goNext();
    super.initState();
  }


  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: loggedIn ? Routes.splashRoute : Routes.loginRoute,
      title: 'Furniture',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
    );
  }
}
