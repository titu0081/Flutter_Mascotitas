import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mascotitas/interfaces/paginaPrincipal/paginaPrincipal.dart';
import 'package:mascotitas/interfaces/registrarse.dart';
import 'package:mascotitas/utilidades/colores.dart';
import '../widgets_Reusables/widgetReusable.dart';
import 'package:rive/rive.dart' as Rive;

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({Key? key}) : super(key: key);

  @override
  State<IniciarSesion> createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _contraTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool cargando = false;
  late Rive.SMITrigger check;
  late Rive.SMITrigger error;
  late Rive.SMITrigger reset;

  Rive.StateMachineController getRiveValidator(Rive.Artboard artboard) {
    Rive.StateMachineController? controller =
        Rive.StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void iniciarSesionCorreo() async {
    if (_formKey.currentState!.validate()) {
      if (_emailTextController.text.isEmpty) {
        setState(() {
          cargando = true;
        });
        await Future.delayed(const Duration(seconds: 5));
        error.fire();
        await Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            cargando = false;
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Por favor, ingrese su correo electrónico.')));
        return;
      }
      if (_contraTextController.text.isEmpty) {
        setState(() {
          cargando = true;
        });
        await Future.delayed(const Duration(seconds: 5));
        error.fire();
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            cargando = false;
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Por favor, verifique su contraseña.')));
        return;
      }
      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: _emailTextController.text.trim().toLowerCase(),
          password: _contraTextController.text.trim(),
        );
        final User? user = userCredential.user;
        setState(() {
          cargando = true;
        });
        Future.delayed(
          const Duration(seconds: 2),
          () async {
            setState(() {
              cargando = true;
            });
            if (user != null) {
              await Future.delayed(const Duration(seconds: 5));
              check.fire();
              await Future.delayed(const Duration(seconds: 3));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
              setState(() {
                cargando = false;
              });
            } else {
              // Error al iniciar sesión
              setState(() {
                cargando = true;
              });
              await Future.delayed(const Duration(seconds: 5));
              error.fire();
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  cargando = false;
                });
              });
            }
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            cargando = true;
          });
          await Future.delayed(const Duration(seconds: 5));
          error.fire();
          await Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              cargando = false;
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Este correo no se encuentra registrado.')));
        } else if (e.code == 'wrong-password') {
          setState(() {
            cargando = true;
          });
          await Future.delayed(const Duration(seconds: 5));
          error.fire();
          await Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              cargando = false;
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('La contraseña es incorrecta.')));
        } else if (e.code == 'invalid-email') {
          setState(() {
            cargando = true;
          });
          await Future.delayed(const Duration(seconds: 5));
          error.fire();
          await Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              cargando = false;
            });
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ingrese un correo electrónico válido.')));
        } else if (e.code == 'too-many-requests') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('Demasiados intentos. Intente nuevamente más tarde.')));
        }
      } catch (e) {
        print(e);
      }
    }
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.1, 20, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          logoWidget("assets/imagenes/petIcono.png"),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Mascotitas',
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                fontFamily: AutofillHints.countryName,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      reusableTextField(
                          "Ingrese su correo electrónico",
                          Icons.person_2_outlined,
                          false,
                          _emailTextController,
                          context, [
                        FormBuilderValidators.required(
                            errorText: 'Para inicar sesion coloque su correo.'),
                        FormBuilderValidators.email(
                            errorText: 'Ingrese un correo electrónico válido')
                      ]),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Ingrese su contraseña", Icons.lock,
                          true, _contraTextController, context, []),
                      const SizedBox(
                        height: 30,
                      ),
                      btnIniciarSesionRegistrarse(context, true, () {
                        iniciarSesionCorreo();
                      }),
                      const SizedBox(
                        height: 5,
                      ),
                      opcionRegistrarse()
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
              : const SizedBox(),
        ],
      ),
    );
  }

  Row opcionRegistrarse() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No tienes cuenta? ",
            style: TextStyle(color: Colors.black, fontSize: 17)),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Registrarse()));
          },
          child: const Text(
            "Registrate",
            style: TextStyle(
                color: Color.fromRGBO(47, 0, 255, 1),
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
      ],
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
