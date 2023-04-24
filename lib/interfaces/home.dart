import 'package:flutter/material.dart';
import 'package:mascotitas/interfaces/inicioSesion.dart';
import '../componentes/animationBarNav/animationButtonBar.dart';
import '../widgets_Reusables/widgetReusable.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipal();
}

class _PaginaPrincipal extends State<PaginaPrincipal> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Cerrar Sesión"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IniciarSesion()));
          },
        ),
      ),
      bottomNavigationBar: const MenuInferior1(),
    );
  }
}
