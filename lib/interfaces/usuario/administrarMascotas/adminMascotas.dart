import 'package:flutter/material.dart';
import '../../../utilidades/colores.dart';
import '../../../widgets_Reusables/widgetReusable.dart';
import 'registrarMascota.dart';

class OpcionesMascotas extends StatefulWidget {
  const OpcionesMascotas({super.key});

  @override
  State<OpcionesMascotas> createState() => _OpcionesMascotasState();
}

class _OpcionesMascotasState extends State<OpcionesMascotas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Opciones de Usuario",
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
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 0),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    logoWidget("assets/imagenes/petIcono.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    btnOpciones(
                      context,
                      imagePath: "assets/imagenes/agregar3.gif",
                      buttonText: "Añadir Mascota",
                      height: 120,
                      width: 120,
                      verticalP: 8,
                      horizontalP: 8,
                      fontSize: 25,
                      onTap: () {
                        abrirMascotas();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    btnOpciones(
                      context,
                      imagePath: "assets/imagenes/update2.gif",
                      buttonText: "Modificar Mascotas",
                      height: 100,
                      width: 100,
                      verticalP: 15,
                      horizontalP: 8,
                      fontSize: 25,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Botón adoptar presionado'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void abrirMascotas() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrarMascota()),
    );
  }
}
