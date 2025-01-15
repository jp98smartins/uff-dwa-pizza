import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';

import 'cubit/client_payment_method_cubit.dart';
import 'widgets/add_client_payment_method_dialog.dart';

final class ClientPaymentMethodPage extends StatefulWidget {
  const ClientPaymentMethodPage({super.key});

  @override
  State<ClientPaymentMethodPage> createState() => _ClientPaymentMethodPageState();
}

class _ClientPaymentMethodPageState extends State<ClientPaymentMethodPage> {
  @override
  void initState() {
    super.initState();
    context.read<ClientPaymentMethodCubit>().getPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ClientPaymentMethodCubit, ClientPaymentMethodState>(
      bloc: context.read<ClientPaymentMethodCubit>(),
      listener: (context, state) {
        if (state is ClientPaymentMethodException) {
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
        if (state is ClientPaymentMethodLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: context.pop,
                        icon: Icon(Icons.arrow_back),
                      ),
                      Text(
                        'Payment Methods Page',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final result = await AddClientPaymentMethodDialog().show(context);
                              if (context.mounted && result != null) {
                                context.read<ClientPaymentMethodCubit>().createPaymentMethod(result);
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: context.read<ClientPaymentMethodCubit>().getPaymentMethods,
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (state.paymentMethods.isEmpty) ...{
                    Expanded(
                      child: Center(
                        child: Text(
                          'Nenhuma forma de pagamento encontrada!',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                  } else ...{
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.paymentMethods.length,
                        itemBuilder: (context, index) {
                          final paymentMethod = state.paymentMethods[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    '#${paymentMethod.id}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                subtitle: Text(
                                  paymentMethod.number,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: theme.colorScheme.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: IconButton(
                                  onPressed: () => context //
                                      .read<ClientPaymentMethodCubit>()
                                      .deletePaymentMethod(paymentMethod.id),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
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
