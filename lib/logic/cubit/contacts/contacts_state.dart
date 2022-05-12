part of 'contacts_cubit.dart';

@immutable
abstract class ContactsState extends Equatable {
  const ContactsState({required this.contacts});
  final List<Contact> contacts;
}

class ContactsEmpty extends ContactsState {
  const ContactsEmpty() : super(contacts: const []);

  @override
  List<Object?> get props {
    return [];
  }
}

class ContactsLoaded extends ContactsState {
  const ContactsLoaded({required List<Contact> contacts})
      : super(contacts: contacts);

  @override
  List<Object?> get props {
    return [...contacts];
  }

  ContactsLoaded copyWith({
    List<Contact>? contacts,
  }) {
    return ContactsLoaded(
      contacts: contacts ?? this.contacts,
    );
  }
}

class ContactsError extends ContactsState {
  const ContactsError(List<Contact> contacts, this.message)
      : super(contacts: contacts);
  final String message;

  @override
  List<Object?> get props => [...contacts, message];
}
