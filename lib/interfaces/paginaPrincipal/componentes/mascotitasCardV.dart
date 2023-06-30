import 'package:flutter/material.dart';
import '../../../models/mascotasModeloFirebase.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../widgets_Reusables/widgetReusable.dart';

class MascotasCardR extends StatelessWidget {
  const MascotasCardR({
    Key? key,
    required this.mascotasR,
    required this.onTap,
  }) : super(key: key);

  final MascotitasM mascotasR;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        decoration: BoxDecoration(
          color: mascotasR.color,
          borderRadius: const BorderRadius.all(Radius.circular(35)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: SizedBox(
                width: 150,
                height: 150,
                child: CachedNetworkImage(
                  imageUrl: mascotasR.imagen.toString(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => cargandoImagenes(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 10),
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
                  Text(
                    mascotasR.area,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    mascotasR.sexo,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
