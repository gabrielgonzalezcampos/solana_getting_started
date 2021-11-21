import 'package:solana/solana.dart';
import 'package:solana_getting_started/app/models/confirmed_signature_for_address2.dart';
import 'package:solana_getting_started/app/models/transaction_wrapper.dart';

Future<List<TransactionWrapper>> getTransactions({required RPCClient connection, required String address}) async {

  print("");
  print("Getting Transactions");

  List<String> signatures = await _getConfirmedSignaturesForAddress2(connection: connection, address: address);

  return _getConfirmedTransactions(connection, signatures);

  /*return Singleton().saved;*/
}

Future<void> confirmTransaction(String transactionSignature, RPCClient connection) async {
  print("");
  print("Confirming transaction...");
  TransactionResponse? confirmedTransaction = await connection.getConfirmedTransaction(transactionSignature);
  print("Confirmed transaction: ${confirmedTransaction!.transaction.message!.instructions.toString()}");
}

Future<List<String>> _getConfirmedSignaturesForAddress2({ required RPCClient connection,required String address }) async {
  final data = await connection.client.request(
    'getConfirmedSignaturesForAddress2',
    params: <dynamic>[
      address,
      {
        'encoding': 'jsonParsed'
      }
    ],
  );

  print("");
  print("Getting Transaction signatures");

  if (data['error'] != null) {
    print("ERROR Getting Transaction signatures");
    throw JsonRpcException.fromJson(data['error'] as Map<String, dynamic>);
  }

  print("Transactions data:");
  print(data["result"]);



  List<ConfirmedSignatureForAddress2> signatures = <ConfirmedSignatureForAddress2>[];

  List<dynamic> temp = data['result'] as List<dynamic>;

  for (var element in temp) {
    signatures.add(ConfirmedSignatureForAddress2.fromJson(element));
  }

  return _getSignaturesFromResponse(signatures);
}

List<String> _getSignaturesFromResponse(List<ConfirmedSignatureForAddress2> transactions){
  List<String> signatures = [];
  transactions.forEach((element) {
    signatures.add(element.signature);
  });

  return signatures;
}

Future<List<TransactionWrapper>> _getConfirmedTransactions(RPCClient connection, List<String> signatures) async{

  print("");
  print("Getting transactions from signatures");
  print(signatures.join(", "));

  List<TransactionWrapper> transactions = <TransactionWrapper>[];
  TransactionResponse? confirmedTransaction;
  TransactionWrapper transaction;

  for (var element in signatures) {
    confirmedTransaction = await connection.getConfirmedTransaction(element);

    print("");
    print("Transaction:");
    print(confirmedTransaction!.transaction.message!.accountKeys[0].pubkey);

    transaction = TransactionWrapper(confirmedTransaction.transaction.signatures[0], confirmedTransaction);
    transactions.add(transaction);
  }

  print("");
  print("Transactions");
  print(transactions[0].signature);

  return transactions;
}