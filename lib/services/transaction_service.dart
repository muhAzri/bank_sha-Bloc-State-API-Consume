import 'dart:convert';

import 'package:bank_sha/models/data_plan_form_model.dart';
import 'package:bank_sha/models/top_up_form_model.dart';
import 'package:bank_sha/models/transaction_model.dart';
import 'package:bank_sha/models/transfer_form_model.dart';
import 'package:bank_sha/services/auth_service.dart';
import 'package:bank_sha/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  Future<String> topUp(TopUpFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse(
          '$baseUrl/top_ups',
        ),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['redirect_url'];
      }

      throw jsonDecode(res.body)["message"];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> transfer(TransferFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse(
          '$baseUrl/transfers',
        ),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> dataPlan(DataPlanFormModel data) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.post(
        Uri.parse(
          '$baseUrl/data_plans',
        ),
        headers: {
          'Authorization': token,
        },
        body: data.toJson(),
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)["message"];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransactions() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(
        Uri.parse(
          '$baseUrl/transactions',
        ),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<TransactionModel>.from(
          jsonDecode(res.body)['data'].map(
            (transaction) => TransactionModel.fromJson(transaction),
          ),
        ).toList();
      }

      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
