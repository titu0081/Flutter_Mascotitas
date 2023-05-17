import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../componentes/animationBarNav/animationButtonBar.dart';
import '../../utilidades/colores.dart';
import '../../widgets_Reusables/widgetReusable.dart';

class Usuario extends StatefulWidget {
  const Usuario({Key? key}) : super(key: key);

  @override
  State<Usuario> createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String nombreUsuario = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    obtenerNombreUsuario();
  }

  Future<void> obtenerNombreUsuario() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        final nombre = userData['nombre'];
        final apellido = userData['apellido'];

        setState(() {
          nombreUsuario = "${capitalize(nombre)} ${capitalize(apellido)}";
        });
      }
    }
  }

  String capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              hexStringToColor("#1575b3"),
              hexStringToColor("#00ffef"),
              hexStringToColor("#37d0d1"),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          logoWidget("assets/imagenes/petIcono.png"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0.0, 0.3),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              child: Text(
                                nombreUsuario.isNotEmpty
                                    ? nombreUsuario
                                    : "Mascotitas",
                                key: ValueKey<String>(
                                    nombreUsuario), // Usamos el ValueKey para identificar los cambios en el texto
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AutofillHints.countryName,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          btnConfiguracion(
                            context,
                            true,
                            200,
                            200,
                            40,
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Botón adoptar presionado'),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          btnConfiguracion(
                            context,
                            false,
                            200,
                            200,
                            40,
                            () {
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
          ),
        ],
      ),
    );
  }
}

class AdminButton extends StatelessWidget {
  const AdminButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {/* add your onPressed functionality here */},
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        side: BorderSide(width: 7, color: Colors.white),
        elevation: 6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/imagenes/pets2.gif",
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Configuracion de Usuario",
              style: TextStyle(fontSize: 40, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
