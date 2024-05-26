import 'package:flutter/material.dart';
import 'database_helper.dart';

class BarberShop {
  int? id;
  String name;
  String location;
  String openingHours;
  String imageUrl;

  BarberShop({
    this.id,
    required this.name,
    required this.location,
    required this.openingHours,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'openingHours': openingHours,
      'imageUrl': imageUrl,
    };
  }

  static BarberShop fromMap(Map<String, dynamic> map) {
    return BarberShop(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      openingHours: map['openingHours'],
      imageUrl: map['imageUrl'],
    );
  }
}

class BarberShopRegistrationScreen extends StatefulWidget {
  @override
  _BarberShopRegistrationScreenState createState() =>
      _BarberShopRegistrationScreenState();
}

class _BarberShopRegistrationScreenState
    extends State<BarberShopRegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController openingHoursController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  List<BarberShop> barberShops = [];

  @override
  void initState() {
    super.initState();
    _loadBarberShops();
  }

  Future<void> _loadBarberShops() async {
    final dbHelper = DatabaseHelper();
    try {
      final data = await dbHelper.getBarberShops();
      print('Loaded data: $data');
      setState(() {
        barberShops = data.map((item) => BarberShop.fromMap(item)).toList();
      });
    } catch (error) {
      print('Error loading barbershops: $error');
    }
  }

  Future<void> _saveBarberShop() async {
    final dbHelper = DatabaseHelper();
    final newBarberShop = BarberShop(
      name: nameController.text,
      location: locationController.text,
      openingHours: openingHoursController.text,
      imageUrl: imageUrlController.text,
    );

    print('Saving new barbershop: ${newBarberShop.toMap()}');
    try {
      await dbHelper.insertBarberShop(newBarberShop.toMap());
      _loadBarberShops();
      nameController.clear();
      locationController.clear();
      openingHoursController.clear();
      imageUrlController.clear();
    } catch (error) {
      print('Error saving barbershop: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Barbearias',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Barbearias'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nome da Barbearia'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Localização'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: openingHoursController,
                decoration:
                    InputDecoration(labelText: 'Horário de Funcionamento'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _saveBarberShop();
                },
                child: Text('Cadastrar'),
              ),
              SizedBox(height: 32.0),
              Text(
                'Barbearias Cadastradas:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: barberShops.map((barberShop) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(barberShop.imageUrl),
                      ),
                      title: Text(barberShop.name),
                      subtitle: Text(barberShop.location),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(BarberShopRegistrationScreen());
}
