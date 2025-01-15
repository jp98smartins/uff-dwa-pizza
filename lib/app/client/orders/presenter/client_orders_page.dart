import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';

import 'cubit/client_orders_cubit.dart';

final class ClientOrdersPage extends StatefulWidget {
  const ClientOrdersPage({super.key});

  @override
  State<ClientOrdersPage> createState() => _ClientOrdersPageState();
}

class _ClientOrdersPageState extends State<ClientOrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClientOrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ClientOrdersCubit, ClientOrdersState>(
      bloc: context.read<ClientOrdersCubit>(),
      listener: (context, state) {
        if (state is ClientOrdersException) {
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
        if (state is ClientOrdersLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Meus Pedidos',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: context.read<ClientOrdersCubit>().getOrders,
                        icon: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (state.orders.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: Text(
                          'Nenhum pedido encontrado!',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  } else ...{
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '#${order.id}',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Text(
                                        'R\$ ${(order.total / 100).toStringAsFixed(2)}',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              order.orderedAt.formatDateTime(),
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: theme.colorScheme.onSurface,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              order.status.description,
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: theme.colorScheme.secondary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.local_pizza,
                                          color: theme.colorScheme.secondary,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          order.items.length.toString(),
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                color: theme.colorScheme.secondary,
                                                fontWeight: FontWeight.bold,
                                              ),
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
                  },
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
