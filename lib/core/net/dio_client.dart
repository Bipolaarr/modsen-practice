import 'package:dio/dio.dart';

class DioClient {

  final Dio dio;

  DioClient() : dio = Dio() {

    dio.options = BaseOptions(

      baseUrl: '',
      connectTimeout: const Duration(),
      receiveTimeout: const Duration(),
      headers: {}, 

    );

  } 

}
