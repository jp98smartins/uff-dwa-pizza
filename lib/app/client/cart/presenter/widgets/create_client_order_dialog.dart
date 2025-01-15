import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../payment_method/domain/models/client_payment_method_model.dart';

final class CreateClientOrderDialog extends StatefulWidget {
  final List<ClientPaymentMethodModel> paymentMethods;

  const CreateClientOrderDialog({required this.paymentMethods, super.key});

  @override
  State<CreateClientOrderDialog> createState() => _CreateClientOrderDialogState();

  Future<int?> show(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => this,
      );
}

class _CreateClientOrderDialogState extends State<CreateClientOrderDialog> {
  final _formKey = GlobalKey<FormState>();

  int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.paymentMethods.first.id;
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
                  'Finalizar Pedido',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: selectedValue,
                  items: widget.paymentMethods.map((e) {
                    return DropdownMenuItem<int>(
                      value: e.id,
                      child: Text(e.number),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Forma de Pagamento',
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedValue = value);
                    }
                  },
                  validator: (v) => AppValidator.required(v.toString()),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop(selectedValue);
                    }
                  },
                  child: Text('Finalizar'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
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
