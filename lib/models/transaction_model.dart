import 'package:bank_sha/models/payment_method_model.dart';
import 'package:bank_sha/models/transaction_type.dart';

class TransactionModel {
  final int? id;
  final int? amount;
  final DateTime? createdAt;
  final PaymentMethodModel? paymentMethod;
  final TransactionTypeModel? transcationType;

  TransactionModel({
    this.id,
    this.amount,
    this.createdAt,
    this.paymentMethod,
    this.transcationType,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'],
        amount: json['amount'],
        createdAt: DateTime.tryParse(json['created_at']),
        paymentMethod: json['payment_method'] == null
            ? null
            : PaymentMethodModel.fromJson(
                json['payment_method'],
              ),
        transcationType: json['transaction_type'] == null
            ? null
            : TransactionTypeModel.fromJson(
                json['transaction_type'],
              ),
      );
}
