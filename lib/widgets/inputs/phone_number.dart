import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysarafu/cubits/send/cubit/send_form_cubit.dart';
import 'package:mysarafu/repository/contacts_repository.dart';
import 'package:mysarafu/widgets/loading.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactsRepo = ContactsRepository();
    final sendFormCubit = context.read<SendFormCubit>();
    final phoneNumberController = TextEditingController(
      text:
          context.select<SendFormCubit, String>((c) => c.state.recipient.value),
    );
    return FutureBuilder<List<Contact>>(
      future: contactsRepo.getAllContacts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TextField(
            key: const Key('phone_number_textField'),
            controller: phoneNumberController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.contacts),
                onPressed: () => showModalBottomSheet<Widget>(
                  context: context,
                  builder: (context) => ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (_, int idx) {
                      final contact = snapshot.data![idx];
                      return ListTile(
                        title: Text(
                          contact.displayName ??
                              contact.givenName ??
                              contact.familyName ??
                              '',
                        ),
                        onTap: () => showModalBottomSheet<Widget>(
                          context: context,
                          builder: (_) => ListView.builder(
                            itemCount: contact.phones?.length ?? 0,
                            itemBuilder: (_, int idx) {
                              final phone = contact.phones![idx];
                              return ListTile(
                                title: Text(phone.label ?? ''),
                                subtitle: Text(phone.value ?? ''),
                                onTap: () {
                                  sendFormCubit.setAddressFromPhoneNumber(
                                    phone.value!,
                                  );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return const Loading();
      },
    );
  }
}
