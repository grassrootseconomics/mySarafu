// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/data/network_presets.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const InitialSettings());

  @override
  SettingsState fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    return state.toJson();
  }

  void setDarkMode({required bool value}) {
    emit(state.copyWith(darkMode: value));
  }

  void changeNetworkPreset(NetworkPreset preset) {
    emit(
      state.copyWith(
        chainSpec: preset.chainSpec,
        cacheUrl: preset.cacheUrl,
        rpcProvider: preset.rpcProvider,
        contractRegisteryAddress: preset.contractRegisteryAddress,
        metaUrl: preset.metaUrl,
        tokenRegistryAddress: '',
      ),
    );
  }
}
