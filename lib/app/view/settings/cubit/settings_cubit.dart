// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:hydrated_bloc/hydrated_bloc.dart';

class Settings {
  final String chainSpec;
  final String registeryAddress;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
  final String tokenRegistryAddress;

  Settings({
    required this.chainSpec,
    required this.registeryAddress,
    required this.tokenRegistryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
  });
}

var DefaultSettings = Settings(
  chainSpec: 'evm:blockchain:kitabu',
  registeryAddress: '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
  tokenRegistryAddress: '0xEa6225212005E86a4490018Ded4bf37F3E772161',
  metaUrl: 'https://meta.grassecon.net',
  cacheUrl: 'https://cache.grassecon.net',
  rpcProvider: 'https://rpc.grassecon.net',
);

class SettingsCubit extends HydratedCubit<Settings> {
  SettingsCubit() : super(DefaultSettings);

  @override
  Settings fromJson(Map<String, dynamic> json) => Settings(
        chainSpec: json['chainSpec'] as String,
        registeryAddress: json['registeryAddress'] as String,
        tokenRegistryAddress: (json['tokenRegistryAddress'] as String? ??
            '0xEa6225212005E86a4490018Ded4bf37F3E772161'),
        metaUrl: json['metaUrl'] as String,
        cacheUrl: json['cacheUrl'] as String,
        rpcProvider: json['rpcProvider'] as String,
      );

  @override
  Map<String, String> toJson(Settings settings) {
    return {
      'chainSpec': settings.chainSpec,
      'registeryAddress': settings.registeryAddress,
      'tokenRegistryAddress': settings.tokenRegistryAddress,
      'cacheUrl': settings.cacheUrl,
      'metaUrl': settings.metaUrl,
      'rpcProvider': settings.rpcProvider,
    };
  }

  void setSettings(Settings newSettings) => emit(newSettings);
}
