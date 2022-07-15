// ignore: leading_newlines_in_multiline_strings

// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:mysarafu/model/db/account.dart';
import 'package:mysarafu/model/db/contact.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:web3dart/web3dart.dart';

class DBHelper {
  DBHelper();
  static const int dbVersion = 1;
  static const String contactsSql = '''
CREATE TABLE Contacts(  
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        address TEXT, 
        monkey_path TEXT)''';
  static const String accountsSql = '''
CREATE TABLE Accounts( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        acct_index INTEGER, 
        selected INTEGER, 
        last_accessed INTEGER,
        private_key TEXT,
        balance TEXT)''';
  static const String accountsAddAccountColumnSqlL = '''
    ALTER TABLE Accounts ADD address TEXT
    ''';
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'sarafu.db');
    final theDb = await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return theDb;
  }

  Future<void> _onCreate(Database db, int version) async {
    // When creating the db, create the tables
    await db.execute(contactsSql);
    await db.execute(accountsSql);
    await db.execute(accountsAddAccountColumnSqlL);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1) {
      // Add accounts table
      await db.execute(accountsSql);
      await db.execute(accountsAddAccountColumnSqlL);
    } else if (oldVersion == 2) {
      await db.execute(accountsAddAccountColumnSqlL);
    }
  }

  // Contacts
  Future<List<Contact>> getContacts() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM Contacts ORDER BY name');
    final contacts = <Contact>[];
    for (var i = 0; i < list.length; i++) {
      contacts.add(Contact.fromJson(list[i]));
    }
    return contacts;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list = await dbClient.rawQuery(
      "SELECT * FROM Contacts WHERE name LIKE '%$pattern%' ORDER BY LOWER(name)",
    );
    final contacts = <Contact>[];
    for (var i = 0; i < list.length; i++) {
      contacts.add(
        Contact.fromJson(list[i]),
      );
    }
    return contacts;
  }

  Future<Contact?> getContactWithAddress(String address) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list = await dbClient.rawQuery(
      "SELECT * FROM Contacts WHERE address like '%$address'",
    );
    if (list.isNotEmpty) {
      return Contact.fromJson(list[0]);
    }
    return null;
  }

  Future<Contact?> getContactWithName(String name) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list = await dbClient
        .rawQuery('SELECT * FROM Contacts WHERE name = ?', [name]);
    if (list.isNotEmpty) {
      return Contact.fromJson(list[0]);
    }
    return null;
  }

  Future<bool> contactExistsWithName(String name) async {
    final dbClient = await db;
    final count = Sqflite.firstIntValue(
      await dbClient.rawQuery(
        'SELECT count(*) FROM Contacts WHERE lower(name) = ?',
        [name.toLowerCase()],
      ),
    );
    return count != null && count > 0;
  }

  Future<bool> contactExistsWithAddress(String address) async {
    final dbClient = await db;
    final count = Sqflite.firstIntValue(
      await dbClient.rawQuery(
        "SELECT count(*) FROM Contacts WHERE lower(address) like '%$address'",
      ),
    );
    return count != null && count > 0;
  }

  Future<int> saveContact(Contact contact) async {
    final dbClient = await db;
    return dbClient.rawInsert(
      'INSERT INTO Contacts (name, address) values(?, ?)',
      [contact.name],
    );
  }

  Future<int> saveContacts(List<Contact> contacts) async {
    var count = 0;
    for (final c in contacts) {
      if (await saveContact(c) > 0) {
        count++;
      }
    }
    return count;
  }

  Future<bool> deleteContact(Contact contact) async {
    final dbClient = await db;
    final deleteCount = await dbClient.rawDelete(
      "DELETE FROM Contacts WHERE lower(address) like '%${contact.address}'",
    );
    return deleteCount > 0;
  }

  // Accounts
  Future<List<Account>> getAccounts(String seed) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM Accounts ORDER BY acct_index');
    final accounts = <Account>[];
    for (var i = 0; i < list.length; i++) {
      accounts.add(
        Account.fromJson(list[i]),
      );
    }
    return accounts;
  }

  Future<List<Account>> getRecentlyUsedAccounts(
    String seed, {
    int limit = 2,
  }) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list = await dbClient.rawQuery(
      'SELECT * FROM Accounts WHERE selected != 1 ORDER BY last_accessed DESC, acct_index ASC LIMIT ?',
      [limit],
    );
    final accounts = <Account>[];
    for (var i = 0; i < list.length; i++) {
      accounts.add(
        Account.fromJson(list[i]),
      );
    }
    // accounts.forEach((a) {
    //   a.address = NanoUtil.seedToAddress(seed, a.index);
    // });
    return accounts;
  }

  Future<Account?> addAccount(
    EthereumAddress address, {
    required String nameBuilder,
    required String encryptedWallet,
  }) async {
    final dbClient = await db;
    Account? account;
    await dbClient.transaction((txn) async {
      var nextIndex = 1;
      int curIndex;
      final List<Map<String, dynamic>> accounts = await txn.rawQuery(
        'SELECT * from Accounts WHERE acct_index > 0 ORDER BY acct_index ASC',
      );
      for (var i = 0; i < accounts.length; i++) {
        curIndex = accounts[i]['acct_index'] as int;
        if (curIndex != nextIndex) {
          break;
        }
        nextIndex++;
      }
      final nextID = nextIndex + 1;
      final nextName = nameBuilder.replaceAll('%1', nextID.toString());
      account = Account(
        index: nextIndex,
        name: nextName,
        encryptedWallet: encryptedWallet,
        address: address,
        balance: '',
        id: -1,
      );
      await txn.rawInsert(
          'INSERT INTO Accounts (name, acct_index, last_accessed, selected, address) values(?, ?, ?, ?, ?)',
          [
            account!.name,
            account!.index,
            account!.lastAccess,
            if (account!.selected) 1 else 0,
            account!.address
          ]);
    });
    return account;
  }

  Future<int> deleteAccount(Account account) async {
    final dbClient = await db;
    return dbClient.rawDelete(
      'DELETE FROM Accounts WHERE acct_index = ?',
      [account.index],
    );
  }

  Future<int> saveAccount(Account account) async {
    final dbClient = await db;
    return dbClient.rawInsert(
        'INSERT INTO Accounts (name, acct_index, last_accessed, selected) values(?, ?, ?, ?)',
        [
          account.name,
          account.index,
          account.lastAccess,
          if (account.selected) 1 else 0
        ]);
  }

  Future<int> changeAccountName(Account account, String name) async {
    final dbClient = await db;
    return dbClient.rawUpdate(
      'UPDATE Accounts SET name = ? WHERE acct_index = ?',
      [name, account.index],
    );
  }

  Future<void> changeAccount(Account account) async {
    final dbClient = await db;
    return dbClient.transaction((txn) async {
      await txn.rawUpdate('UPDATE Accounts set selected = 0');
      // Get access increment count
      final List<Map> list = await txn
          .rawQuery('SELECT max(last_accessed) as last_access FROM Accounts');
      await txn.rawUpdate(
        'UPDATE Accounts set selected = ?, last_accessed = ? where acct_index = ?',
        [1, (list[0]['last_access'] as int) + 1, account.index],
      );
    });
  }

  Future<int> updateAccountBalance(Account account, String balance) async {
    final dbClient = await db;
    return dbClient.rawUpdate(
      'UPDATE Accounts set balance = ? where acct_index = ?',
      [balance, account.index],
    );
  }

  Future<Account?> getSelectedAccount() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM Accounts where selected = 1');
    if (list.isEmpty) {
      return null;
    }
    final account = Account.fromJson(list[0]);
    return account;
  }

  Future<Account?> getMainAccount(String seed) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> list =
        await dbClient.rawQuery('SELECT * FROM Accounts where acct_index = 0');
    if (list.isEmpty) {
      return null;
    }
    final account = Account.fromJson(list[0]);
    return account;
  }

  Future<int> dropAccounts() async {
    final dbClient = await db;
    return dbClient.rawDelete('DELETE FROM ACCOUNTS');
  }
}
