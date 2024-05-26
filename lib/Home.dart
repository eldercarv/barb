import 'package:barbearia/cadastro.dart';
import 'package:barbearia/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// void main() => runApp(const Home());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white, brightness: Brightness.dark),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  bool isProfileSelected = false;
  List<BarberShop> barberShops = [];

  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBarberShops();
    });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Erro ao deslogar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            isProfileSelected = index == 1;
          });
        },
        indicatorColor: Colors.black12,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.store)),
            label: 'Perfil',
          ),
        ],
      ),
      body: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const BarberShopRegistrationScreen(),
                    ),
                  );
                },
                child: const Text('Cadastrar Barbearia'),
              )
              // Adicione o conteúdo da página inicial aqui
            ],
          ),
        ),
        currentPageIndex == 1
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    await _logout();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Principal()),
                    );
                  },
                  child: const Card(
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Deslogar'),
                      subtitle: Text('Até a próxima'),
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BarberShopRegistrationScreen(),
                        ),
                      );
                      _getBarberShops();
                    },
                    child: const Text('Cadastrar Barbearia'),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Barbearias Cadastradas:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: barberShops.length,
                      itemBuilder: (BuildContext context, int index) {
                        final barberShop = barberShops[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(barberShop.imageUrl),
                          ),
                          title: Text(barberShop.name),
                          subtitle: Text(barberShop.location),
                        );
                      },
                    ),
                  ),
                ],
              ),
        ListView.builder(
          reverse: true,
          itemCount: barberShops.length,
          itemBuilder: (BuildContext context, int index) {
            final barberShop = barberShops[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(barberShop.imageUrl),
              ),
              title: Text(barberShop.name),
              subtitle: Text(barberShop.location),
            );
            // if (index == 0) {
            //   return Align(
            //     alignment: Alignment.centerRight,
            //     child: Container(
            //       margin: const EdgeInsets.all(8.0),
            //       padding: const EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //         color: theme.colorScheme.primary,
            //         borderRadius: BorderRadius.circular(8.0),
            //       ),
            //       child: Text(
            //         barberShop.name,
            //         style: theme.textTheme.bodyLarge!
            //             .copyWith(color: theme.colorScheme.onPrimary),
            //       ),
            //     ),
            //   );
            // }
            // return Container();
          },
        ),
      ][currentPageIndex],
    );
  }

  void _getBarberShops() async {
    final snapshot = await FirebaseDatabase.instance.ref('barbearias').get();
    final List<BarberShop> barberShops = [];

    if (snapshot.exists) {
      final data = snapshot.value;
      var barbersMap = Map<String, dynamic>.from(data as Map);

      barbersMap.forEach((key, value) {
        final json = Map<String, dynamic>.from(data[key] as Map);
        barberShops.add(BarberShop.fromMap(json));
      });

      setState(() => this.barberShops = barberShops);
    }
  }
}
