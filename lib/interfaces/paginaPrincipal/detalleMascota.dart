import 'package:cached_network_image/cached_network_image.dart';
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
  bool isLoading = true;

  Future<void> _getMascota(String mascotaId) async {
    try {
      final mascota1 = await MascotitasM.getMascotaID(mascotaId);
      setState(() {
        mascota = mascota1;
        isLoading = false;
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
          const SnackBar(
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
          const SnackBar(
            content: Text('Error, la mascota no pudo ser adoptada'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
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
              height: MediaQuery.of(context).size.height * 0.45,
              child: CachedNetworkImage(
                imageUrl: mascota.imagen.toString(),
                placeholder: (context, url) => cargandoImagenes(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.4 - 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            mascota.nombre,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
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
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
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
                          border: Colors.black,
                          onTap: () {
                            adoptarMascota(mascota.id);
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context)
                              .viewInsets
                              .bottom), // Asegura que el contenido esté visible al abrir el teclado
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
