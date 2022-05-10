import 'dart:convert';

class Contact {
  Contact({this.email, this.phone});
  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Contact.fromMap(dynamic map) {
    return Contact(
      email: map['email'] as String?,
      phone: map['phone'] as String?,
    );
  }
  final String? email;
  final String? phone;

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
