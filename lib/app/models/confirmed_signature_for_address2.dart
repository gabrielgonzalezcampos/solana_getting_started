
class ConfirmedSignatureForAddress2{
  final int blockTime;
  final String confirmationStatus;
  final String signature;

  ConfirmedSignatureForAddress2(
      this.blockTime, this.confirmationStatus, this.signature);

  ConfirmedSignatureForAddress2.fromJson(Map<String, dynamic> json)
        : blockTime = json['blockTime'],
        confirmationStatus = json['confirmationStatus'],
        signature = json['signature'];

  Map<String, dynamic> toJson() => {
    'blockTime': blockTime,
    'confirmationStatus': confirmationStatus,
    'signature': signature,
  };
}