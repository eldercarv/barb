import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barbearia/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa o Firebase
  runApp(loginCadastro());
}

class loginCadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white, brightness: Brightness.dark),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Barbearia',
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          // Adiciona um SingleChildScrollView para evitar overflow de conteúdo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://down-br.img.susercontent.com/file/17b89d92753e6eeeff8c30fe39fc4910',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                child: Text(
                  'Crie sua conta',
                  style: TextStyle(color: Colors.blue, fontSize: 20.0),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                child: TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Usuário',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 250,
                child: TextField(
                  controller: _senhaController,
                  obscureText: true, // Oculta a senha
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Senha',
                  ),
                ),
              ),
              Container(
                width: 250,
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    child: const Text(
                      'Criar Conta',
                    ),
                    onPressed: () {
                      cadastrar(
                          context); // Passa o contexto para a função cadastrar
                    },
                  ),
                  TextButton(
                      child: const Text('Fazer Login'),
                      onPressed: () {
                        main();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  cadastrar(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _senhaController.text);

      await userCredential.user!.updateDisplayName(_nomeController.text);

      // Após criar a conta com sucesso, navega para a próxima página
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Principal()), // Substitua ChecagemPage() pela próxima página
        (route) => false,
      );
    } catch (e) {
      print('Erro ao cadastrar: $e'); // Imprime o erro completo
      // Tratamento de erro ao cadastrar
    }
  }
}
