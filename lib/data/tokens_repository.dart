import 'package:my_sarafu/contracts/token-registery/TokenUniqueSymbolIndex.g.dart';
import 'package:my_sarafu/data/model/token.dart';
import 'package:my_sarafu/utils/Converter.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';

class TokenRepository {
  final String tokenRegisteryAddress;
  final Web3Client client;
  final TokenUniqueSymbolIndex tokenUniqueSymbolIndexContract;
  List<TokenItem> tokens = [];

  TokenRepository({required this.tokenRegisteryAddress, required this.client})
      : tokenUniqueSymbolIndexContract = TokenUniqueSymbolIndex(
            address: EthereumAddress.fromHex(tokenRegisteryAddress),
            client: client);

  Future<List<TokenItem>> getTokens(EthereumAddress address) async {
    final count = await tokenUniqueSymbolIndexContract.entryCount();
    final range = List.generate(count.toInt(), (index) => index);
    List<TokenItem> t = [];
    await Future.forEach(range, (int idx) async {
      final tokenContractAddress =
          await tokenUniqueSymbolIndexContract.entry(new BigInt.from(idx));
      final erc20 = Erc20(address: tokenContractAddress, client: client);
      final symbol = await erc20.symbol();
      final decimals = await erc20.decimals();
      final converter = WeiConverter(decimals.toInt());
      final balance = await erc20.balanceOf(address);
      final token = TokenItem(
          idx: idx,
          address: tokenContractAddress,
          symbol: symbol,
          name: symbol,
          balance: converter.getValueInUnit(balance),
          decimals: decimals.toInt());
      t.add(token);
    });
    return t;
  }
}
