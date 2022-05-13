part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.chainSpec,
    required this.contractRegistryAddress,
    required this.metaUrl,
    required this.cacheUrl,
    required this.rpcProvider,
    this.voucherRegistryAddress,
    this.defaultVoucherAddress,
    this.networkPreset = NetworkPresets.mainnet,
    this.themeMode = ThemeMode.system,
  });
  factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(
      chainSpec: json['chainSpec'] as String,
      contractRegistryAddress:
          EthereumAddress.fromHex(json['registryAddress'] as String),
      voucherRegistryAddress: json['voucherRegistryAddress'] is String
          ? EthereumAddress.fromHex(json['voucherRegistryAddress'] as String)
          : null,
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
  final String metaUrl;
  final String cacheUrl;
  final String rpcProvider;
  final EthereumAddress contractRegistryAddress;
  final EthereumAddress? voucherRegistryAddress;
  final EthereumAddress? defaultVoucherAddress;

  final ThemeMode themeMode;

  SettingsState copyWith({
    String? chainSpec,
    String? metaUrl,
    String? cacheUrl,
    String? rpcProvider,
    EthereumAddress? voucherRegistryAddress,
    EthereumAddress? contractRegistryAddress,
    EthereumAddress? defaultVoucherAddress,
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
      defaultVoucherAddress:
          defaultVoucherAddress ?? this.defaultVoucherAddress,
      themeMode: themeMode ?? this.themeMode,
      networkPreset: networkPreset ?? this.networkPreset,
    );
    return settings;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'chainSpec': chainSpec,
        'metaUrl': metaUrl,
        'cacheUrl': cacheUrl,
        'rpcProvider': rpcProvider,
        'networkPreset': networkPreset.name,
        'registryAddress': contractRegistryAddress.hexEip55,
        'voucherRegistryAddress': voucherRegistryAddress?.hexEip55,
        'defaultVoucherAddress': defaultVoucherAddress?.hexEip55,
        'themeMode': themeMode.name,
      };

  @override
  List<Object?> get props => [
        chainSpec,
        metaUrl,
        cacheUrl,
        rpcProvider,
        contractRegistryAddress,
        voucherRegistryAddress,
        defaultVoucherAddress,
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
          defaultVoucherAddress: mainnet.defaultVoucherAddress,
        );
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required String chainSpec,
    required String metaUrl,
    required String cacheUrl,
    required String rpcProvider,
    required EthereumAddress contractRegistryAddress,
    required EthereumAddress defaultVoucherAddress,
    required EthereumAddress voucherRegistryAddress,
    ThemeMode themeMode = ThemeMode.system,
  }) : super(
          chainSpec: chainSpec,
          metaUrl: metaUrl,
          cacheUrl: cacheUrl,
          rpcProvider: rpcProvider,
          contractRegistryAddress: contractRegistryAddress,
          voucherRegistryAddress: voucherRegistryAddress,
          defaultVoucherAddress: defaultVoucherAddress,
          themeMode: themeMode,
        );
}
