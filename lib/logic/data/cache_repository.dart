import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_sarafu/logic/data/model/transaction.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

class CacheRepository {
  CacheRepository({required this.cacheUrl, required this.address});

  final EthereumAddress address;
  final String cacheUrl;

  Future<TransactionList> getAllTransactions() async {
    const limit = 16000;
    const offset = 0;
    final urlStr = '$cacheUrl/txa/user/${address.hexEip55}/$limit/$offset';
    final url = Uri.parse(urlStr);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final dynamic json = jsonDecode(response.body);
      return TransactionList.fromJson(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      log.e(response);
      throw Exception('Failed to load transactions');
    }
  }
}
