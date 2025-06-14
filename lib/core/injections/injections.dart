import 'package:get_it/get_it.dart';
import 'package:practice_app/core/net/dio_client.dart';

class Injections {

  final GetIt sl = GetIt.instance;

  Future<void> configureDependencies() async {

    sl.registerSingleton(() => DioClient());

  }

}


