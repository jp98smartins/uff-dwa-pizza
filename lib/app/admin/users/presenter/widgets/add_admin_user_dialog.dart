import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/core.dart';
import '../../domain/models/admin_user_model.dart';

final class AddAdminUserDialog extends StatefulWidget {
  const AddAdminUserDialog({super.key});

  @override
  State<AddAdminUserDialog> createState() => _AddAdminUserDialogState();

  Future<AdminUserModel?> show(BuildContext context) => showDialog(
        context: context,
        builder: (_) => this,
      );
}

class _AddAdminUserDialogState extends State<AddAdminUserDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _pisController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _pisController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 448),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Adicionar Funcionário',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Nome Completo',
                    hintText: 'João da Silva',
                  ),
                  validator: AppValidator.required,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'joao.silva@empresa.com.br',
                  ),
                  validator: AppValidator.email,
                ),
                TextFormField(
                  controller: _pisController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'PIS',
                    hintText: '0000000000',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: AppValidator.required,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    hintText: '(00) 00000-0000',
                  ),
                  inputFormatters: [PhoneTextFormatter()],
                  validator: AppValidator.phone,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop(AdminUserAdminModel.fromMap({
                        'id': -1,
                        'name': _nameController.text.trim(),
                        'email': _emailController.text.trim(),
                        'pis': _pisController.text.trim().sanitizeNumbers(),
                        'phone': _phoneController.text.trim().sanitizeNumbers(),
                        'admission_at': DateTime.now().toIso8601String(),
                      }));
                    }
                  },
                  child: Text('Adicionar'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
