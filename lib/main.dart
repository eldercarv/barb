import 'package:barbearia/Home.dart';
import 'package:barbearia/loginCadastro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  runApp(Principal());
}

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white, brightness: Brightness.dark),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

 Future<void> login(BuildContext context) async {
  // Verifica se os campos de e-mail e senha estão vazios
  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    _showSnackBar(context, 'Por favor, preencha todos os campos.');
    return;
  }

  // Verifica se os dados de entrada estão sendo capturados corretamente
  print('Email: ${_emailController.text}');
  print('Senha: ${_passwordController.text}');

  try {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (userCredential.user != null) {
      print('Login bem-sucedido.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  } catch (e) {
    print('Erro de login: $e');
    _showSnackBar(context, 'Senha Errada');
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbearia'),
      ),
      body: Center(
        child: SingleChildScrollView(
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
              Text(
                'Seu App para Cortes ',
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
              ),
              SizedBox(height: 20),
              Container(
                width: 250,
                child: TextField(
                  controller: _emailController,
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
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Senha',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    child: const Text('Entrar'),
                    onPressed: () {
                      login(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Cadastrar'),
                    onPressed: () {
                      _loginCadastro(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginCadastro(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginCadastro()),
    );
  }
}
