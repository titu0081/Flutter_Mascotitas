import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateImage extends StatefulWidget {
  final String imageUrl;
  final void Function(String url) onImageSaved;

  const UpdateImage({
    Key? key,
    required this.imageUrl,
    required this.onImageSaved,
  }) : super(key: key);

  @override
  _UpdateImageState createState() => _UpdateImageState();
}

class _UpdateImageState extends State<UpdateImage> {
  late String imageUrl;

  Future<void> actualizarFoto() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final petImage = File(pickedImage.path);
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final petImageStorageRef = FirebaseStorage.instance
            .ref()
            .child('mascotasImagenes')
            .child(fileName);
        final petImageTask = petImageStorageRef.putFile(petImage);
        final downloadUrl = await (await petImageTask).ref.getDownloadURL();
        imageUrl = downloadUrl;
        widget.onImageSaved(downloadUrl);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: actualizarFoto,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(width: 7, color: Colors.white),
        ),
      ),
      child: IntrinsicWidth(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: imageUrl.isEmpty
                  ? Image.asset(
                      "assets/imagenes/selectI.png",
                      width: 250,
                      height: 250,
                    )
                  : Image.network(
                      imageUrl,
                      width: 250,
                      height: 250,
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  imageUrl.isEmpty
                      ? 'Añadir imagen de la mascota'
                      : 'Actualizar foto de la mascota',
                  style: const TextStyle(fontSize: 26),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
