import 'package:flutter/material.dart';

import '../../../models/mascotasM.dart';

class MascotasCard extends StatelessWidget {
  const MascotasCard({
    super.key,
    required this.mascotas,
  });

  final MascotitasModel mascotas;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 280,
      width: 260,
      decoration: BoxDecoration(
        color: mascotas.fondoColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  mascotas.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: SizedBox(
                    height: 180,
                    width: 180,
                    child: Image.asset(
                      mascotas.src,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
