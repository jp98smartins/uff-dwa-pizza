import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

final class AddClientPaymentMethodDialog extends StatefulWidget {
  const AddClientPaymentMethodDialog({super.key});

  @override
  State<AddClientPaymentMethodDialog> createState() => _AddClientPaymentMethodDialogState();

  Future<String?> show(BuildContext context) => showDialog(
        context: context,
        builder: (_) => this,
      );
}

class _AddClientPaymentMethodDialogState extends State<AddClientPaymentMethodDialog> {
  final _formKey = GlobalKey<FormState>();

  final _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
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
                  'Adicionar Cartão de Crédito',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Número do Cartão',
                    hintText: '0000 0000 0000 0000',
                  ),
                  inputFormatters: [CreditCardInputFormatter()],
                  validator: AppValidator.creditCardNumber,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop(
                        _numberController.text.trim().sanitizeNumbers(),
                      );
                    }
                  },
                  child: Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
