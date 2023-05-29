import 'package:flutter/material.dart';
import 'package:mascotitas/componentes/animationBarNav/animationButtonBar.dart';
import 'package:mascotitas/interfaces/paginaPrincipal/home.dart';
import 'package:mascotitas/tema.dart';
import 'interfaces/buscar/buscarMascotas.dart';
import 'interfaces/chat/chatUsuarios.dart';
import 'interfaces/inicioSesion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'interfaces/paginaPrincipal/paginaPrincipal.dart';
import 'interfaces/usuario/administrarMascotas/registrarMascota.dart';
import 'interfaces/usuario/usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mascotitas',
      theme: TemaAplicacion.lightTheme,
      darkTheme: TemaAplicacion.darkTheme,
      home: const Home(),
      routes: {
        '/buscar': (context) => const BuscarMascotas(),
        '/chat': (context) => const ChatUsuarios(),
        '/usuario': (context) => const Usuario(),
      },
    );
  }
}
