import 'package:cloud_firestore/cloud_firestore.dart';
import '../utilidades/colores.dart';
import 'package:flutter/material.dart';

class MascotitasM {
  MascotitasM({
    required this.id,
    this.descripcion = "",
    this.estado = "",
    this.raza = "",
    this.dueno = "",
    this.tipo = "",
    this.imagen = "",
    this.color = Colors.white,
    this.nombre = "",
    this.area = "",
    this.sexo = "",
  });

  String id;
  String area, descripcion, dueno, estado, imagen, nombre, raza, sexo, tipo;
  Color color;

  static List<MascotitasM> mascotas = [];
  static List<MascotitasM> mascotasDueno = [];
  static List<MascotitasM> mascotasId = [];
  static List<MascotitasM> mascotasSinDueno = [];

  static Future<void> getMascotas() async {
    final QuerySnapshot<Map<String, dynamic>> mascotasSnapshot =
        await FirebaseFirestore.instance
            .collection('mascotas')
            .where('estado', isEqualTo: 'nueva')
            .get();

    mascotas = mascotasSnapshot.docs.map((doc) {
      final data = doc.data();
      return MascotitasM(
        id: doc.id,
        nombre: data['nombre'],
        descripcion: data['descripcion'],
        dueno: data['dueno'],
        imagen: data['imagen'],
        estado: data['estado'],
        raza: data['raza'],
        tipo: data['tipo'],
        area: data['area'],
        sexo: data['sexo'],
        color: modeloC1,
      );
    }).toList();
  }

  static Future<void> getMascotasDueno(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> mascotasSnapshot =
        await FirebaseFirestore.instance
            .collection('mascotas')
            .where('dueno', isEqualTo: userId)
            .where('estado', isEqualTo: 'nueva')
            .get();

    mascotasDueno = mascotasSnapshot.docs.map((doc) {
      final data = doc.data();
      return MascotitasM(
        id: doc.id,
        nombre: data['nombre'],
        descripcion: data['descripcion'],
        dueno: data['dueno'],
        imagen: data['imagen'],
        estado: data['estado'],
        raza: data['raza'],
        tipo: data['tipo'],
        area: data['area'],
        sexo: data['sexo'],
        color: modeloC1,
      );
    }).toList();
  }

  static Future<MascotitasM> getMascotaID(String mascotaId) async {
    final QuerySnapshot<Map<String, dynamic>> mascotasSnapshot =
        await FirebaseFirestore.instance
            .collection('mascotas')
            .where('id', isEqualTo: mascotaId)
            .get();

    final data = mascotasSnapshot.docs.first.data();
    return MascotitasM(
      id: mascotasSnapshot.docs.first.id,
      nombre: data['nombre'],
      descripcion: data['descripcion'],
      dueno: data['dueno'],
      imagen: data['imagen'],
      estado: data['estado'],
      raza: data['raza'],
      tipo: data['tipo'],
      area: data['area'],
      sexo: data['sexo'],
      color: modeloC1,
    );
  }

  static Future<void> getMascotasExceptoDueno(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> mascotasSnapshot =
        await FirebaseFirestore.instance
            .collection('mascotas')
            .where('dueno', isNotEqualTo: userId)
            .where('estado', isEqualTo: 'nueva')
            .get();

    mascotasSinDueno = mascotasSnapshot.docs.map((doc) {
      final data = doc.data();
      return MascotitasM(
        id: doc.id,
        nombre: data['nombre'],
        descripcion: data['descripcion'],
        dueno: data['dueno'],
        imagen: data['imagen'],
        estado: data['estado'],
        raza: data['raza'],
        tipo: data['tipo'],
        area: data['area'],
        sexo: data['sexo'],
        color: modeloC1,
      );
    }).toList();
  }

  static List<MascotitasM> buscarMascotas(String query) {
    final List<MascotitasM> resultados = [];

    // Convertir la consulta y los nombres de las mascotas a minúsculas para una búsqueda insensible a mayúsculas
    final String consulta = query.toLowerCase();

    for (final mascota in mascotas) {
      final String nombreMascota = mascota.nombre.toLowerCase();

      // Verificar si el nombre de la mascota contiene la consulta
      if (nombreMascota.contains(consulta)) {
        resultados.add(mascota);
      }
    }

    return resultados;
  }
}
