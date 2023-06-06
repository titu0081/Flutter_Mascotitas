import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mascotitas/interfaces/inicioSesion.dart';
import 'package:mascotitas/interfaces/usuario/configUsuarios/cambiarContrase%C3%B1a.dart';
import 'package:mascotitas/interfaces/usuario/usuario.dart';
import 'package:mascotitas/utilidades/colores.dart';
import 'package:mascotitas/widgets_Reusables/widgetReusable.dart';
import 'package:rive/rive.dart' as rive;

class UsuarioConfig extends StatefulWidget {
  const UsuarioConfig({super.key});

  @override
  State<UsuarioConfig> createState() => _UsuarioConfigState();
}

class _UsuarioConfigState extends State<UsuarioConfig> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String nombreUsuario = "";
  final TextEditingController nombreTextController = TextEditingController();
  final TextEditingController apellidoTextController = TextEditingController();
  late rive.SMITrigger check;
  late rive.SMITrigger error;
  late rive.SMITrigger reset;
  bool cargando = false;

  rive.StateMachineController getRiveValidator(rive.Artboard artboard) {
    rive.StateMachineController? controller =
        rive.StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

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
  void initState() {
    super.initState();
    obtenerDatosUsuario();
  }

  Future<void> obtenerDatosUsuario() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot snapshot =
          await firestore.collection('usuarios').doc(user.uid).get();
      final data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        setState(() {
          nombreUsuario = '${data['nombre']} ${data['apellido']}';
          nombreTextController.text = data['nombre'];
          apellidoTextController.text = data['apellido'];
        });
      }
    }
  }

  void updateUser() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String nombre = nombreTextController.text.trim();
      final String apellido = apellidoTextController.text.trim();

      if (nombre.isNotEmpty && apellido.isNotEmpty) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('usuarios').doc(user.uid).update({
          'nombre': nombre,
          'apellido': apellido,
        });
        setState(() {
          cargando = true;
        });
        await Future.delayed(const Duration(seconds: 2));
        check.fire();
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          cargando = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuario actualizado correctamente'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Usuario(),
          ),
        );
      } else {
        setState(() {
          cargando = true;
        });
        await Future.delayed(const Duration(seconds: 2));
        error.fire();
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          cargando = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Los campos no pueden estar vacíos'),
          ),
        );
      }
    }
  }

  void openContra() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CambiarContrasena(),
      ),
    );
  }

  void loggout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const IniciarSesion(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Usuario",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: TextButton.icon(
              onPressed: () {
                loggout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              label: Text(
                "Cerrar Sesión",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(2, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
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
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).size.height * 0.15,
                  20,
                  0,
                ),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Image.asset(
                            'assets/imagenes/user.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            nombreUsuario,
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontFamily: AutofillHints.countryName,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                            'Nombre',
                            Icons.pets,
                            false,
                            nombreTextController,
                            context,
                            [
                              FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                            'Apellido',
                            Icons.pets_outlined,
                            false,
                            apellidoTextController,
                            context,
                            [
                              FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          btnAddMascota(
                            context,
                            icon: Icons.add,
                            iconSize: 30,
                            buttonText: 'Actualizar Usuario',
                            height: 50,
                            width: 200,
                            verticalP: 10,
                            horizontalP: 10,
                            fontSize: 20,
                            border: Colors.white,
                            onTap: () {
                              updateUser();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          btnAddMascota(
                            context,
                            icon: Icons.change_circle,
                            iconSize: 30,
                            buttonText: 'Actualizar contraseña',
                            height: 50,
                            width: 200,
                            verticalP: 10,
                            horizontalP: 10,
                            fontSize: 20,
                            border: Colors.white,
                            onTap: () {
                              openContra();
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
          cargando
              ? PosicionValidacion(
                  size: 300,
                  child: rive.RiveAnimation.asset(
                    "assets/imagenes/riveValidator.riv",
                    onInit: (artboard) {
                      rive.StateMachineController controller =
                          getRiveValidator(artboard);
                      check = controller.findSMI("Check") as rive.SMITrigger;
                      error = controller.findSMI("Error") as rive.SMITrigger;
                      reset = controller.findSMI("Reset") as rive.SMITrigger;
                    },
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

class PosicionValidacion extends StatelessWidget {
  const PosicionValidacion({
    Key? key,
    required this.child,
    required this.size,
  }) : super(key: key);

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size,
              width: size,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
