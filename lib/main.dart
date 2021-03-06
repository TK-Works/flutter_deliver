import 'package:flutter/services.dart';
import 'package:flutter_deliver/core/services/navigator_service.dart';
import 'package:flutter_deliver/core/services/auth_service.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await LocatorInjector.setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  locator<NavigatorService>().createRoutes();
  locator<AuthService>().initValues();
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        break;

      case AppLifecycleState.inactive:
        break;

      case AppLifecycleState.resumed:
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
        break;

      case AppLifecycleState.detached:
        break;

      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        supportedLocales: [
          Locale('en', ''),
        ],
        navigatorKey: locator<NavigatorService>().navigatorKey,
        onGenerateRoute: locator<NavigatorService>().generator,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
