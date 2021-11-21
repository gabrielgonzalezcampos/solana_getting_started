
import 'confirmed_signature_for_address2.dart';

class SignaturesForAddress2{
  final List<ConfirmedSignatureForAddress2> confirmedSignatures;

  SignaturesForAddress2.fromJson(Map<String, dynamic> json)
      : confirmedSignatures = json['result'];

  Map<String, dynamic> toJson() => {
    'result': confirmedSignatures
  };

  SignaturesForAddress2(this.confirmedSignatures);
}