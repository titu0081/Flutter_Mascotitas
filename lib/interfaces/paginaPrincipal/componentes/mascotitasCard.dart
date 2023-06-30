import 'package:flutter/src/widgets/framework.dart';
import 'package:mascotitas/models/mascotasModeloFirebase.dart';
import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

import '../../../widgets_Reusables/widgetReusable.dart';

class MascotitasCard1 extends StatefulWidget {
  const MascotitasCard1({super.key, required this.mascotas, this.onPressed});
  final VoidCallback? onPressed;

  final MascotitasM mascotas;

  @override
  State<MascotitasCard1> createState() => _MascotitasCard1State();
}

class _MascotitasCard1State extends State<MascotitasCard1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 280,
        width: 260,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: widget.mascotas.color.withOpacity(0.5),
                offset: const Offset(3, 0),
                blurRadius: 2,
              ),
              BoxShadow(
                color: widget.mascotas.color.withOpacity(0.5),
                offset: const Offset(0, 8),
                blurRadius: 7,
              )
            ]),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.mascotas.nombre,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: SizedBox(
                      height: 210,
                      width: 210,
                      child: CachedNetworkImage(
                        imageUrl: widget.mascotas.imagen.toString(),
                        fit: BoxFit.fill,
                        placeholder: (context, url) => cargandoImagenes(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
