import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascotitas/models/mascotasM.dart';
import 'package:mascotitas/widgets_Reusables/widgetReusable.dart';

class MascotasCard2 extends StatelessWidget {
  const MascotasCard2({
    super.key,
    required this.mascotas,
  });

  final MascotitasModel mascotas;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        color: mascotas.fondoColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            children: [
              Text(
                mascotas.title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                "Area",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),
              Text(
                "Sexo",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(
          child: VerticalDivider(
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        MouseRegion(
          child: btnAdoptar(context, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Botón adoptar presionado'),
              ),
            );
          }),
        ),
      ]),
    );
  }
}
