import 'package:equatable/equatable.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/credentials.dart';

class Transaction extends Equatable {
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
        dateBlock: DateTime.fromMillisecondsSinceEpoch(
          (json['date_block'] as double).toInt() * 1000,
        ),
        sender: EthereumAddress.fromHex(json['sender'] as String),
        recipient: EthereumAddress.fromHex(json['recipient'] as String),
        fromValue: json['from_value'] as int,
        toValue: json['to_value'] as int,
        sourceToken: EthereumAddress.fromHex(json['source_token'] as String),
        destinationToken:
            EthereumAddress.fromHex(json['destination_token'] as String),
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
  final DateTime dateBlock;
  final EthereumAddress sender;
  final EthereumAddress recipient;
  final int fromValue;
  final int toValue;
  final EthereumAddress sourceToken;
  final EthereumAddress destinationToken;
  final bool success;
  final String txType;

  Map<String, Object> toJson() {
    return {
      'block_number': blockNumber,
      'tx_hash': txHash,
      'date_block': dateBlock.millisecondsSinceEpoch / 1000,
      'sender': sender.hex,
      'recipient': recipient.hex,
      'from_value': fromValue,
      'to_value': toValue,
      'source_token': sourceToken.hex,
      'destination_token': destinationToken.hex,
      'success': success,
      'tx_type': txType,
    };
  }

  @override
  List<Object?> get props => [
        blockNumber,
        txHash,
        dateBlock,
        sender,
        recipient,
        fromValue,
        toValue,
        sourceToken,
        destinationToken,
        success,
        txType,
      ];
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
        low: json['low'] as int,
        high: json['high'] as int,
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
