import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Barbearias'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              buildBarberShopWidget(
                  'https://down-br.img.susercontent.com/file/17b89d92753e6eeeff8c30fe39fc4910',
                  'Santo Amaro',
                  '18:00hs',
                  'BARBEARIA DO BIDOU'),
              SizedBox(height: 16.0),
              buildBarberShopWidget(
                  'https://down-br.img.susercontent.com/file/17b89d92753e6eeeff8c30fe39fc4910',
                  'Santo Amaro',
                  '20:00hs',
                  'A Navalha Afiada'),
              SizedBox(height: 16.0),
              buildBarberShopWidget(
                  'https://down-br.img.susercontent.com/file/17b89d92753e6eeeff8c30fe39fc4910',
                  'Santo Amaro',
                  '18:00hs',
                  'O Barbeiro Fino'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Alternando entre o modo claro e escuro
                  setState(() {
                    isDarkMode = !isDarkMode;
                  });
                },
                child: Text(isDarkMode ? 'Modo Claro' : 'Modo Escuro'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar o widget da barbearia
  Widget buildBarberShopWidget(String imageUrl, String location,
      String openingHours, String barberShopName) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 16.0),
        // Adicionando o título, nome e descrição
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Localização: $location',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Aberto até as: $openingHours',
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(height: 8.0),
            Text(
              barberShopName,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(child: const Text('Mais'), onPressed: () {})
              ],
            )
          ],
        ),
      ],
    );
  }
}
