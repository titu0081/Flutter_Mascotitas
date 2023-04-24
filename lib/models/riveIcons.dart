import 'package:rive/rive.dart';

class RiveIcons {
  final String artboard, stateMachine, title, src;
  late SMIBool? input;

  RiveIcons(
    this.src, {
    required this.artboard,
    required this.stateMachine,
    required this.title,
    this.input,
  });
}

List<RiveIcons> bottomNavs = [
  RiveIcons("assets/imagenes/riveIcons.riv",
      artboard: "HOME", stateMachine: "HOME_interactivity", title: "Home"),
  RiveIcons("assets/imagenes/riveIcons1.riv",
      artboard: "SEARCH",
      stateMachine: "SEARCH_Interactivity",
      title: "Search"),
  RiveIcons("assets/imagenes/riveIcons.riv",
      artboard: "BELL",
      stateMachine: "BELL_Interactivity",
      title: "Notificacion"),
  RiveIcons("assets/imagenes/riveIcons.riv",
      artboard: "USER", stateMachine: "USER_Interactivity", title: "Usuario"),
];
