import 'package:flutter/material.dart';

import '../utilidades/colores.dart';

class MascotitasM {
  MascotitasM(
      {this.id,
      this.src = "",
      this.color = Colors.white,
      this.title = "",
      this.area = "",
      this.sexo = ""});

  UniqueKey? id = UniqueKey();
  String title, src, area, sexo;
  Color color;

  static List<MascotitasM> mascotas = [
    MascotitasM(
      title: "Nombre de la Mascota",
      src: "assets/imagenes/pruebaM.jpg",
      color: modeloC1,
    ),
    MascotitasM(
      title: "Nombre de la Mascota",
      src: "assets/imagenes/pruebaM.jpg",
      color: modeloC2,
    ),
    MascotitasM(
      title: "Nombre de la Mascota",
      src: "assets/imagenes/pruebaM.jpg",
      color: modeloC1,
    ),
  ];

  static List<MascotitasM> mascotasRecent = [
    MascotitasM(
      title: "Nombre de la Mascota",
      src: "assets/imagenes/pruebaM.jpg",
      area: "Area",
      sexo: "Sexo",
      color: modeloC1,
    ),
    MascotitasM(
      title: "Nombre de la Mascota",
      src: "assets/imagenes/pruebaM.jpg",
      area: "Area",
      sexo: "Sexo",
      color: modeloC2,
    ),
    MascotitasM(
      title: "Nombre de la Mascota",
      src: "assets/imagenes/pruebaM.jpg",
      area: "Area",
      sexo: "Sexo",
      color: modeloC1,
    ),
  ];
}
