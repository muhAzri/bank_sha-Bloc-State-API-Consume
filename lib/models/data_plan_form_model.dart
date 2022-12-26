class DataPlanFormModel {
  final int? dataPlanid;
  final String? phoneNumber;
  final String? pin;

  DataPlanFormModel({
    this.dataPlanid,
    this.phoneNumber,
    this.pin,
  });

  Map<String, dynamic> toJson() {
    return {
      'data_plan_id': dataPlanid.toString(),
      'phone_number': phoneNumber,
      'pin': pin,
    };
  }
}
