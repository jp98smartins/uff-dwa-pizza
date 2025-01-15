import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';
import 'package:pizza/shared/app_routes.dart';

import 'cubit/splash_cubit.dart';

final class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().validateAuth();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<SplashCubit, SplashState>(
      bloc: context.read<SplashCubit>(),
      listener: (context, state) {
        if (state is SplashException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is SplashLoaded) {
          if (state.entity == null) {
            context.goNamed(AppRoutes.authRoute);
          } else {
            context.goNamed(
              state.entity!.user.isClient //
                  ? AppRoutes.clientProductsRoute
                  : AppRoutes.adminOrdersRoute,
            );
          }
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 256,
              width: 256,
              cacheWidth: 256,
              cacheHeight: 256,
            ),
            const SizedBox(height: 32),
            const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
