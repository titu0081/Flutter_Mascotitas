import 'package:flutter/material.dart';

class BarraAnimada extends StatelessWidget {
  const BarraAnimada({
    super.key,
    required this.estaActivo,
  });

  final bool estaActivo;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 5,
      width: estaActivo ? 24 : 0,
      margin: const EdgeInsets.fromLTRB(0, 7, 0, 3),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 145, 0, 1),
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    );
  }
}
