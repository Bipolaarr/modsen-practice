import 'package:dio/dio.dart';

class DioClient {

  final Dio dio;

  DioClient() : dio = Dio() {

    dio.options = BaseOptions(

      baseUrl: '',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {}, 

    );

  } 

}
