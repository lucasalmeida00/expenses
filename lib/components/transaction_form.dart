import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String title, double value) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final textController = TextEditingController();

  final valueController = TextEditingController();

  _submitForm() {
    if (textController.text.isEmpty ||
        double.tryParse(valueController.text) == null) {
      return;
    }

    widget.onSubmit(
        textController.text, double.tryParse(valueController.text) ?? 0.0);
    textController.value = TextEditingValue.empty;
    valueController.value = TextEditingValue.empty;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 200,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                ),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: valueController,
                decoration: const InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
                onSubmitted: (_) => _submitForm,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple),
                      ),
                      onPressed: _submitForm,
                      child: const Text('Nova Transação')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
