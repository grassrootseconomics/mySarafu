// ignore_for_file: avoid_unused_constructor_parameters

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

part 'contact.g.dart';

@immutable
@JsonSerializable()
class Contact {
  const Contact({required this.name, required this.address, required this.id});

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'address')
  final String address;

  @override
  bool operator ==(Object other) =>
      other is Contact && other.name == name && other.address == address;

  @override
  int get hashCode => hash2(name.hashCode, address.hashCode);
}
