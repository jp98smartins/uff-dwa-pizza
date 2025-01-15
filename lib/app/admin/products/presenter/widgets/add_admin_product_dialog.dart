import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/core.dart';
import '../../domain/models/admin_product_model.dart';

final class AddAdminProductDialog extends StatefulWidget {
  const AddAdminProductDialog({super.key});

  @override
  State<AddAdminProductDialog> createState() => _AddAdminProductDialogState();

  Future<AdminProductModel?> show(BuildContext context) => showDialog(
        context: context,
        builder: (_) => this,
      );
}

class _AddAdminProductDialogState extends State<AddAdminProductDialog> {
  final _formKey = GlobalKey<FormState>();

  int selectedProductTypeValue = 1;

  Uint8List? picture;
  String? selectedDrinkType;
  String? selectedFoodSize;

  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _volumeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _volumeController.dispose();
    _descriptionController.dispose();
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
                  'Adicionar Produto',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                AddProductImage(
                  picture: picture,
                  onSelectFile: (file) {
                    setState(() => picture = file);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Pizza de Calabresa',
                  ),
                  validator: AppValidator.required,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _valueController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Preço',
                    hintText: '100,00',
                  ),
                  inputFormatters: [MoneyInputFormatter()],
                  validator: AppValidator.money,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: selectedProductTypeValue,
                  items: [
                    DropdownMenuItem<int>(
                      value: 0,
                      child: Text('Bebida'),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Pizza'),
                    )
                  ],
                  decoration: InputDecoration(
                    labelText: 'Tipo de Produto',
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedProductTypeValue = value);
                    }
                  },
                  validator: (v) => AppValidator.required(v.toString()),
                ),
                const SizedBox(height: 16),
                if (selectedProductTypeValue == 0) ...{
                  DropdownButtonFormField<String>(
                    value: selectedDrinkType,
                    items: AdminProductDrinkTypeEnum.values.map((type) {
                      return DropdownMenuItem<String>(
                        value: type.name.toUpperCase(),
                        child: Text(type.description),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Tipo de Bebida',
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedDrinkType = value);
                      }
                    },
                    validator: AppValidator.required,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _volumeController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Volume (em mL)',
                      hintText: '1000 mL',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: AppValidator.required,
                  ),
                } else ...{
                  DropdownButtonFormField<String>(
                    value: selectedFoodSize,
                    items: AdminProductFoodSizeEnum.values.map((size) {
                      return DropdownMenuItem<String>(
                        value: size.name.toUpperCase(),
                        child: Text(size.description),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Tamanho da Pizza',
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedFoodSize = value);
                      }
                    },
                    validator: AppValidator.required,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      hintText: 'Ingredientes da pizza',
                    ),
                    validator: AppValidator.required,
                  ),
                },
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (selectedProductTypeValue == 0) {
                        Navigator.of(context).pop(
                          AdminProductDrinkModel(
                            id: -1,
                            picture: picture != null ? base64Encode(picture!) : '',
                            name: _nameController.text.trim(),
                            value: int.parse(_valueController.text.trim().sanitizeNumbers()),
                            type: AdminProductDrinkTypeEnum.values.firstWhere(
                              (e) => e.name.toUpperCase() == selectedDrinkType,
                            ),
                            volume: int.parse(_volumeController.text.trim().sanitizeNumbers()),
                          ),
                        );
                      } else {
                        Navigator.of(context).pop(
                          AdminProductFoodModel(
                            id: -1,
                            picture: picture != null ? base64Encode(picture!) : '',
                            name: _nameController.text.trim(),
                            value: int.parse(_valueController.text.trim().sanitizeNumbers()),
                            size: AdminProductFoodSizeEnum.values.firstWhere(
                              (e) => e.name.toUpperCase() == selectedFoodSize,
                            ),
                            description: _descriptionController.text.trim(),
                          ),
                        );
                      }
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

final class AddProductImage extends StatelessWidget {
  final Uint8List? picture;
  final void Function(Uint8List) onSelectFile;

  const AddProductImage({required this.onSelectFile, super.key, this.picture});

  @override
  Widget build(BuildContext context) {
    if (picture != null) {
      return Center(
        child: Image.memory(
          picture!,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      );
    }

    return Center(
      child: InkWell(
        onTap: () async {
          final file = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'jpeg', 'png'],
            allowMultiple: false,
          );

          if (context.mounted && file != null && file.files.isNotEmpty) {
            onSelectFile(file.files.first.bytes!);
          }
        },
        child: Container(
          height: 128,
          width: 128,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withAlpha(40),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.file_present_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
