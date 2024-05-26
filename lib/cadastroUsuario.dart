import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class BarberShop {
  String name;
  String location;
  String openingHours;
  String imageUrl;

  BarberShop({
    required this.name,
    required this.location,
    required this.openingHours,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'openingHours': openingHours,
      'imageUrl': imageUrl,
    };
  }

  factory BarberShop.fromJson(Map<String, dynamic> json) {
    return BarberShop(
      name: json['name'],
      location: json['location'],
      openingHours: json['openingHours'],
      imageUrl: json['imageUrl'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Barbearias',
      theme: ThemeData(primaryColor: Colors.white, brightness: Brightness.dark),
      home: BarberShopRegistrationScreen(),
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
    // Carrega os dados do arquivo JSON ao iniciar a tela
    loadBarberShops();
  }

  Future<void> loadBarberShops() async {
    try {
      final file = File('barber.json');
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(contents);
        setState(() {
          barberShops = jsonList.map((json) => BarberShop.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print('Erro ao carregar dados do arquivo JSON: $e');
    }
  }

  Future<void> saveBarberShops() async {
  final file = File('barber.json');
  try {
    final jsonList = barberShops.map((barberShop) => barberShop.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
    print('Dados salvos com sucesso: $jsonList');
  } catch (e) {
    print('Erro ao salvar dados no arquivo JSON: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Barbearias'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome da Barbearia'),
            ),
            SizedBox(height: 16.0, width: 250),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Localização'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: openingHoursController,
              decoration:
                  InputDecoration(labelText: 'Horário de Funcionamento'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (imageUrlController.text.isNotEmpty) {
                    barberShops.add(
                      BarberShop(
                        name: nameController.text,
                        location: locationController.text,
                        openingHours: openingHoursController.text,
                        imageUrl: imageUrlController.text,
                      ),
                    );
                    // Limpa os campos após o cadastro
                    nameController.clear();
                    locationController.clear();
                    openingHoursController.clear();
                    imageUrlController.clear();
                    // Salva os dados no arquivo JSON
                    saveBarberShops();
                  } else {
                    print('Por favor, insira uma URL de imagem.');
                  }
                });
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
                    onTap: () {
                      // Ação ao tocar na barbearia (opcional)
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}