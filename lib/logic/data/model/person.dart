import 'package:equatable/equatable.dart';
import 'package:my_sarafu/logic/data/model/chain.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:web3dart/web3dart.dart';

class Person extends Equatable {
  const Person({
    this.dateRegistered,
    this.gender,
    this.identities,
    this.location,
    this.products,
    this.vcard,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    final dateRegistered = json['date_registered'] as int;
    final gender = json['gender'] as String;
    final identities = json['identities'] != null
        ? parseIdentitiesJson(json['identities'] as Map<String, dynamic>)
        : null;
    final location = json['location'] != null
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null;
    final products = List<String>.from(json['products'] as List<dynamic>);
    final vcard = json['vcard'] as String;
    return Person(
      dateRegistered: dateRegistered,
      gender: gender,
      identities: identities,
      location: location,
      products: products,
      vcard: vcard,
    );
  }
  final int? dateRegistered;
  final String? gender;
  final List<Identity>? identities;
  final Location? location;
  final List<String>? products;
  final String? vcard;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date_registered'] = dateRegistered;
    data['gender'] = gender;
    if (identities != null) {
      // TODO(x): Implement this
      data['identities'] = "";
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['products'] = products;
    data['vcard'] = vcard;
    return data;
  }

  @override
  List<Object?> get props =>
      [dateRegistered, gender, identities, location, products, vcard];
}

class Identity extends Equatable {
  const Identity({required this.chainSpec, required this.addresses});
  final ChainSpec chainSpec;
  final List<EthereumAddress> addresses;

  @override
  List<Object?> get props => [chainSpec, addresses];
}

List<Identity> parseIdentitiesJson(Map<String, dynamic> json) {
  final archs = json.keys;
  final identities = <Identity>[];
  for (final arch in archs) {
    final archObject = json[arch] as Map<String, dynamic>;
    final forks = archObject.keys;
    for (final fork in forks) {
      final forkObject = archObject[fork] as Map<String, dynamic>;
      final networkIdAndCommonName = forkObject.keys;
      for (final networkIdAndCommonName in networkIdAndCommonName) {
        final networkId = int.parse(networkIdAndCommonName.split(':')[0]);
        final commonName = networkIdAndCommonName.split(':')[1];
        log
          ..i(networkIdAndCommonName)
          ..i(forkObject[networkIdAndCommonName]);
        final addressesString = List<String>.from(
            forkObject[networkIdAndCommonName] as List<dynamic>);
        final addresses = addressesString.map(EthereumAddress.fromHex).toList();

        identities.add(
          Identity(
            chainSpec: ChainSpec(
              arch: arch,
              fork: fork,
              networkId: networkId,
              commonName: commonName,
            ),
            addresses: addresses,
          ),
        );
      }
    }
  }
  return identities;
}

class Location extends Equatable {
  Location({this.areaName});

  factory Location.fromJson(Map<String, dynamic> json) {
    final areaName = json['area_name'] as String;
    return Location(areaName: areaName);
  }
  final String? areaName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['area_name'] = areaName;
    return data;
  }

  @override
  List<Object?> get props => [areaName];
}
