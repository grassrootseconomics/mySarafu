// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

final _contractAbi = _i1.ContractAbi.fromJson(
    '[{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"_declarator","type":"address"},{"indexed":false,"internalType":"address","name":"_subject","type":"address"},{"indexed":false,"internalType":"bytes32","name":"_proof","type":"bytes32"}],"name":"DeclarationAdded","type":"event"},{"inputs":[{"internalType":"address","name":"_subject","type":"address"},{"internalType":"bytes32","name":"_proof","type":"bytes32"}],"name":"addDeclaration","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_declarator","type":"address"},{"internalType":"address","name":"_subject","type":"address"}],"name":"declaration","outputs":[{"internalType":"bytes32[]","name":"","type":"bytes32[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_declarator","type":"address"},{"internalType":"uint256","name":"_idx","type":"uint256"}],"name":"declarationAddressAt","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_declarator","type":"address"}],"name":"declarationCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_subject","type":"address"},{"internalType":"uint256","name":"_idx","type":"uint256"}],"name":"declaratorAddressAt","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_subject","type":"address"}],"name":"declaratorCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"}]',
    'AddressDeclarator');

class AddressDeclarator extends _i1.GeneratedContract {
  AddressDeclarator(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(_i1.DeployedContract(_contractAbi, address), client, chainId);

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> addDeclaration(
      _i1.EthereumAddress _subject, _i2.Uint8List _proof,
      {required _i1.Credentials credentials,
      _i1.Transaction? transaction}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, 'ae47ece0'));
    final params = [_subject, _proof];
    return write(credentials, transaction, function, params);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<List<_i2.Uint8List>> declaration(
      _i1.EthereumAddress _declarator, _i1.EthereumAddress _subject,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '8c661b36'));
    final params = [_declarator, _subject];
    final response = await read(function, params, atBlock);
    return (response[0] as List<dynamic>).cast<_i2.Uint8List>();
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> declarationAddressAt(
      _i1.EthereumAddress _declarator, BigInt _idx,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '22168e4f'));
    final params = [_declarator, _idx];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> declarationCount(_i1.EthereumAddress _declarator,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '50e0c6d3'));
    final params = [_declarator];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> declaratorAddressAt(
      _i1.EthereumAddress _subject, BigInt _idx,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '7d64bf1d'));
    final params = [_subject, _idx];
    final response = await read(function, params, atBlock);
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> declaratorCount(_i1.EthereumAddress _subject,
      {_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, 'd0e95db1'));
    final params = [_subject];
    final response = await read(function, params, atBlock);
    return (response[0] as BigInt);
  }

  /// Returns a live stream of all DeclarationAdded events emitted by this contract.
  Stream<DeclarationAdded> declarationAddedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('DeclarationAdded');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return DeclarationAdded(decoded);
    });
  }
}

class DeclarationAdded {
  DeclarationAdded(List<dynamic> response)
      : declarator = (response[0] as _i1.EthereumAddress),
        subject = (response[1] as _i1.EthereumAddress),
        proof = (response[2] as _i2.Uint8List);

  final _i1.EthereumAddress declarator;

  final _i1.EthereumAddress subject;

  final _i2.Uint8List proof;
}
