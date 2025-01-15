import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';

import 'cubit/client_cart_cubit.dart';
import 'widgets/create_client_order_dialog.dart';

final class ClientCartPage extends StatefulWidget {
  const ClientCartPage({super.key});

  @override
  State<ClientCartPage> createState() => _ClientCartPageState();
}

class _ClientCartPageState extends State<ClientCartPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClientCartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ClientCartCubit, ClientCartState>(
      bloc: context.read<ClientCartCubit>(),
      listener: (context, state) {
        if (state is ClientCartException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ClientCartLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: context.pop,
                            icon: Icon(Icons.arrow_back),
                          ),
                          Text(
                            'Carrinho',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final result = await CreateClientOrderDialog(
                                paymentMethods: state.paymentMethods,
                              ).show(context);

                              if (context.mounted && result != null) {
                                context.read<ClientCartCubit>().createOrder(
                                      result,
                                      state.productIds,
                                    );
                              }
                            },
                            icon: Icon(
                              Icons.shopping_cart_checkout_rounded,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: context.read<ClientCartCubit>().clearCart,
                            icon: Icon(
                              Icons.remove_shopping_cart_rounded,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: context.read<ClientCartCubit>().getCart,
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (state.cart.products.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: Text(
                          'Carrinho Vazio!',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  } else ...{
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart.products.length,
                        itemBuilder: (context, index) {
                          final product = state.cart.products[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: ListTile(
                                leading: Image.memory(
                                  product.pictureBytes,
                                  fit: BoxFit.cover,
                                  width: 48,
                                  height: 48,
                                  cacheWidth: 512,
                                  cacheHeight: 512,
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '#${product.id}',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            product.name,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'R\$ ${(product.value / 100).toStringAsFixed(2)}',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () => context //
                                      .read<ClientCartCubit>()
                                      .deleteProductFromCart(product.id),
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  },
                ],
              ),
            ),
          );
        }

        if (state is ClientCartSuccess) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: context.pop,
                            icon: Icon(Icons.arrow_back),
                          ),
                          Text(
                            'Carrinho',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: context.read<ClientCartCubit>().getCart,
                        icon: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Pedido efetuado com sucesso!',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
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
