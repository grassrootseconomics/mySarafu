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

  void changeNetworkPreset(NetworkPresets preset) {
    switch (preset) {
      case NetworkPresets.mainnet:
        emit(
          state.copyWith(
              networkPreset: preset,
              cacheUrl: mainnet.cacheUrl,
              chainSpec: mainnet.chainSpec,
              contractRegisteryAddress: mainnet.contractRegisteryAddress,
              rpcProvider: mainnet.rpcProvider,
              metaUrl: mainnet.metaUrl,
              tokenRegistryAddress: ''),
        );
        break;
      case NetworkPresets.testnet:
        emit(
          state.copyWith(
              networkPreset: preset,
              cacheUrl: testnet.cacheUrl,
              chainSpec: testnet.chainSpec,
              contractRegisteryAddress: testnet.contractRegisteryAddress,
              rpcProvider: testnet.rpcProvider,
              metaUrl: testnet.metaUrl,
              tokenRegistryAddress: ''),
        );
        break;
      case NetworkPresets.custom:
        emit(
          state.copyWith(networkPreset: preset),
        );
        break;
      default:
        throw Exception('Unknown network preset');
    }
  }
}
