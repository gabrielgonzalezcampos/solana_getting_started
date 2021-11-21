import 'package:solana/solana.dart';
import 'package:solana_getting_started/app/models/transaction_wrapper.dart';
import 'package:solana_getting_started/helpers/wallet.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  final _saved = <TransactionWrapper>[];
  // late Wallet _wallet;
  //
  // Wallet get wallet => _wallet;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal(){
    // initWallet().then((value) => _wallet = value.item2);
  }

  List<TransactionWrapper> get saved => _saved;

}