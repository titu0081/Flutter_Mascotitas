import 'package:flutter/material.dart';

class MascotitasModel {
  final String title, src;
  final Color fondoColor;

  MascotitasModel({
    required this.title,
    this.src = "assets/imagenes/pruebaM.jpg",
    this.fondoColor = const Color.fromARGB(255, 0, 2, 255),
  });
}

List<MascotitasModel> mascotas = [
  MascotitasModel(title: "Nombre de la Mascota"),
  MascotitasModel(
    title: "Nombre de la Mascota",
    src: "assets/imagenes/pruebaM.jpg",
    fondoColor: const Color.fromARGB(255, 12, 107, 131),
  ),
];

List<MascotitasModel> mascotasRecientes = [
  MascotitasModel(title: "Nombre de la Mascota"),
  MascotitasModel(
    title: "Nombre de la Mascota",
    src: "assets/imagenes/pruebaM.jpg",
    fondoColor: const Color.fromARGB(255, 12, 107, 131),
  ),
  MascotitasModel(
    title: "Nombre de la Mascota",
    src: "assets/imagenes/pruebaM.jpg",
    fondoColor: const Color.fromARGB(255, 0, 2, 255),
  ),
];
