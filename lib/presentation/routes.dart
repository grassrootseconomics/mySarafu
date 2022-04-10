import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/logic/cubit/accounts/accounts_cubit.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/cubit/vouchers/vouchers_cubit.dart';
import 'package:my_sarafu/logic/data/registry_repository.dart';
import 'package:my_sarafu/logic/data/vouchers_repository.dart';
import 'package:my_sarafu/presentation/screens/home/view/home_page.dart';
import 'package:my_sarafu/presentation/screens/landing/landing_page.dart';
import 'package:my_sarafu/presentation/screens/settings/settings_page.dart';
import 'package:my_sarafu/presentation/screens/vouchers/vouchers_page.dart';
import 'package:web3dart/web3dart.dart';

MaterialPageRoute onGenerateRoute(BuildContext context, RouteSettings route) {
  final httpClient = Client();
  if (context.read<AccountsCubit>().activeAccount == null) {
    return MaterialPageRoute<Widget>(
      builder: (_) => LandingView(),
    );
  }
  switch (route.name) {
    case '/home':
      return MaterialPageRoute<Widget>(
        builder: (context) => BlocProvider(
          create: (_) => VouchersCubit(
            VoucherRepository(
              settings: context.read<SettingsCubit>().state,
              registeryRepo: RegistryRepository(
                contractRegistery: context
                    .read<SettingsCubit>()
                    .state
                    .contractRegisteryAddress,
                client: Web3Client(
                  context.read<SettingsCubit>().state.rpcProvider,
                  httpClient,
                ),
              ),
              client: Web3Client(
                context.read<SettingsCubit>().state.rpcProvider,
                httpClient,
              ),
            ),
          ),
          child: const HomeView(),
        ),
      );
    case '/vouchers':
      return MaterialPageRoute<Widget>(
        builder: (context) => BlocProvider(
          create: (context) => VouchersCubit(
            VoucherRepository(
              settings: context.read<SettingsCubit>().state,
              registeryRepo: RegistryRepository(
                contractRegistery: context
                    .read<SettingsCubit>()
                    .state
                    .contractRegisteryAddress,
                client: Web3Client(
                  context.read<SettingsCubit>().state.rpcProvider,
                  httpClient,
                ),
              ),
              client: Web3Client(
                context.read<SettingsCubit>().state.rpcProvider,
                httpClient,
              ),
            ),
          )..updateBalances(
              context.read<AccountsCubit>().activeAccount!.address,
            ),
          child: const VouchersView(),
        ),
      );
    case '/settings':
      return MaterialPageRoute<Widget>(
        builder: (context) => BlocProvider(
          create: (context) => VouchersCubit(
            VoucherRepository(
              settings: context.read<SettingsCubit>().state,
              registeryRepo: RegistryRepository(
                contractRegistery: context
                    .read<SettingsCubit>()
                    .state
                    .contractRegisteryAddress,
                client: Web3Client(
                  context.read<SettingsCubit>().state.rpcProvider,
                  httpClient,
                ),
              ),
              client: Web3Client(
                context.read<SettingsCubit>().state.rpcProvider,
                httpClient,
              ),
            ),
          ),
          child: const SettingsView(),
        ),
      );
    default:
      return MaterialPageRoute<Widget>(
        builder: (context) => const LandingView(),
      );
  }
}
