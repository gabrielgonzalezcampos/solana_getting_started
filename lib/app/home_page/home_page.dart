import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana_getting_started/helpers/common.dart';
import 'package:solana_getting_started/helpers/wallet.dart';
import 'package:solana_getting_started/widgets/submit/submit_form.dart';
import 'package:solana_getting_started/widgets/transaction_list/transaction_list.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<TransactionListState> _keyTransactionList = GlobalKey();
  //final Singleton singleton = Singleton();
  late Wallet wallet;
  late RPCClient connection;

  final bool random = false;

  final List<int> seed = [25329, 53596, 44472, 42839, 11091, 41866, 18078, 47681, 2545, 28638, 3474, 60464, 14461, 48272, 38968, 38224, 33849, 17078, 4765, 29883, 14977, 46468, 14029, 23655, 19495];
  //8bNjUHdtJXHYsabG7cfQbHKJDb9VPpccXYLUW3pbR7Td

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _afterBuild(context));
    if (random){
      initWallet().then((value) async {
        showToast(context, "Wallet created");
        wallet = value.item2;
        connection = value.item1;
        print('Wallet PK: ${wallet.signer.address.toString()}');
        _keyTransactionList.currentState!.refreshList(wallet, connection);
      }).onError((error, stackTrace) {
        print("ERROR: ${error}");
        print("Trace: ${stackTrace}");
      });
    } else {
      initWalletFromSeed(seed).then((value) async {
        showToast(context, "Wallet created");
        wallet = value.item2;
        connection = value.item1;
        print('Wallet PK: ${wallet.signer.address.toString()}');
        _keyTransactionList.currentState!.refreshList(wallet, connection);
      }).onError((error, stackTrace) {
        print("ERROR: ${error}");
        print("Trace: ${stackTrace}");
      });
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SubmitForm(
                submitAction: _submitForm
            ),
            Expanded(
                child: TransactionList(
                  key: _keyTransactionList,
                )
            )
          ],
        ),
    );
  }

  void _submitForm() async{
    // print("Wallet PK: ${singleton.wallet.signer.extractPublicKey()}");

    _keyTransactionList.currentState!.refreshList(wallet, connection);
  }



  void _afterBuild(BuildContext context){
    showToast(context, "Creating Wallet");
  }
}