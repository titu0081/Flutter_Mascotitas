import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class IconoSeleccionado {
  IconoSeleccionado({
    this.stateMachine = "",
    this.artboard = "",
    this.estado,
  });

  UniqueKey? id = UniqueKey();
  String stateMachine;
  String artboard;
  late SMIBool? estado;

  static List<IconoSeleccionado> bottomNavs = [
    IconoSeleccionado(artboard: "HOME", stateMachine: "HOME_interactivity"),
    IconoSeleccionado(artboard: "SEARCH", stateMachine: "SEARCH_Interactivity"),
    IconoSeleccionado(artboard: "CHAT", stateMachine: "CHAT_Interactivity"),
    IconoSeleccionado(artboard: "USER", stateMachine: "USER_Interactivity"),
  ];
}
