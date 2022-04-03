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
    this.darkMode = false,
  });
  factory SettingsState.fromJson(dynamic json) {
    return SettingsState(
      chainSpec: json['chainSpec'] as String,
      contractRegisteryAddress: json['registeryAddress'] as String,
      tokenRegistryAddress: json['tokenRegistryAddress'] as String,
      metaUrl: json['metaUrl'] as String,
      cacheUrl: json['cacheUrl'] as String,
      rpcProvider: json['rpcProvider'] as String,
      networkPreset: NetworkPresets.values.byName(
        json['networkPreset'] is String
            ? json['networkPreset'] as String
            : NetworkPresets.mainnet.name,
      ),
      darkMode: json['darkMode'] as bool,
    );
  }
  final NetworkPresets networkPreset;
  final String chainSpec;
  final String contractRegisteryAddress;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
  final String? tokenRegistryAddress;
  final bool darkMode;

  SettingsState copyWith({
    String? chainSpec,
    String? contractRegisteryAddress,
    String? metaUrl,
    String? cacheUrl,
    String? rpcProvider,
    String? tokenRegistryAddress,
    NetworkPresets? networkPreset,
    bool? darkMode,
  }) {
    final settings = SettingsState(
      chainSpec: chainSpec ?? this.chainSpec,
      contractRegisteryAddress:
          contractRegisteryAddress ?? this.contractRegisteryAddress,
      metaUrl: metaUrl ?? this.metaUrl,
      cacheUrl: cacheUrl ?? this.cacheUrl,
      rpcProvider: rpcProvider ?? this.rpcProvider,
      tokenRegistryAddress: tokenRegistryAddress ?? this.tokenRegistryAddress,
      darkMode: darkMode ?? this.darkMode,
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
        'darkMode': darkMode,
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
        darkMode,
      ];
}

class InitialSettings extends SettingsState {
  const InitialSettings()
      : super(
          chainSpec: 'evm:blockchain:kitabu',
          contractRegisteryAddress:
              '0xcf60ebc445b636a5ab787f9e8bc465a2a3ef8299',
          tokenRegistryAddress: null,
          metaUrl: 'https://meta.grassecon.net',
          cacheUrl: 'https://cache.grassecon.net',
          rpcProvider: 'https://rpc.grassecon.net',
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
    bool darkMode = false,
  }) : super(
          chainSpec: chainSpec,
          contractRegisteryAddress: contractRegisteryAddress,
          metaUrl: metaUrl,
          cacheUrl: cacheUrl,
          rpcProvider: rpcProvider,
          tokenRegistryAddress: tokenRegistryAddress,
          darkMode: darkMode,
        );
}
