import 'package:flutter/material.dart';
import '../../componentes/animationBarNav/navegacion.dart';
import '../../componentes/animationBarNav/navegacionVistas.dart';
import '../buscar/buscarMascotas.dart';
import '../chat/chatUsuarios.dart';
import '../usuario/usuario.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> pantallas = [
    const NavegacionVistas(),
    const BuscarMascotas(),
    const ChatUsuarios(),
    const Usuario(),
  ];

  int _indiceActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pantallas[_indiceActual],
      bottomNavigationBar: NavegacionPrincipal(
        onNavSelect: (navIndex) {
          setState(() {
            _indiceActual = navIndex;
          });
        },
      ),
    );
  }
}
