import 'package:my_sarafu/logic/utils/logger.dart';

class Transaction {
  const Transaction({
    required this.blockNumber,
    required this.txHash,
    required this.dateBlock,
    required this.sender,
    required this.recipient,
    required this.fromValue,
    required this.toValue,
    required this.sourceToken,
    required this.destinationToken,
    required this.success,
    required this.txType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    try {
      final transaction = Transaction(
        blockNumber: json['block_number'] as int,
        txHash: json['tx_hash'] as String,
        dateBlock: json['date_block'] as double,
        sender: json['sender'] as String,
        recipient: json['recipient'] as String,
        fromValue: json['from_value'] as int,
        toValue: json['to_value'] as int,
        sourceToken: json['source_token'] as String,
        destinationToken: json['destination_token'] as String,
        success: json['success'] as bool,
        txType: json['tx_type'] as String,
      );
      return transaction;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
  final int blockNumber;
  final String txHash;
  final double dateBlock;
  final String sender;
  final String recipient;
  final int fromValue;
  final int toValue;
  final String sourceToken;
  final String destinationToken;
  final bool success;
  final String txType;

  Map<String, Object> toJson() {
    return {
      'block_number': blockNumber,
      'tx_hash': txHash,
      'date_block': dateBlock,
      'sender': sender,
      'recipient': recipient,
      'from_value': fromValue,
      'to_value': toValue,
      'source_token': sourceToken,
      'destination_token': destinationToken,
      'success': success,
      'tx_type': txType,
    };
  }
}

class TransactionList {
  const TransactionList({
    required this.data,
    required this.low,
    required this.high,
  });

  factory TransactionList.fromJson(dynamic json) {
    try {
      final transactionList = TransactionList(
        data: List<Map<String, dynamic>>.from(json['data'] as List)
            .map<Transaction>(Transaction.fromJson)
            .toList(),
        low: 0,
        high: 0,
      );
      transactionList.data.sort((a, b) => b.dateBlock.compareTo(a.dateBlock));
      return transactionList;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
  final List<Transaction> data;
  final int low;
  final int high;

  Map<String, Object> toJson() => <String, Object>{
        'data': data.map((e) => e.toJson()).toList(),
        'low': low,
        'high': high,
      };
}
