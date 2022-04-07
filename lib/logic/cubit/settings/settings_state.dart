part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.chainSpec,
    required this.contractRegisteryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
    this.tokenRegistryAddress,
    this.networkPreset = NetworkPresets.mainnet,
    this.themeMode = ThemeMode.system,
  });
  factory SettingsState.fromJson(dynamic json) {
    return SettingsState(
      chainSpec: json['chainSpec'] as String,
      contractRegisteryAddress: json['registeryAddress'] as String,
      tokenRegistryAddress: json['tokenRegistryAddress'] as String? ?? '',
      metaUrl: json['metaUrl'] as String,
      cacheUrl: json['cacheUrl'] as String,
      rpcProvider: json['rpcProvider'] as String,
      networkPreset: NetworkPresets.values.byName(
        json['networkPreset'] is String
            ? json['networkPreset'] as String
            : NetworkPresets.mainnet.name,
      ),
      themeMode: ThemeMode.values.byName(
        json['themeMode'] is String
            ? json['themeMode'] as String
            : ThemeMode.system.name,
      ),
    );
  }
  final NetworkPresets networkPreset;
  final String chainSpec;
  final String contractRegisteryAddress;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
  final String? tokenRegistryAddress;
  final ThemeMode themeMode;

  SettingsState copyWith({
    String? chainSpec,
    String? contractRegisteryAddress,
    String? metaUrl,
    String? cacheUrl,
    String? rpcProvider,
    String? tokenRegistryAddress,
    NetworkPresets? networkPreset,
    ThemeMode? themeMode,
  }) {
    final settings = SettingsState(
      chainSpec: chainSpec ?? this.chainSpec,
      contractRegisteryAddress:
          contractRegisteryAddress ?? this.contractRegisteryAddress,
      metaUrl: metaUrl ?? this.metaUrl,
      cacheUrl: cacheUrl ?? this.cacheUrl,
      rpcProvider: rpcProvider ?? this.rpcProvider,
      tokenRegistryAddress: tokenRegistryAddress ?? this.tokenRegistryAddress,
      themeMode: themeMode ?? this.themeMode,
      networkPreset: networkPreset ?? this.networkPreset,
    );
    return settings;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chainSpec': chainSpec,
        'registeryAddress': contractRegisteryAddress,
        'tokenRegistryAddress': tokenRegistryAddress,
        'metaUrl': metaUrl,
        'cacheUrl': cacheUrl,
        'rpcProvider': rpcProvider,
        'networkPreset': networkPreset.name,
        'themeMode': themeMode.name,
      };

  @override
  List<Object?> get props => [
        chainSpec,
        contractRegisteryAddress,
        metaUrl,
        cacheUrl,
        rpcProvider,
        tokenRegistryAddress,
        networkPreset,
        themeMode,
      ];
}

class InitialSettings extends SettingsState {
  InitialSettings()
      : super(
          chainSpec: mainnet.chainSpec,
          contractRegisteryAddress: mainnet.contractRegisteryAddress,
          metaUrl: mainnet.metaUrl,
          cacheUrl: mainnet.cacheUrl,
          rpcProvider: mainnet.rpcProvider,
        );
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required String chainSpec,
    required String contractRegisteryAddress,
    required String metaUrl,
    required String cacheUrl,
    required String rpcProvider,
    required String tokenRegistryAddress,
    ThemeMode themeMode = ThemeMode.system,
  }) : super(
          chainSpec: chainSpec,
          contractRegisteryAddress: contractRegisteryAddress,
          metaUrl: metaUrl,
          cacheUrl: cacheUrl,
          rpcProvider: rpcProvider,
          tokenRegistryAddress: tokenRegistryAddress,
          themeMode: themeMode,
        );
}
