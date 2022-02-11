import 'dart:convert';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../webclient.dart';

const String baseUrl = 'https://61f2dcf82219930017f5093f.mockapi.io/bytebank';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(Uri.parse('$baseUrl/transactions'));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction?> save(
      BuildContext context, Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response =
        await client.post(Uri.parse('$baseUrl/transactions'),
            headers: {
              'Content-type': 'application/json',
              'password': password,
            },
            body: transactionJson);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final transaction = Transaction.fromJson(jsonDecode(response.body));
      return transaction;
    }

    throw HttpException(
        _statusCodeResponses[response.statusCode] ?? 'unknown error');
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction already exists'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
