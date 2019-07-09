import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';

class DBHelper{
  static const int DB_VERSION = 1;
  static const String CONTACTS_SQL =
    """CREATE TABLE Contacts( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT, 
        account INTEGER, 
        payload TEXT)""";

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "blaise.db");
    var theDb = await openDatabase(path, version: DB_VERSION, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the tables
    await db.execute(CONTACTS_SQL);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    return;
  }

  // Contacts
  Future<List<Contact>> getContacts() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Contacts ORDER BY name');
    List<Contact> contacts = new List();
    for (int i = 0; i < list.length; i++) {
      contacts.add(new Contact(id: list[i]["id"], name: list[i]["name"], account: AccountNumber.fromInt(list[i]["account"]), payload: list[i]["payload"]));
    }
    return contacts;
  }

  Future<List<Contact>> getContactsWithNameLike(String pattern) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Contacts WHERE name LIKE \'%$pattern%\' ORDER BY LOWER(name)');
    List<Contact> contacts = new List();
    for (int i = 0; i < list.length; i++) {
      contacts.add(new Contact(id: list[i]["id"], name: list[i]["name"], account: AccountNumber.fromInt(list[i]["account"]), payload: list[i]["payload"]));
    }
    return contacts;
  }

  Future<Contact> getContactWithAccount(AccountNumber account) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Contacts WHERE account = ?', [account.account]);
    if (list.length > 0) {
      return Contact(id: list[0]["id"], name: list[0]["name"], account: AccountNumber.fromInt(list[0]["account"]), payload: list[0]["payload"]);
    }
    return null;
  }

  Future<Contact> getContactWithName(String name) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Contacts WHERE name = ?', [name]);
    if (list.length > 0) {
      return Contact(id: list[0]["id"], name: list[0]["name"], account: AccountNumber.fromInt(list[0]["account"]), payload: list[0]["payload"]);
    }
    return null;
  }

  Future<bool> contactExistsWithName(String name) async {
    var dbClient = await db;
    int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT count(*) FROM Contacts WHERE lower(name) = ?', [name.toLowerCase()]));
    return count > 0;
  }

  Future<bool> contactExistsWithAccount(AccountNumber account) async {
    var dbClient = await db;
    int count = Sqflite.firstIntValue(await dbClient.rawQuery('SELECT count(*) FROM Contacts WHERE account = ?', [account.account]));
    return count > 0;
  }

  Future<int> saveContact(Contact contact) async {
    var dbClient = await db;
    return await dbClient.rawInsert('INSERT INTO Contacts (name, account, payload) values(?, ?, ?)', [contact.name, contact.account.account, contact.payload]);
  }

  Future<int> saveContacts(List<Contact> contacts) async {
    int count = 0;
    for (Contact c in contacts) {
      if (await saveContact(c) > 0) {
        count++;
      }
    }
    return count;
  }

  Future<bool> deleteContact(Contact contact) async {
    var dbClient = await db;
    return await dbClient.rawDelete("DELETE FROM Contacts WHERE account = ?", [contact.account.account]) > 0;
  }
}