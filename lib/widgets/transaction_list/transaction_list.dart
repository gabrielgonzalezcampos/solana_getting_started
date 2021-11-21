import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana_getting_started/app/models/transaction_wrapper.dart';
import 'package:solana_getting_started/helpers/transactions.dart';
import 'package:solana_getting_started/widgets/transaction/transaction_view.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  TransactionListState createState() => TransactionListState();
}

class TransactionListState extends State<TransactionList> {

  List<TransactionWrapper> _transactions = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _transactions.length,
      itemBuilder: (context, i) {
        //if (i.isOdd) return const Divider();

        return _buildRow(_transactions[i]);
      }
    );
  }

  Widget _buildRow(TransactionWrapper transaction) {
    return TransactionView(transactionWithSignature: transaction);
  }

  void refreshList(Wallet wallet, RPCClient connection) async {
    _transactions = await getTransactions( address: wallet.address, connection: connection);
    setState((){});
  }
}
