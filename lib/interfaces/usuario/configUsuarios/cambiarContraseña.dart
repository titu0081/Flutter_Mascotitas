import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mascotitas/utilidades/colores.dart';
import 'package:mascotitas/widgets_Reusables/widgetReusable.dart';
import 'package:rive/rive.dart' as Rive;

class CambiarContrasena extends StatefulWidget {
  const CambiarContrasena({super.key});

  @override
  State<CambiarContrasena> createState() => _CambiarContrasenaState();
}

class _CambiarContrasenaState extends State<CambiarContrasena> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late Rive.SMITrigger check;
  late Rive.SMITrigger error;
  late Rive.SMITrigger reset;
  bool cargando = false;

  Rive.StateMachineController getRiveValidator(Rive.Artboard artboard) {
    Rive.StateMachineController? controller =
        Rive.StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  Future<void> updateContra() async {
    final user = _auth.currentUser;
    if (user != null ||
        passwordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      final credential = EmailAuthProvider.credential(
        email: user?.email ?? '',
        password: passwordController.text,
      );

      try {
        setState(() {
          cargando = true;
        });
        // Reautentica al usuario con su contraseña actual
        await user?.reauthenticateWithCredential(credential);

        // Cambia la contraseña del usuario
        await user?.updatePassword(newPasswordController.text);

        // Actualiza la contraseña en la colección de usuarios de Firestore
        final userRef = _firestore.collection('usuarios').doc(user!.uid);
        await userRef.update({
          'contraseña': newPasswordController.text,
        });

        await Future.delayed(const Duration(seconds: 2));
        check.fire();
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          cargando = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contraseña cambiada exitosamente'),
          ),
        );

        // Limpia los campos de texto
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CambiarContrasena(),
          ),
        );

        // Muestra una notificación o realiza alguna acción adicional
        // según tus necesidades
      } catch (e) {
        // Manejo de errores
        setState(() {
          cargando = true;
        });
        await Future.delayed(const Duration(seconds: 2));
        error.fire();
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          cargando = false;
        });
        print('Error al cambiar la contraseña: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cambiar la contraseña'),
          ),
        );
      }
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
          "Usuario",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
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
                          reusableTextField(
                            'Contraseña actual',
                            Icons.lock,
                            true,
                            passwordController,
                            context,
                            [
                              FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          reusableTextField(
                            'Nueva contraseña',
                            Icons.lock,
                            true,
                            newPasswordController,
                            context,
                            [
                              FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          reusableTextField(
                            'Confirmar contraseña',
                            Icons.lock,
                            true,
                            confirmPasswordController,
                            context,
                            [
                              FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio',
                              ),
                              (val) {
                                if (val != newPasswordController.text) {
                                  return 'Las contraseñas no coinciden';
                                }
                                return null;
                              },
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          btnAddMascota(
                            context,
                            icon: Icons.change_circle_outlined,
                            iconSize: 30,
                            buttonText: 'Actualizar contraseña',
                            height: 50,
                            width: 200,
                            verticalP: 10,
                            horizontalP: 10,
                            fontSize: 20,
                            border: Colors.white,
                            onTap: () {
                              updateContra();
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
                  child: Rive.RiveAnimation.asset(
                    "assets/imagenes/riveValidator.riv",
                    onInit: (artboard) {
                      Rive.StateMachineController controller =
                          getRiveValidator(artboard);
                      check = controller.findSMI("Check") as Rive.SMITrigger;
                      error = controller.findSMI("Error") as Rive.SMITrigger;
                      reset = controller.findSMI("Reset") as Rive.SMITrigger;
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
  const PosicionValidacion(
      {super.key, required this.child, required this.size});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Row(
        children: [
          const SizedBox(width: 55),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
        ],
      ),
    );
  }
}
