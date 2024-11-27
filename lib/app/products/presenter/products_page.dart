import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';
import 'package:pizza/shared/app_routes.dart';

import 'cubit/products_cubit.dart';

final class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ProductsCubit, ProductsState>(
      bloc: context.read<ProductsCubit>(),
      listener: (context, state) {
        if (state is ProductsException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is ProductsLogout) {
          context.goNamed(AppRoutes.splashRoute);
        }
      },
      builder: (context, state) {
        if (state is ProductsLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AuthMapper.toJson(state.entity),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 32),
                  TextButton(
                    onPressed: () {
                      context.read<ProductsCubit>().logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
