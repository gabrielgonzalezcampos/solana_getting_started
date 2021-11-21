import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana_getting_started/app/models/transaction_wrapper.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({Key? key, required this.transactionWithSignature}) : super(key: key);

  final TransactionWrapper transactionWithSignature;

  @override
  Widget build(BuildContext context) {
    int amount = 0;
    Meta meta;
    Transaction trans = transactionWithSignature.transaction.transaction;
    int senderBalances = 0;
    int receiverBalances = 0;


    if (transactionWithSignature.transaction.meta != null){
      meta = transactionWithSignature.transaction.meta!;
      amount = meta.preBalances[0] - meta.postBalances[0];
      senderBalances = meta.postBalances[0];
      receiverBalances = meta.postBalances[1];
    }

    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      padding: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tx: ${transactionWithSignature.signature}'),
          Text('Fee: ${transactionWithSignature.transaction.meta!.fee}'),
          Text('Sent Amount: $amount'),
          Text('Sender: ${trans.message!.accountKeys[0].pubkey}'),
          Text('Sender Balance: $senderBalances'),
          Text('Receiver: ${trans.message!.accountKeys[1].pubkey}'),
          Text('Receiver Balance: $receiverBalances'),
        ],
      ),
    );
  }
}
