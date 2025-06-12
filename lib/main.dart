import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:practice_app/core/injections/injections.dart';
import 'package:practice_app/core/routing/app_router.dart';



void main() async {

  Logger logger = Logger();

  WidgetsFlutterBinding.ensureInitialized();

  try {

    await Injections().configureDependencies();

  } catch (e) {

    logger.e(e);

  }
  
  runApp(const MainApp()); 

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    final _AppRouter = AppRouter();

    return MaterialApp.router(
      title: 'App',
      routerConfig: _AppRouter.config(),
    );

  }

}
