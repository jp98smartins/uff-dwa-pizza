import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';

import 'cubit/admin_user_cubit.dart';
import 'widgets/add_admin_user_dialog.dart';

final class AdminUserPage extends StatefulWidget {
  const AdminUserPage({super.key});

  @override
  State<AdminUserPage> createState() => _AdminUserPageState();
}

class _AdminUserPageState extends State<AdminUserPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminUserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AdminUserCubit, AdminUserState>(
      bloc: context.read<AdminUserCubit>(),
      listener: (context, state) {
        if (state is AdminUserException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is AdminProductLoaded && state.isUserAdded) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Funcionário adicionado com sucesso!'),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Usuários',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final product = await AddAdminUserDialog().show(context);
                              if (context.mounted && product != null) {
                                context.read<AdminUserCubit>().createUser(product);
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: context.read<AdminUserCubit>().getUsers,
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
                          'Funcionários',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Clientes',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Row(
                      children: [
                        // Foods
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                state.users.admins.length,
                                (index) {
                                  final admin = state.users.admins[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                                          child: Text(
                                            '#${admin.id} - ${admin.name}',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${admin.admissionAt.formatDate()} - ${admin.pis}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '${admin.phone} - ${admin.email}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: theme.colorScheme.secondary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        trailing: IconButton(
                                          onPressed: () => context //
                                              .read<AdminUserCubit>()
                                              .deleteUser(admin.id),
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
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Drinks
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                state.users.clients.length,
                                (index) {
                                  final client = state.users.clients[index];
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                                          child: Text(
                                            '#${client.id} - ${client.name}',
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${client.cpf} - ${client.email}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '${client.phone} - ${client.address}',
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: theme.colorScheme.secondary,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ],
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
