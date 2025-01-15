import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';

import 'cubit/admin_product_cubit.dart';
import 'widgets/add_admin_product_dialog.dart';
import 'widgets/edit_admin_product_dialog.dart';

final class AdminProductPage extends StatefulWidget {
  const AdminProductPage({super.key});

  @override
  State<AdminProductPage> createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminProductCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AdminProductCubit, AdminProductState>(
      bloc: context.read<AdminProductCubit>(),
      listener: (context, state) {
        if (state is AdminProductException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is AdminProductLoaded && state.isProductAdded) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Produto adicionado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is AdminProductLoaded && state.isProductUpdated) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Produto atualizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AdminProductLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Produtos',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final product = await AddAdminProductDialog().show(context);
                              if (context.mounted && product != null) {
                                context.read<AdminProductCubit>().createProduct(product);
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: context.read<AdminProductCubit>().getProducts,
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Pizzas',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Bebidas',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Foods
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                state.products.foods.length,
                                (index) {
                                  final food = state.products.foods[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: ListTile(
                                        leading: Image.memory(
                                          food.pictureBytes,
                                          fit: BoxFit.cover,
                                          width: 48,
                                          height: 48,
                                          cacheWidth: 512,
                                          cacheHeight: 512,
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                                          child: Text(
                                            '#${food.id} - ${food.name}',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${food.size.description} - ${food.description}',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'R\$ ${(food.value / 100).toStringAsFixed(2)}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: theme.colorScheme.secondary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        trailing: SizedBox(
                                          width: 96,
                                          height: 48,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  final product = await EditAdminProductDialog(product: food).show(context);
                                                  if (context.mounted && product != null) {
                                                    context.read<AdminProductCubit>().updateProduct(product);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () => context //
                                                    .read<AdminProductCubit>()
                                                    .deleteProduct(food.id),
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Drinks
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                state.products.drinks.length,
                                (index) {
                                  final drink = state.products.drinks[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: ListTile(
                                        leading: Image.memory(
                                          drink.pictureBytes,
                                          fit: BoxFit.cover,
                                          width: 48,
                                          height: 48,
                                          cacheWidth: 512,
                                          cacheHeight: 512,
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                                          child: Text(
                                            '#${drink.id} - ${drink.name}',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${(drink.volume / 1000).toStringAsFixed(1)} L - ${drink.type.description}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'R\$ ${(drink.value / 100).toStringAsFixed(2)}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: theme.colorScheme.secondary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        trailing: SizedBox(
                                          width: 96,
                                          height: 48,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  final product = await EditAdminProductDialog(product: drink).show(context);
                                                  if (context.mounted && product != null) {
                                                    context.read<AdminProductCubit>().updateProduct(product);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () => context //
                                                    .read<AdminProductCubit>()
                                                    .deleteProduct(drink.id),
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
