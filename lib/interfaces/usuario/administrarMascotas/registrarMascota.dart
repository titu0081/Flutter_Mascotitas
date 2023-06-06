import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rive/rive.dart' as Rive;
import '../../../utilidades/colores.dart';
import '../../../widgets_Reusables/widgetReusable.dart';
import 'componentes/botonAddImage.dart';

class RegistrarMascota extends StatefulWidget {
  const RegistrarMascota({super.key});

  @override
  State<RegistrarMascota> createState() => _RegistrarMascota();
}

class _RegistrarMascota extends State<RegistrarMascota> {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _nombreTextController = TextEditingController();
  final TextEditingController _razaTextController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> areas = [
    'Norte de Quito',
    'Sur de Quito',
    'Centro de Quito'
  ];
  String? selectAreas;
  String? selectedOptionsS;
  String? selectedOptionsT;

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

  String imageUrl = "";

  void handleImageSaved(String url) {
    // Hacer algo con la URL de la imagen guardada, como guardarla en una variable o utilizarla en otra función
    setState(() {
      imageUrl = url;
    });
  }

// Function to add a pet image from the device's gallery

  void addMascota() async {
    // Obtener el ID del usuario loggeado
    final user = _auth.currentUser;
    if (_nombreTextController.text.isEmpty ||
        _razaTextController.text.isEmpty ||
        selectAreas == null ||
        selectedOptionsS == null ||
        selectedOptionsT == null) {
      setState(() {
        cargando = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      error.fire();
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        cargando = false;
      });
      // Deseleccionar opciones de los checkboxes
      setState(() {
        selectedOptionsS = null; // o selectedOptionsS = '';
        selectedOptionsT = null; // o selectedOptionsT = '';
      });
    } else if (user != null) {
      final userId = user.uid;
      // Generar un nuevo ID para la mascota
      final mascotaId = _db.collection('mascotas').doc().id;
      //Recuperamos la imagen guardada anteriormente

      // Crear el documento de la mascota con los datos
      await _db.collection('mascotas').doc(mascotaId).set({
        'area': selectAreas,
        'dueno': userId,
        'estado': 'nueva',
        'id': mascotaId,
        'nombre': _nombreTextController.text,
        'raza': _razaTextController.text,
        'sexo': selectedOptionsS,
        'tipo': selectedOptionsT,
        'imagen': imageUrl,
        'descripcion': _descriptionController.text,
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
          content: Text('Mascota agregada correctamente'),
        ),
      );
      // Limpiar los campos de texto
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RegistrarMascota(),
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
          "Añadir mascota",
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
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.15, 20, 0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        AddImagen(onImageSaved: handleImageSaved),
                        const SizedBox(
                          height: 30,
                        ),
                        reusableTextField(
                          "Ingrese el nombre de la mascota",
                          Icons.pets,
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
                          "Ingrese la raza de su mascota",
                          Icons.pets_outlined,
                          false,
                          _razaTextController,
                          context,
                          [
                            FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio')
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableDescriptionField(
                          'Ingrese una descripcion de su mascota',
                          Icons.description,
                          _descriptionController,
                          context,
                          [
                            FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio')
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ReusableAreasDropdownButton(
                          value: selectAreas,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectAreas = newValue!;
                            });
                          },
                          hintText: 'Selecciona la ubicacion de la mascota',
                          items: const [
                            'Norte de Quito',
                            'Sur de Quito',
                            'Centro de Quito',
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const TextSeleccion(
                          texto: 'Seleccione el sexo de su mascota',
                        ),
                        ReusableCheckboxGroup(
                          options: const ['Macho', 'Hembra'],
                          selectedOption: selectedOptionsS,
                          onChanged: (String? newSelectedOptionS) {
                            setState(() {
                              selectedOptionsS = newSelectedOptionS;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const TextSeleccion(
                          texto: 'Seleccione el tipo de mascota',
                        ),
                        ReusableCheckboxGroup(
                          options: const ['Perro', 'Gato'],
                          selectedOption: selectedOptionsT,
                          onChanged: (String? newSelectedOptionT) {
                            setState(() {
                              selectedOptionsT = newSelectedOptionT;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        btnAddMascota(
                          context,
                          icon: Icons.add,
                          iconSize: 30,
                          buttonText: 'Añadir Mascota',
                          height: 50,
                          width: 200,
                          verticalP: 10,
                          horizontalP: 10,
                          fontSize: 20,
                          border: Colors.white,
                          onTap: () {
                            addMascota();
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
      ),
    );
  }
}

class TextSeleccion extends StatelessWidget {
  const TextSeleccion({
    super.key,
    required this.texto,
  });

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
        shadows: [
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 5.0,
            color: Colors.grey.withOpacity(0.6),
          ),
          Shadow(
            offset: Offset(-2.0, -2.0),
            blurRadius: 5.0,
            color: Colors.white.withOpacity(0.8),
          ),
          Shadow(
            offset: Offset(0.0, 0.0),
            blurRadius: 8.0,
            color: Colors.grey.withOpacity(0.3),
          ),
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
