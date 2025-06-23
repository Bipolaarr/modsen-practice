// features/home/presentation/pages/home_page.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/core/consts/constants.dart';
import 'package:practice_app/core/routing/app_router.dart';
import 'package:practice_app/core/stuff/service_locator.dart';
import 'package:practice_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:practice_app/features/home/domain/repositories/coins_repository.dart';
import 'package:practice_app/features/home/presentation/bloc/home_page_cubit.dart';
import 'package:practice_app/features/home/presentation/bloc/home_page_state.dart';
import 'package:practice_app/features/home/presentation/widgets/coin_tile.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(serviceLocator<CoinsRepository>())..loadCoins(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
          backgroundColor: Colors.black,
          title: const Text(
            'Coins Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              CupertinoIcons.chart_bar_alt_fill,
              color: Colors.white,
              size: 26,
            ),
            onPressed: () {
              // TODO: Implement portfolio view navigation
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.person_crop_circle_fill_badge_xmark,
                color: Colors.white,
                size: 26,
              ),
              onPressed: () {
                serviceLocator<LogoutUsecase>().call();
                context.router.replace(const SignInRoute());
              },
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Constants.formBlueColor),
              );
            }
            
            if (state is HomeError) {
              return _buildErrorPlaceholder(context, state.message);
            }
            
            if (state is HomeLoaded) {
              return ListView.builder(
                itemCount: state.coins.length,
                itemBuilder: (context, index) {
                  return CoinTile(coin: state.coins[index]);
                },
              );
            }
            
            return _buildInitialPlaceholder();
          },
        ),
      ),
    );
  }

  Widget _buildInitialPlaceholder() {
    return const Center(
      child: Text(
        'Loading cryptocurrency data...',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _buildErrorPlaceholder(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_triangle_fill,
              color: Colors.orange,
              size: 64,
            ),
            const SizedBox(height: 20),
            const Text(
              'Failed to load data',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<HomeCubit>().loadCoins(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.formBlueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}