import 'package:mocktail/mocktail.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/logic/data/tokens_repository.dart';
import 'package:web3dart/web3dart.dart';

var mockEthereumAddress =
    EthereumAddress.fromHex('0x0000000000000000000000000000000000000001');

var mockToken = Token(
  idx: 0,
  address: mockEthereumAddress,
  symbol: 'SRF',
  name: 'Sarafu',
  balance: BigInt.from(1000000000),
  decimals: 6,
);

class MockTokenRepository extends Mock implements TokenRepository {
  @override
  Future<List<Token>> getAllTokens(EthereumAddress address) async {
    final tokens = <Token>[];
    final token = tokens.add(mockToken);
    return tokens;
  }

  @override
  Future<List<Token>> updateBalances(
    EthereumAddress address,
    List<Token> tokens,
  ) async {
    final updated = <Token>[];
    for (final token in tokens) {
      final updatedToken = Token(
        idx: token.idx,
        address: token.address,
        symbol: token.symbol,
        name: token.name,
        balance: token.balance * BigInt.from(2),
        decimals: 6,
      );
      updated.add(updatedToken);
    }
    return updated;
  }
}

class MockEthereumAddress extends Mock implements EthereumAddress {}
