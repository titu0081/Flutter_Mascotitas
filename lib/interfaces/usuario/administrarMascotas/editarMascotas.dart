import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mascotitas/interfaces/usuario/administrarMascotas/modificarMascota.dart';
import 'package:mascotitas/models/mascotasModeloFirebase.dart';
import 'package:rive/rive.dart' as rive;
import '../../../utilidades/colores.dart';
import '../../../widgets_Reusables/widgetReusable.dart';
import 'componentes/botonUpdateImage.dart';

class EditarMascotas extends StatefulWidget {
  const EditarMascotas({Key? key, required this.mascotaId}) : super(key: key);

  final String mascotaId;

  @override
  State<EditarMascotas> createState() => _EditarMascotas();
}

class _EditarMascotas extends State<EditarMascotas> {
  late MascotitasM mascota;
  final TextEditingController nombreTextController = TextEditingController();
  final TextEditingController razaTextController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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

  Future<void> _getMascota(String mascotaId) async {
    final mascota1 = await MascotitasM.getMascotaID(mascotaId);
    setState(() {
      mascota = mascota1;
    });
  }

  String imageUrl1 = "";

  void _guardarImagen(String url) {
    setState(() {
      imageUrl1 = url;
    });
  }

  void updateMascota() async {
    if (nombreTextController.text.isEmpty ||
        razaTextController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      setState(() {
        cargando = true;
      });
      await Future.delayed(const Duration(seconds: 2));
      error.fire();
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        cargando = false;
      });
    } else {
      setState(() {
        mascota.nombre = nombreTextController.text;
        mascota.raza = razaTextController.text;
        mascota.descripcion = descriptionController.text;
      });
      await FirebaseFirestore.instance
          .collection('mascotas')
          .doc(mascota.id)
          .update({
        'nombre': mascota.nombre,
        'raza': mascota.raza,
        'descripcion': mascota.descripcion,
        'imagen': imageUrl1,
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
          content: Text('Mascota actualizada correctamente'),
        ),
      );
      // Limpiar los campos de texto
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ModificarMascota(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _getMascota(widget.mascotaId);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Actualiza tú mascota",
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
                        UpdateImage(
                          imageUrl: mascota.imagen,
                          onImageSaved: _guardarImagen,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        reusableTextField(
                          mascota.nombre,
                          Icons.pets,
                          false,
                          nombreTextController,
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
                          mascota.raza,
                          Icons.pets_outlined,
                          false,
                          razaTextController,
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
                          mascota.descripcion,
                          Icons.description,
                          descriptionController,
                          context,
                          [
                            FormBuilderValidators.required(
                                errorText: 'Este campo es obligatorio')
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        btnAddMascota(
                          context,
                          icon: Icons.add,
                          iconSize: 30,
                          buttonText: 'Actualizar Mascota',
                          height: 50,
                          width: 200,
                          verticalP: 10,
                          horizontalP: 10,
                          fontSize: 20,
                          border: Colors.white,
                          onTap: () {
                            updateMascota();
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
