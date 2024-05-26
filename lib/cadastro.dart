import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BarberShop {
  String id;
  String name;
  String location;
  String openingHours;
  String imageUrl;

  BarberShop({
    required this.id,
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
  const BarberShopRegistrationScreen({super.key});

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
  TextEditingController whatsappController = TextEditingController();

  List<BarberShop> barberShops = [];

  @override
  void initState() {
    super.initState();
    // _loadBarberShops();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DatabaseReference ref = FirebaseDatabase.instance.ref('barbearias');

      ref.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value;

        if (data != null) {
          var barbersMap = Map<String, dynamic>.from(data as Map);

          final List<BarberShop> barberShops = [];

          barbersMap.forEach((key, value) {
            final json = Map<String, dynamic>.from(data[key] as Map);
            barberShops.add(BarberShop.fromMap(json));
          });

          setState(() {
            this.barberShops = barberShops;
          });
        }
      });
    });
  }

  // Future<void> _loadBarberShops() async {
  // final dbHelper = DatabaseHelper();
  // dbHelper.initDatabase();

  // try {
  //   final data = await dbHelper.getBarberShops();
  //   print('Loaded data: $data');
  //   setState(() {
  //     barberShops = data.map((item) => BarberShop.fromMap(item)).toList();
  //   });
  // } catch (error) {
  //   print('Error loading barbershops: $error');
  // }
  // }

  Future<void> _saveBarberShop() async {
    try {
      var uuid = const Uuid();
      final barberId = uuid.v4();

      final ref = FirebaseDatabase.instance.ref('barbearias/$barberId');

      await ref.set({
        'id': barberId,
        'name': nameController.text,
        'location': locationController.text,
        'openingHours': openingHoursController.text,
        'imageUrl': imageUrlController.text,
        'whatsapp': whatsappController.text,
      });

      nameController.clear();
      locationController.clear();
      openingHoursController.clear();
      imageUrlController.clear();
      whatsappController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Barbearia cadastrada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
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
          title: const Text('Cadastro de Barbearias'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: 'Nome da Barbearia'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Localização'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: openingHoursController,
                decoration: const InputDecoration(
                    labelText: 'Horário de Funcionamento'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: whatsappController,
                decoration: const InputDecoration(labelText: 'Whatsapp'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await _saveBarberShop();
                },
                child: const Text('Cadastrar'),
              ),
              const SizedBox(height: 32.0),
              const Text(
                'Barbearias Cadastradas:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
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

// void main() {
//   runApp(BarberShopRegistrationScreen());
// }
