import 'package:equatable/equatable.dart';

class ChainSpec extends Equatable {
  const ChainSpec({
    required this.arch,
    required this.fork,
    required this.networkId,
    this.commonName,
    this.tag = const [],
  });

  factory ChainSpec.fromString(String chainStr) {
    ///  Create a new ChainSpec object from a colon-separated string
    ///  Formats:
    /// - <engine>:<common_name>:<network_id>
    /// - <engine>:<common_name>:<network_id>:<tag>

    final o = chainStr.split(':');
    if (o.length < 3) {
      throw Exception('Chain string must have three sections, got ${o.length}');
    }

    String? commonName;
    if (o.length > 3) {
      commonName = o[3];
    }
    var tag = <String>[];
    if (o.length > 4) {
      tag = o.sublist(4);
    }
    return ChainSpec(
      arch: o[0],
      fork: o[1],
      networkId: int.parse(o[2]),
      commonName: commonName,
      tag: tag,
    );
  }

  factory ChainSpec.fromDict(Map<String, dynamic> o) {
    /// Create a new ChainSpec object from a dictionary, as output from the asdict method.
    /// The chain spec is described by the following keys:
    /// - engine
    /// - fork
    /// - network_id
    /// - common_name
    /// - tag (optional)
    final arch = o['arch'] as String;
    final fork = o['fork'] as String;
    final networkId = o['network_id'] as int;
    final commonName = o['common_name'] as String?;
    final tag = o['tag'] as List<String>;

    return ChainSpec(
      arch: arch,
      fork: fork,
      networkId: networkId,
      commonName: commonName,
      tag: tag,
    );
  }
  final String arch;
  final String fork;
  final String? commonName;
  final int networkId;
  final List<String> tag;

  @override
  String toString() {
    return '$arch:$fork:$networkId:$commonName';
  }

  @override
  List<Object?> get props => [arch, fork, networkId, commonName, tag];
}
