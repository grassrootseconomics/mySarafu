import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsRepository {
  ContactsRepository();

  Future<List<Contact>> getAllContacts({bool withThumbnails = false}) async {
    await askForPermission();
    final contacts =
        await ContactsService.getContacts(withThumbnails: withThumbnails);
    return contacts;
  }

  Future<List<Contact>> searchContacts(String query) async {
    await askForPermission();
    return ContactsService.getContacts(query: query);
  }

  Future<void> askForPermission() async {
    if (await Permission.contacts.request().isGranted) {
      return;
    }
    final status = await Permission.contacts.request();
    if (status.isGranted) {
      return;
    } else {
      throw Exception('Permission denied');
    }
  }
}
