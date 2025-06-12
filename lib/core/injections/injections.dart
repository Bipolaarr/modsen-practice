import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_app/core/net/dio_client.dart';

class Injections {

  final GetIt sl = GetIt.instance;

  Future<void> configureDependencies() async {

    sl.registerSingleton(() => DioClient());

    try {

      await dotenv.load(fileName: ".env");
    } catch (e) { print('Error loading .env: $e'); }

    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!
      )
    );
    
  }

}


