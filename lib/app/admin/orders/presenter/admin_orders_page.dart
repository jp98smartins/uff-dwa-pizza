import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';

import '../domain/models/admin_order_model.dart';
import 'cubit/admin_orders_cubit.dart';

final class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminOrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AdminOrdersCubit, AdminOrdersState>(
      bloc: context.read<AdminOrdersCubit>(),
      listener: (context, state) {
        if (state is AdminOrdersException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is AdminOrdersLoaded && state.isStatusUpdated) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Status do pedido atualizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AdminOrdersLoaded) {
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
                        'Pedidos',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: context.read<AdminOrdersCubit>().getOrders,
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
                                        '#${order.id} - ${order.client}',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${order.status.description} - ${order.orderedAt.formatDateTime()}',
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: theme.colorScheme.secondary,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    OrderDetails(items: order.items),
                                  ],
                                ),
                                trailing: order.status.hasNext
                                    ? ElevatedButton(
                                        onPressed: () {
                                          context //
                                              .read<AdminOrdersCubit>()
                                              .updateStatus(
                                                order.id,
                                                order.status.name.toUpperCase(),
                                              );
                                        },
                                        child: Text(order.status.nextDescription),
                                      )
                                    : null,
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

final class OrderDetails extends StatelessWidget {
  final List<AdminOrderItemModel> items;

  const OrderDetails({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        items.length,
        (index) {
          final item = items[index];
          if (item.isDrink) {
            return Row(
              children: [
                Expanded(child: Text(item.asDrink.name)),
                const SizedBox(width: 8),
                Expanded(child: Text('${(item.asDrink.volume / 1000).toStringAsFixed(1)} L')),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: Text(item.asFood.name)),
              const SizedBox(width: 8),
              Expanded(child: Text(item.asFood.size.description)),
            ],
          );
        },
      ),
    );
  }
}
