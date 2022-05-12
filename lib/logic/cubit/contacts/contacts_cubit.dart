import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/data/model/account.dart';
import 'package:my_sarafu/logic/data/model/contact.dart';

part 'contacts_state.dart';

class ContactsCubit extends HydratedCubit<ContactsState> {
  ContactsCubit() : super(const ContactsEmpty());

  void createAccount({required String name, required String password}) {}

  void setActiveAccount(int accountIdx) {}

  void deleteAccount(int accountIdx, {required String password}) {}

  void addAccount(Account account) {}

  @override
  ContactsState fromJson(dynamic json) {
    final contacts =
        (json['contacts'] as List<dynamic>).map(Contact.fromJson).toList();
    return ContactsLoaded(
      contacts: contacts,
    );
  }

  @override
  Map<String, dynamic> toJson(ContactsState state) {
    return <String, dynamic>{
      'accounts': state.contacts.map((e) => e.toJson()).toList(),
    };
  }
}
