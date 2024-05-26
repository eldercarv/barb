import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DatabaseHelper {
  late Database _database;

  Future<void> initDatabase() async {
    // Open the database
    final dbPath = 'barber_shops.db';
    final dbFactory = databaseFactoryIo;
    _database = await dbFactory.openDatabase(dbPath);

    // Create the store to hold barber shop data
    final store = intMapStoreFactory.store('barber_shops');

    // Check if the store already exists
    final count = await store.count(_database);
    if (count == 0) {
      // If not, create it
      await store.add(_database, {});
    }
  }

  Future<void> insertBarberShop(Map<String, dynamic> barberShopData) async {
    if (_database == null) {
      throw Exception("Banco de dados não inicializado");
    }

    final store = intMapStoreFactory.store('barber_shops');
    await store.add(_database, barberShopData);
  }

  Future<List<Map<String, dynamic>>> getBarberShops() async {
    if (_database == null) {
      throw Exception("Banco de dados não inicializado");
    }

    final store = intMapStoreFactory.store('barber_shops');
    final snapshots = await store.find(_database);

    return snapshots.map((snapshot) => snapshot.value).toList();
  }
}
