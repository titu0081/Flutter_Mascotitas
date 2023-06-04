import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascotitas/models/mascotasModeloFirebase.dart';
import 'package:mascotitas/utilidades/colores.dart';
import 'package:mascotitas/widgets_Reusables/widgetReusable.dart';

import '../chat/chatUsuarios.dart';

class DetalleMascota extends StatefulWidget {
  const DetalleMascota({Key? key, required this.idMascota}) : super(key: key);

  final String idMascota;

  @override
  _DetalleMascotaState createState() => _DetalleMascotaState();
}

class _DetalleMascotaState extends State<DetalleMascota> {
  late MascotitasM mascota;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> _getMascota(String mascotaId) async {
    try {
      final mascota1 = await MascotitasM.getMascotaID(mascotaId);
      setState(() {
        mascota = mascota1;
      });
    } catch (error) {
      // Manejar el error aquí, por ejemplo, mostrando un mensaje de error al usuario
    }
  }

  @override
  void initState() {
    super.initState();
    _getMascota(widget.idMascota);
  }

  void adoptarMascota(String mid) {
    final userID = auth.currentUser;
    if (userID != null) {
      final userId = userID.uid;
      final chatId = db.collection('chat').doc().id;
      db
          .collection('mascotas')
          .doc(mid)
          .update({'estado': "procesado"}).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Mascota adoptada correctamente'),
          ),
        );
        db.collection("chat").doc(chatId).set({
          'user1': userId,
          'user2': mascota.dueno,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatUsuarios(),
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error, la mascota no pudo ser adoptada'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Detalle Mascota",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(
                mascota.imagen,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        mascota.nombre,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Raza: ${mascota.raza}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Área: ${mascota.area}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Tipo: ${mascota.tipo}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Sexo: ${mascota.sexo}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Descripción: ${mascota.descripcion}",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: btnAddMascota(
                        context,
                        icon: Icons.add,
                        iconSize: 30,
                        buttonText: 'Adoptar Mascota',
                        height: 50,
                        width: 200,
                        verticalP: 10,
                        horizontalP: 10,
                        fontSize: 20,
                        onTap: () {
                          adoptarMascota(mascota.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
