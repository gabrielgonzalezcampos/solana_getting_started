import 'package:flutter/material.dart';
import 'package:solana_getting_started/helpers/common.dart';
import 'package:solana_getting_started/helpers/transactions.dart';
import 'package:solana_getting_started/helpers/wallet.dart';

class SubmitForm extends StatefulWidget {
  const SubmitForm({Key? key, required this.submitAction}) : super(key: key);

  final void Function() submitAction;

  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController accountEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: amountEditingController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.monetization_on_rounded),
                  hintText: 'Lamports to submit',
                  labelText: 'Amount (lamports)'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  try {
                    int.parse(value);
                  } on FormatException {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: accountEditingController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.account_balance_wallet_rounded),
                  hintText: 'Adress to send the lamports',
                  labelText: 'Adress'
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
               Padding(
                padding: const EdgeInsets.only( top: 8.0 ),
                child: Center(
                  child: ElevatedButton(
                    child: const Text('Submit'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submit(context);
                      }
                    },
                  )
                ),
              )
            ],
          ),
        ),
    );
  }

  void _submit(BuildContext context) async {
    showToast(context, "Sending money");
    String signature = await sendMoney(accountEditingController.text, int.parse(amountEditingController.text));
    showToast(context, "Money Sent");
    confirmTransaction(signature, connection);
    showToast(context, "Transaction confirmed");
    widget.submitAction();
  }
}
