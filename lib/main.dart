import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_flushbar/flashy_flushbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/web.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/core/routing/app_router.dart';



void main() async {

  Logger? logger; 
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  try {
    await Firebase.initializeApp();
    await configureDependencies();
  } catch (e) {

    logger!.e(e);

  }

  FlutterNativeSplash.remove();
  
  runApp(const MainApp()); 

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      title: 'App',
      routerConfig: appRouter.config(),
      themeMode: ThemeMode.dark,
      builder: (context, child) {
        return FlashyFlushbarProvider( 
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          ),
        );
      },
    );
  }
}

// ask bout safearea minimum: in auth_content (line above keyboard appears) ???
// placeholder not centered for some reason ?? (fine on se not fine on big screens?)


