import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:my_sarafu/cubits/accounts/accounts_cubit.dart';
import 'package:my_sarafu/cubits/settings/settings_cubit.dart';
import 'package:my_sarafu/cubits/vouchers/vouchers_cubit.dart';
import 'package:my_sarafu/data/registry_repository.dart';
import 'package:my_sarafu/data/vouchers_repository.dart';
import 'package:my_sarafu/screens/home_screen.dart';
import 'package:my_sarafu/screens/landing_screen.dart';
import 'package:my_sarafu/screens/settings_screen.dart';
import 'package:my_sarafu/screens/vouchers_screen.dart';
import 'package:web3dart/web3dart.dart';

MaterialPageRoute onGenerateRoute(BuildContext context, RouteSettings route) {
  final httpClient = Client();
  if (context.read<AccountsCubit>().activeAccount == null) {
    return MaterialPageRoute<Widget>(
      builder: (_) => const LandingView(),
    );
  }
  switch (route.name) {
    case '/home':
      return MaterialPageRoute<Widget>(
        builder: (context) => BlocProvider(
          create: (_) => VouchersCubit(
            VoucherRepository(
              settings: context.read<SettingsCubit>().state,
              registryRepo: RegistryRepository(
                contractRegistry:
                    context.read<SettingsCubit>().state.contractRegistryAddress,
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
              registryRepo: RegistryRepository(
                contractRegistry:
                    context.read<SettingsCubit>().state.contractRegistryAddress,
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
              registryRepo: RegistryRepository(
                contractRegistry:
                    context.read<SettingsCubit>().state.contractRegistryAddress,
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
