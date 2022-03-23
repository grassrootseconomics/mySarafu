// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/app/components/bottom_nav.dart';
import 'package:my_sarafu/app/view/settings/cubit/account_cubit.dart';
import 'package:my_sarafu/app/view/settings/cubit/settings_cubit.dart';
import 'package:my_sarafu/l10n/l10n.dart';
import 'package:my_sarafu/utils/contracts.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocProvider(
        create: (_) => AccountCubit(),
        child: const SettingsView(),
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    final account = context.select((AccountCubit cubit) => cubit.state);
    final wallet = loadWallet(account.wallet, account.password);
    final balance = connectRPC(wallet, settings.rpcProvider);
    return Scaffold(
        // To work with lists that may contain a large number of items, it’s best
        // to use the ListView.builder constructor.
        //
        // In contrast to the default ListView constructor, which requires
        // building all Widgets up front, the ListView.builder constructor lazily
        // builds Widgets as they’re scrolled into view.
        bottomNavigationBar: const BottomNavBar(),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Accounts'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text('Active Account'),
                  value: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "William",
                        textAlign: TextAlign.left,
                      ),
                      const Text('0xf3ED5354C3565E9F03a3E59068ed12BCEBaEb18d',
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: const Icon(Icons.format_paint),
                  title: const Text('Dark Mode'),
                ),
              ],
            ),
            SettingsSection(
              title: const Text('Advanced'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.document_scanner_rounded),
                  title: const Text('Contract Registry Address'),
                  value: Text(settings.registeryAddress),
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
        ));
  }
}
