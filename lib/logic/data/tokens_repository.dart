import 'package:my_sarafu/logic/contracts/token-registery/TokenUniqueSymbolIndex.g.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/data/model/token.dart';
import 'package:my_sarafu/logic/data/registry_repository.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/contracts/erc20.dart';
import 'package:web3dart/web3dart.dart';

class TokenRepository {
  TokenRepository({
    required this.settings,
    required this.registeryRepo,
    required this.client,
  });

  final SettingsState settings;
  final RegistryRepository registeryRepo;
  final Web3Client client;
  TokenUniqueSymbolIndex? tokenUniqueSymbolIndexContract;

  List<Token> tokens = [];
  Future<void> getContract() async {
    if (tokenUniqueSymbolIndexContract == null) {
      if (settings.tokenRegistryAddress == null ||
          settings.tokenRegistryAddress!.isEmpty) {
        final tokenRegistryAddress = await registeryRepo.getTokenRegistery();
        tokenUniqueSymbolIndexContract = TokenUniqueSymbolIndex(
          address: tokenRegistryAddress,
          client: client,
        );
      } else {
        final tokenRegistryAddress =
            EthereumAddress.fromHex(settings.tokenRegistryAddress!);
        log.d(settings.tokenRegistryAddress);

        tokenUniqueSymbolIndexContract = TokenUniqueSymbolIndex(
          address: tokenRegistryAddress,
          client: client,
        );
      }
    }
  }

  Future<List<Token>> getAllTokens(EthereumAddress address) async {
    await getContract();

    final count = await tokenUniqueSymbolIndexContract!.entryCount();
    final range = List.generate(count.toInt(), (index) => index);
    final tokens = <Token>[];
    await Future.forEach(range, (int idx) async {
      final tokenContractAddress =
          await tokenUniqueSymbolIndexContract!.entry(BigInt.from(idx));
      final erc20 = Erc20(address: tokenContractAddress, client: client);
      final symbol = await erc20.symbol();
      final decimals = await erc20.decimals();
      final balance = await erc20.balanceOf(address);
      final token = Token(
        idx: idx,
        address: tokenContractAddress,
        symbol: symbol,
        name: symbol,
        balance: balance,
        decimals: decimals.toInt(),
      );
      tokens.add(token);
    });
    return tokens;
  }

  Future<List<Token>> updateBalances(
    EthereumAddress address,
    List<Token> tokens,
  ) async {
    final updated = <Token>[];
    await Future.wait(
      tokens.map((token) async {
        final balance = await getBalance(address, token);
        log.d('${token.symbol} Balance: $balance');
        final updatedToken = token.copyWith(balance: balance);
        updated.add(updatedToken);
      }),
    );
    return updated;
  }

  Future<BigInt> getBalance(EthereumAddress address, Token token) async {
    final erc20 = Erc20(address: token.address, client: client);
    return erc20.balanceOf(address);
  }
}
