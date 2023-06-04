import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utilidades/colores.dart';

class UsuariosM {
  UsuariosM({
    required this.id,
    this.apellido = "",
    this.correo = "",
    this.nombre = "",
    this.color = Colors.white,
  });

  String id;
  String apellido;
  String correo;
  String nombre;
  Color color;

  static List<UsuariosM> usuarios = [];

  static Future<void> getUsers() async {
    final QuerySnapshot<Map<String, dynamic>> usuariosSnapshot =
        await FirebaseFirestore.instance.collection('usuarios').get();

    usuarios = usuariosSnapshot.docs.map((doc) {
      final data = doc.data();
      return UsuariosM(
        id: doc.id,
        nombre: data['nombre'],
        apellido: data['apellido'],
        correo: data['correo'],
        color: modeloU1,
      );
    }).toList();
  }
}
