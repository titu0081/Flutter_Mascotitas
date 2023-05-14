import 'package:flutter/material.dart';
import 'package:mascotitas/interfaces/inicioSesion.dart';
import '../../componentes/animationBarNav/animationButtonBar.dart';
import '../../models/mascotasM.dart';
import '../../utilidades/colores.dart';
import '../../widgets_Reusables/widgetReusable.dart';
import 'componentes/mascotasCard.dart';
import 'componentes/mascotasCard2.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipal();
}

class _PaginaPrincipal extends State<PaginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("#1575b3"),
          hexStringToColor("#00ffef"),
          hexStringToColor("#37d0d1"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("MASCOTITAS",
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...mascotas
                          .map((mascotas) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: MascotasCard(mascotas: mascotas),
                              ))
                          .toList(),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Text(
                    "RECIENTES",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                ...mascotasRecientes.map(
                  (mascotas) => Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: MascotasCard2(mascotas: mascotas)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
