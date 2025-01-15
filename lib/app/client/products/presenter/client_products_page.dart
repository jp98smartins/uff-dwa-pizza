import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';

import '../domain/models/client_product_model.dart';
import 'cubit/client_products_cubit.dart';

final class ClientProductsPage extends StatefulWidget {
  const ClientProductsPage({super.key});

  @override
  State<ClientProductsPage> createState() => _ClientProductsPageState();
}

class _ClientProductsPageState extends State<ClientProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClientProductsCubit>().getProductsShowcase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ClientProductsCubit, ClientProductsState>(
      bloc: context.read<ClientProductsCubit>(),
      listener: (context, state) {
        if (state is ClientProductsException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is ClientProductsLoaded && state.productAddedToCart) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Produto adicionado ao carrinho!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ClientProductsLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pizzas',
                          style: theme.textTheme.headlineSmall,
                        ),
                        IconButton(
                          onPressed: context.read<ClientProductsCubit>().getProductsShowcase,
                          icon: Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClientProductsFoodList(
                      foods: state.products.foods,
                      onAddToCart: (product) => context.read<ClientProductsCubit>().addToCart(product),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Bebidas',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    ClientProductsDrinkList(
                      drinks: state.products.drinks,
                      onAddToCart: (product) => context.read<ClientProductsCubit>().addToCart(product),
                    ),
                  ],
                ),
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

final class ClientProductsFoodList extends StatelessWidget {
  final List<ClientProductFoodModel> foods;
  final void Function(ClientProductModel) onAddToCart;

  const ClientProductsFoodList({
    required this.foods,
    required this.onAddToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (foods.isEmpty) {
      return Center(
        child: Text(
          'Nenhuma pizza encontrada!',
          style: theme.textTheme.headlineMedium,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          foods.length,
          (index) {
            final pizza = foods[index];
            return SizedBox(
              width: 256,
              height: 288,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.memory(
                          pizza.pictureBytes,
                          fit: BoxFit.cover,
                          width: 192,
                          cacheWidth: 512,
                          cacheHeight: 512,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        pizza.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pizza.size.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pizza.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'R\$ ${(pizza.value / 100).toStringAsFixed(2)}',
                            style: theme.textTheme.headlineMedium,
                          ),
                          IconButton(
                            onPressed: () => onAddToCart(pizza),
                            icon: Icon(Icons.add_shopping_cart),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final class ClientProductsDrinkList extends StatelessWidget {
  final List<ClientProductDrinkModel> drinks;
  final void Function(ClientProductModel) onAddToCart;

  const ClientProductsDrinkList({
    required this.drinks,
    required this.onAddToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (drinks.isEmpty) {
      return Center(
        child: Text(
          'Nenhuma bebida encontrada!',
          style: theme.textTheme.headlineLarge,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          drinks.length,
          (index) {
            final drink = drinks[index];
            return SizedBox(
              width: 256,
              height: 288,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.memory(
                          drink.pictureBytes,
                          fit: BoxFit.cover,
                          width: 192,
                          cacheWidth: 512,
                          cacheHeight: 512,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        drink.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        drink.type.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(drink.volume / 1000).toStringAsFixed(1)} L',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'R\$ ${(drink.value / 100).toStringAsFixed(2)}',
                            style: theme.textTheme.headlineMedium,
                          ),
                          IconButton(
                            onPressed: () => onAddToCart(drink),
                            icon: Icon(Icons.add_shopping_cart),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
