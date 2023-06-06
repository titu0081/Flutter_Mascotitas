import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mascotitas/tema.dart';
import 'interfaces/buscar/buscarMascotas.dart';
import 'interfaces/chat/chatUsuarios.dart';
import 'interfaces/inicioSesion.dart';
import 'interfaces/paginaPrincipal/paginaPrincipal.dart';
import 'interfaces/usuario/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Widget initialScreen = isLoggedIn ? const Home() : const IniciarSesion();

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen; // Agrega el campo initialScreen

  const MyApp({Key? key, required this.initialScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mascotitas',
      theme: TemaAplicacion.lightTheme,
      darkTheme: TemaAplicacion.darkTheme,
      home: initialScreen, // Usa el initialScreen proporcionado
      routes: {
        '/buscar': (context) => const BuscarMascotas(),
        '/chat': (context) => const ChatUsuarios(),
        '/usuario': (context) => const Usuario(),
      },
    );
  }
}
