import 'package:firebase_core/firebase_core.dart';
import 'package:flashy_flushbar/flashy_flushbar_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logger/web.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/core/routing/app_router.dart';



void main() async {

  Logger logger = Logger();

  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  try {
    if (kIsWeb) {
      await dotenv.load(fileName: ".env");
      await Firebase.initializeApp(options: 
        FirebaseOptions(
          apiKey: dotenv.env["FIREBASE_KEY"]!,
          appId: dotenv.env["FIREBASE_APP_ID"]!,
          messagingSenderId: dotenv.env["FIREBASE_MESSAGING_SENDER_ID"]!,
          projectId: dotenv.env["FIREBASE_PROJECT_ID"]!
        )
      );

    } else {
    await Firebase.initializeApp();
    }
    configureDependencies();
  } catch (e) {

    logger.e(e);

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
        return FlashyFlushbarProvider( // Move provider inside MaterialApp
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
            child: child!,
          ),
        );
      },
    );
  }
}

/// flash icon size + snackbar + isar/local_auth
