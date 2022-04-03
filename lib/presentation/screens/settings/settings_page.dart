// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/l10n/l10n.dart';
import 'package:my_sarafu/logic/cubit/accounts/account_cubit.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/data/network_presets.dart';
import 'package:my_sarafu/logic/utils/contracts.dart';
import 'package:my_sarafu/presentation/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final account = context.select((AccountCubit cubit) => cubit.state);
    final wallet = loadWallet(account.wallet, 'password');
    return Scaffold(
      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Accounts'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text('Account'),
                  value: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.name,
                        textAlign: TextAlign.left,
                      ),
                      SelectableText(
                        wallet.privateKey.address.toString(),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    context.read<SettingsCubit>().setDarkMode(value: value);
                  },
                  initialValue: settings.darkMode,
                  leading: const Icon(Icons.format_paint),
                  title: const Text('Dark Mode'),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text('Select Network Preset'),
                  value: Wrap(
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: const Text('Mainnet'),
                        selected:
                            context.read<SettingsCubit>().state.networkPreset ==
                                NetworkPresets.mainnet,
                        onSelected: (selected) => context
                            .read<SettingsCubit>()
                            .changeNetworkPreset(NetworkPresets.mainnet),
                      ),
                      ChoiceChip(
                        label: const Text('Testnet'),
                        onSelected: (selected) => context
                            .read<SettingsCubit>()
                            .changeNetworkPreset(NetworkPresets.testnet),
                        selected:
                            context.read<SettingsCubit>().state.networkPreset ==
                                NetworkPresets.testnet,
                      ),
                      ChoiceChip(
                        label: const Text('Custom'),
                        onSelected: (selected) => context
                            .read<SettingsCubit>()
                            .changeNetworkPreset(NetworkPresets.custom),
                        selected:
                            context.read<SettingsCubit>().state.networkPreset ==
                                NetworkPresets.custom,
                      )
                    ],
                  ),
                )
              ],
            ),
            SettingsSection(
              title: const Text('Advanced'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.document_scanner_rounded),
                  title: const Text('Contract Registry Address'),
                  value: Text(settings.contractRegisteryAddress),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.link_rounded),
                  title: const Text('ChainSpec'),
                  value: Text(settings.chainSpec),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.data_object_rounded),
                  title: const Text('Meta Url'),
                  value: Text(settings.metaUrl),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.storage_rounded),
                  title: const Text('Cache Url'),
                  value: Text(settings.cacheUrl),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.settings_remote),
                  title: const Text('RPC Provider'),
                  value: Text(settings.rpcProvider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
