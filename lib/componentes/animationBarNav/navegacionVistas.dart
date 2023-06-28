import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mascotitas/interfaces/paginaPrincipal/detalleMascota.dart';
import '../../interfaces/paginaPrincipal/componentes/mascotitasCard.dart';
import '../../interfaces/paginaPrincipal/componentes/mascotitasCardV.dart';
import '../../models/mascotasModeloFirebase.dart';
import '../../utilidades/colores.dart';

class NavegacionVistas extends StatefulWidget {
  const NavegacionVistas({super.key});

  @override
  State<NavegacionVistas> createState() => _NavegacionVistasState();
}

class _NavegacionVistasState extends State<NavegacionVistas> {
  late Future<List<MascotitasM>> _mascotasFuture;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _mascotasFuture = _cargarMascotas();
  }

  Future<List<MascotitasM>> _cargarMascotas() async {
    final user = _auth.currentUser;
    await MascotitasM.getMascotasExceptoDueno(user!.uid);
    return MascotitasM.mascotasSinDueno;
  }

  void abrirMascota(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleMascota(
            idMascota: id), // Redirige a la pantalla de detalle de la mascota
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#1575b3"),
              hexStringToColor("#00ffef"),
              hexStringToColor("#37d0d1"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
            top: MediaQuery.of(context).padding.top,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "MASCOTITAS",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              FutureBuilder<List<MascotitasM>>(
                future: _mascotasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error al cargar las mascotas');
                  } else {
                    final mascotas1 = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: mascotas1
                            .take(5) // Limita la lista a 5 mascotas
                            .map(
                              (mascota) => GestureDetector(
                                onTap: () {
                                  abrirMascota(mascota.id);
                                },
                                child: Padding(
                                  key: ValueKey<String>(mascota.id),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: MascotitasCard1(mascotas: mascota),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "TODAS LAS MASCOTAS",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              FutureBuilder<List<MascotitasM>>(
                future: _mascotasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('Error al cargar las mascotas');
                  } else {
                    final mascotasR = snapshot.data!;
                    return Column(
                      children: mascotasR
                          .map(
                            (mascota) => Padding(
                              key: ValueKey<String>(mascota.id),
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                bottom: 20,
                              ),
                              child: MascotasCardR(
                                mascotasR: mascota,
                                onTap: () {
                                  abrirMascota(mascota.id);
                                },
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
