import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';
import 'package:pizza/shared/app_routes.dart';

import 'cubit/client_profile_cubit.dart';

final class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({super.key});

  @override
  State<ClientProfilePage> createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ClientProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<ClientProfileCubit, ClientProfileState>(
      bloc: context.read<ClientProfileCubit>(),
      listener: (context, state) {
        if (state is ClientProfileException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is ClientProfileLogout) {
          context.goNamed(AppRoutes.splashRoute);
        }
      },
      builder: (context, state) {
        if (state is ClientProfileLoaded) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 8.0,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: 8.0,
                    runAlignment: WrapAlignment.start,
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    children: [
                      ProfileInfo(
                        label: 'Nome',
                        value: state.entity.user.name,
                      ),
                      ProfileInfo(
                        label: 'Email',
                        value: state.entity.user.email,
                      ),
                      ProfileInfo(
                        label: 'Telefone',
                        value: state.entity.user.phone,
                      ),
                      ProfileInfo(
                        label: 'CPF',
                        value: state.entity.user.asClient.cpf,
                      ),
                      ProfileInfo(
                        label: 'Endereço',
                        value: state.entity.user.asClient.address,
                      ),
                    ],
                  ),
                  ListTile(
                    onTap: () => context.pushNamed(AppRoutes.clientPaymentMethodRoute),
                    leading: Icon(Icons.credit_card),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Métodos de Pagamento',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: context.read<ClientProfileCubit>().logout,
                    child: const Text('Sair'),
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

final class ProfileInfo extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfo({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}
