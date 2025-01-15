import 'package:flutter/material.dart';
import 'package:pizza/core/core.dart';
import 'package:pizza/shared/app_routes.dart';

import 'cubit/admin_profile_cubit.dart';

final class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AdminProfileCubit, AdminProfileState>(
      bloc: context.read<AdminProfileCubit>(),
      listener: (context, state) {
        if (state is AdminProfileException) {
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
        if (state is AdminProfileLoaded) {
          print(state.entity.user.isClient);
          print(state.entity.user.isEmployee);
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
                        label: 'PIS',
                        value: state.entity.user.asEmployee.pis,
                      ),
                      ProfileInfo(
                        label: 'Data de admissão',
                        value: state.entity.user.asEmployee.admissionDate.formatDate(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: context.read<AdminProfileCubit>().logout,
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
