import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mascotitas/interfaces/inicioSesion.dart';
import 'package:mascotitas/interfaces/paginaPrincipal/paginaPrincipal.dart';
import 'package:mascotitas/widgets_Reusables/widgetReusable.dart';
import '../utilidades/colores.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({Key? key}) : super(key: key);

  @override
  RegistrarseState createState() => RegistrarseState();
}

class RegistrarseState extends State<Registrarse> {
  final _formKey2 = GlobalKey<FormState>();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _contraTextController = TextEditingController();
  final TextEditingController _contraCTextController = TextEditingController();
  final TextEditingController _nombreTextController = TextEditingController();
  final TextEditingController _apellidoTextController = TextEditingController();

  @override
  void dispose() {
    _nombreTextController.dispose();
    _apellidoTextController.dispose();
    _contraTextController.dispose();
    _contraCTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) async {
    try {
      if (_contraTextController.text.trim() !=
          _contraCTextController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Las contraseñas no coinciden.')));
        return;
      } else if (_nombreTextController.text.trim() == "" ||
          _apellidoTextController.text.trim() == "") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Por favor, complete los campos faltantes...')));
        return;
      }
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: _emailTextController.text.trim(),
          password: _contraTextController.text.trim());

      if (newUser.user != null) {
        final userData = {
          'nombre': _nombreTextController.text.trim().toLowerCase(),
          'apellido': _apellidoTextController.text.trim().toLowerCase(),
          'correo': _emailTextController.text.trim().toLowerCase(),
          'contraseña': _contraTextController.text,
          'uid': newUser.user!.uid,
        };
        await _db.collection('usuarios').doc(newUser.user!.uid).set(userData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    } catch (e) {
      print(e);
      String errorMessage = '';

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'Este correo ya se encuentra registrado.';
            break;
          case 'weak-password':
            errorMessage =
                'La contraseña es demasiado débil. Intente con una contraseña más segura.';
            break;
          default:
            errorMessage = 'Ocurrió un error al intentar registrar el usuario.';
        }
      } else if (e is PlatformException) {
        errorMessage = 'Ocurrió un error: ${e.message}';
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
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
            "Registrarse",
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
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                key: _formKey2,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Ingrese su nombre",
                    Icons.person_outline,
                    false,
                    _nombreTextController,
                    context,
                    [
                      FormBuilderValidators.required(
                          errorText: 'Este campo es obligatorio')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Ingrese su apellido",
                    Icons.person_2_sharp,
                    false,
                    _apellidoTextController,
                    context,
                    [
                      FormBuilderValidators.required(
                          errorText: 'Este campo es obligatorio')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                      "Ingrese su correo electrónico",
                      Icons.email_outlined,
                      false,
                      _emailTextController,
                      context, [
                    FormBuilderValidators.required(
                        errorText: 'Este campo es obligatorio'),
                    FormBuilderValidators.email(
                        errorText: 'Ingrese un correo electrónico válido')
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Ingrese su contraseña",
                    Icons.lock_outline,
                    true,
                    _contraTextController,
                    context,
                    [
                      FormBuilderValidators.required(
                          errorText: 'Este campo es obligatorio'),
                      FormBuilderValidators.minLength(6,
                          errorText:
                              'Su contraseña debe tener al menos 6 caracteres')
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Repita su contraseña",
                    Icons.lock_sharp,
                    true,
                    _contraCTextController,
                    context,
                    [
                      FormBuilderValidators.required(
                          errorText: 'Este campo es obligatorio'),
                      FormBuilderValidators.minLength(6,
                          errorText:
                              'La contraseña debe tener al menos 6 caracteres'),
                      (val) {
                        if (val != _contraTextController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      }
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  btnIniciarSesionRegistrarse(context, false, () {
                    _submitForm(context);
                  }),
                  const SizedBox(height: 20),
                  opcionIniciarSesion(),
                ],
              ),
            ),
          ),
        ));
  }

  Row opcionIniciarSesion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Ya tienes cuenta? ",
            style: TextStyle(color: Colors.black, fontSize: 17)),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const IniciarSesion()));
          },
          child: const Text(
            "Iniciar Sesión",
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
