import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysarafu/cubits/settings/settings_cubit.dart';
import 'package:mysarafu/model/network_presets.dart';
import 'package:mysarafu/widgets/bottom_nav/view/bottom_nav.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsCubit cubit) => cubit.state);
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(key: Key('bottomNavBar')),
      body: SafeArea(
        child: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('Wallets'),
              // TODO(x): Remove settings_ui dependency.
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: const Icon(Icons.format_paint),
                  title: const Text('Dark Mode'),
                  trailing: DropdownButton(
                    // Initial Value
                    value: context.read<SettingsCubit>().state.themeMode,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light'),
                      )
                    ],
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (ThemeMode? newValue) {
                      if (newValue != null) {
                        context
                            .read<SettingsCubit>()
                            .setThemeMode(value: newValue);
                      }
                    },
                  ),
                ),
                SettingsTile.navigation(
                  leading: const Icon(Icons.account_circle_rounded),
                  title: const Text('Select Network Preset'),
                  trailing: DropdownButton(
                    // Initial Value
                    value: context.read<SettingsCubit>().state.networkPreset,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: const [
                      DropdownMenuItem(
                        value: NetworkPresets.mainnet,
                        child: Text('Mainnet'),
                      ),
                      DropdownMenuItem(
                        value: NetworkPresets.testnet,
                        child: Text('Testnet'),
                      ),
                      DropdownMenuItem(
                        value: NetworkPresets.custom,
                        child: Text('Custom'),
                      )
                    ],
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (NetworkPresets? newValue) {
                      if (newValue != null) {
                        throw UnimplementedError();
                      }
                    },
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
                  value: Text(settings.contractRegistryAddress.hexEip55),
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
