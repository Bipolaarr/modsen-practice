
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/domain/usecases/logout_usecase.dart';

@RoutePage()
class HomePage extends StatelessWidget{

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(


        onPressed: (){
          serviceLocator<LogoutUsecase>().call();
          context.router.replace(SignInRoute());
        } ,
        child: Text("Sign out"))
      )
    );
  }


}
