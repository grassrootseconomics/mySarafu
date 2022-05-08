part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.chainSpec,
    required this.contractRegistryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
    this.voucherRegistryAddress,
    this.networkPreset = NetworkPresets.mainnet,
    this.themeMode = ThemeMode.system,
  });
  factory SettingsState.fromJson(dynamic json) {
    return SettingsState(
      chainSpec: json['chainSpec'] as String,
      contractRegistryAddress: json['registryAddress'] as String,
      voucherRegistryAddress: json['voucherRegistryAddress'] as String? ?? '',
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
  final String contractRegistryAddress;
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
  final String? voucherRegistryAddress;
  final ThemeMode themeMode;

  SettingsState copyWith({
    String? chainSpec,
    String? contractRegistryAddress,
    String? metaUrl,
    String? cacheUrl,
    String? rpcProvider,
    String? voucherRegistryAddress,
    NetworkPresets? networkPreset,
    ThemeMode? themeMode,
  }) {
    final settings = SettingsState(
      chainSpec: chainSpec ?? this.chainSpec,
      contractRegistryAddress:
          contractRegistryAddress ?? this.contractRegistryAddress,
      metaUrl: metaUrl ?? this.metaUrl,
      cacheUrl: cacheUrl ?? this.cacheUrl,
      rpcProvider: rpcProvider ?? this.rpcProvider,
      voucherRegistryAddress:
          voucherRegistryAddress ?? this.voucherRegistryAddress,
      themeMode: themeMode ?? this.themeMode,
      networkPreset: networkPreset ?? this.networkPreset,
    );
    return settings;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chainSpec': chainSpec,
        'registryAddress': contractRegistryAddress,
        'voucherRegistryAddress': voucherRegistryAddress,
        'metaUrl': metaUrl,
        'cacheUrl': cacheUrl,
        'rpcProvider': rpcProvider,
        'networkPreset': networkPreset.name,
        'themeMode': themeMode.name,
      };

  @override
  List<Object?> get props => [
        chainSpec,
        contractRegistryAddress,
        metaUrl,
        cacheUrl,
        rpcProvider,
        voucherRegistryAddress,
        networkPreset,
        themeMode,
      ];
}

class InitialSettings extends SettingsState {
  InitialSettings()
      : super(
          chainSpec: mainnet.chainSpec,
          contractRegistryAddress: mainnet.contractRegistryAddress,
          metaUrl: mainnet.metaUrl,
          cacheUrl: mainnet.cacheUrl,
          rpcProvider: mainnet.rpcProvider,
        );
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required String chainSpec,
    required String contractRegistryAddress,
    required String metaUrl,
    required String cacheUrl,
    required String rpcProvider,
    required String voucherRegistryAddress,
    ThemeMode themeMode = ThemeMode.system,
  }) : super(
          chainSpec: chainSpec,
          contractRegistryAddress: contractRegistryAddress,
          metaUrl: metaUrl,
          cacheUrl: cacheUrl,
          rpcProvider: rpcProvider,
          voucherRegistryAddress: voucherRegistryAddress,
          themeMode: themeMode,
        );
}
