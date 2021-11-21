import 'package:solana/solana.dart';

class TransactionWrapper{

  String signature;
  TransactionResponse transaction;

  TransactionWrapper(this.signature, this.transaction);
}