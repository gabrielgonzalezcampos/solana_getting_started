import 'package:solana/solana.dart';

class TransactionWithSignature {

  String signature;
  ConfirmedSignature confirmedTransaction;

  TransactionWithSignature(this.signature, this.confirmedTransaction);
}