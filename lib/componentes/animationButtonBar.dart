import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mascotitas/utilidades/colores.dart';
import 'package:rive/rive.dart';

import '../utilidades/riveUtils.dart';

class MenuInferior1 extends StatefulWidget {
  const MenuInferior1({super.key});

  @override
  State<MenuInferior1> createState() => _MenuInferior1State();
}

class _MenuInferior1State extends State<MenuInferior1> {
  late SMIBool homeTigger;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: mFondo,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottomNavs[index].input!.change(true);
                    Future.delayed(const Duration(seconds: 1), (() {
                      bottomNavs[index].input!.change(false);
                    }));
                  },
                  child: SizedBox(
                    height: 36,
                    width: 36,
                    child: RiveAnimation.asset(
                      bottomNavs.first.src,
                      artboard: bottomNavs[index].artboard,
                      onInit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(
                          artboard,
                          stateMachineName: bottomNavs[index].stateMachine,
                        );
                        bottomNavs[index].input =
                            controller.findSMI("active") as SMIBool;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  RiveIcons("assets/imagenes/riveIcons.riv",
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
