import 'package:flutter/material.dart';
import 'package:mascotitas/interfaces/inicioSesion.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipal();
}

class _PaginaPrincipal extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: const Text("Cerrar Sesión"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IniciarSesion()));
          }),
    );
  }
}
