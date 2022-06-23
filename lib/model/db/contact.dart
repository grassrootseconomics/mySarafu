// ignore_for_file: avoid_unused_constructor_parameters

import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  Contact({required this.name, required this.address, required this.id});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'address')
  String address;

  @override
  bool operator ==(Object o) =>
      o is Contact && o.name == name && o.address == address;

  @override
  int get hashCode => hash2(name.hashCode, address.hashCode);
}
