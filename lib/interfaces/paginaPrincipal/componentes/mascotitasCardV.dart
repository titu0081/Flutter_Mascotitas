import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../models/mascotasModeloFirebase.dart';
import '../../../widgets_Reusables/widgetReusable.dart';

class MascotasCardR extends StatelessWidget {
  const MascotasCardR({super.key, required this.mascotasR});

  final MascotitasM mascotasR;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        color: mascotasR.color,
        borderRadius: const BorderRadius.all(Radius.circular(35)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    mascotasR.nombre,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        mascotasR.area,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        mascotasR.sexo,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
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
        ],
      ),
    );
  }
}
