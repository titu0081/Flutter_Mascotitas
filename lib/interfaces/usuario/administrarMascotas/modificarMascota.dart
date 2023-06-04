import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascotitas/interfaces/usuario/administrarMascotas/componentes/cardMascota.dart';
import 'package:mascotitas/interfaces/usuario/administrarMascotas/editarMascotas.dart';
import '../../../models/mascotasModeloFirebase.dart';
import '../../../utilidades/colores.dart';

class ModificarMascota extends StatefulWidget {
  const ModificarMascota({super.key});

  @override
  State<ModificarMascota> createState() => _ModificarMascotaState();
}

class _ModificarMascotaState extends State<ModificarMascota> {
  late List<MascotitasM> _mascotas = [];
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      setState(() {
        _currentUser = user;
      });
      await _getMascotasDueno(user.uid);
    }
  }

  Future<void> _getMascotasDueno(String userId) async {
    await MascotitasM.getMascotasDueno(userId);
    setState(() {
      _mascotas = MascotitasM.mascotasDueno;
    });
  }

  void edit(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarMascotas(mascotaId: id),
      ),
    );
  }

  void delete(String mascotaId) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Modificar Mascotas",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("#1575b3"),
          hexStringToColor("#00ffef"),
          hexStringToColor("#37d0d1")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: ListView.builder(
            itemCount: _mascotas.length,
            itemBuilder: (context, index) {
              final mascota = _mascotas[index];
              return MascotasCard(
                nombre: mascota.nombre,
                imagen: mascota.imagen,
                onEditar: () {
                  edit(mascota.id);
                },
                onEliminar: () {
                  delete(mascota.id);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
