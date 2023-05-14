import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../interfaces/paginaPrincipal/componentes/mascotasCard.dart';
import '../../interfaces/paginaPrincipal/componentes/mascotasCard2.dart';
import '../../interfaces/paginaPrincipal/componentes/mascotitasCard.dart';
import '../../interfaces/paginaPrincipal/componentes/mascotitasCardV.dart';
import '../../models/mascotasM.dart';
import '../../models/mascotasModelo.dart';
import '../../tema.dart';
import '../../utilidades/colores.dart';

class NavegacionVistas extends StatefulWidget {
  const NavegacionVistas({super.key});

  @override
  State<NavegacionVistas> createState() => _NavegacionVistasState();
}

class _NavegacionVistasState extends State<NavegacionVistas> {
  final List<MascotitasM> mascotas1 = MascotitasM.mascotas;
  final List<MascotitasM> mascotasR = MascotitasM.mascotasRecent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("#1575b3"),
          hexStringToColor("#00ffef"),
          hexStringToColor("#37d0d1"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
              top: MediaQuery.of(context).padding.top),
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
                  children: mascotas1
                      .map(
                        (mascotas1) => Padding(
                          key: mascotas1.id,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: MascotitasCard1(mascotas: mascotas1),
                        ),
                      )
                      .toList(),
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
              ...List.generate(
                mascotasR.length,
                (index) => Padding(
                    key: mascotasR[index].id,
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: MascotasCardR(mascotasR: mascotasR[index])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
