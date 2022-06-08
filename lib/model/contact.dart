import 'dart:convert';

import 'package:contacts_service/contacts_service.dart' as contacts_service;

class Contact extends contacts_service.Contact {
  Contact({this.email, this.phone});

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      email: map['email'] as String?,
      phone: map['phone'] as String?,
    );
  }
  final String? email;
  final String? phone;

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (email != null) {
      result.addAll(<String, String?>{'email': email});
    }
    if (phone != null) {
      result.addAll(<String, String?>{'phone': phone});
    }

    return result;
  }

  String toJson() => json.encode(toMap());
}
