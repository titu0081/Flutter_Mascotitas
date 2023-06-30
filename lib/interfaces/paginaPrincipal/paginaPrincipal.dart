import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../componentes/animationBarNav/navegacion.dart';
import '../../componentes/animationBarNav/navegacionVistas.dart';
import '../../utilidades/colores.dart';
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
    NavegacionVistas(),
    const BuscarMascotas(),
    const ChatUsuarios(),
    const Usuario(),
  ];

  int _indiceActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#1575b3"),
              hexStringToColor("#00ffef"),
              hexStringToColor("#37d0d1"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: pantallas[_indiceActual],
      ),
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
