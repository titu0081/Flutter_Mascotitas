import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddImagen extends StatefulWidget {
  final void Function(String url) onImageSaved;

  const AddImagen({Key? key, required this.onImageSaved}) : super(key: key);
  @override
  State<AddImagen> createState() => _AddImagen();
}

class _AddImagen extends State<AddImagen> {
  String imageUrl = "";

  Future<void> addImagen() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        final petImage = File(pickedImage.path);
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}.jpg'; // Nombre único del archivo
        final petImageStorageRef = FirebaseStorage.instance
            .ref()
            .child('mascotasImagenes')
            .child(fileName);
        final petImageTask = petImageStorageRef.putFile(petImage);
        final downloadUrl = await (await petImageTask).ref.getDownloadURL();
        imageUrl = downloadUrl;
        widget.onImageSaved(downloadUrl); // Llama a la función onImageSaved
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: addImagen,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(width: 7, color: Colors.white),
        ),
      ),
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // Borde redondeado
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: imageUrl.isEmpty
                    ? Image.asset(
                        "assets/imagenes/selectI.png",
                        width: 300,
                        height: 300,
                      )
                    : Image.network(
                        imageUrl,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover, // Ajusta la imagen al contenedor
                      ),
              ),
            ),
            imageUrl.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: const Text(
                        'Añada la imagen de la mascota',
                        style: TextStyle(fontSize: 26),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
