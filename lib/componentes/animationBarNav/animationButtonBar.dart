import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mascotitas/componentes/animationBarNav/barraAnimada.dart';
import 'package:mascotitas/utilidades/colores.dart';
import 'package:rive/rive.dart';

import '../../models/riveIcons.dart';
import '../../utilidades/riveUtils.dart';

class MenuInferior1 extends StatefulWidget {
  const MenuInferior1({super.key});

  @override
  State<MenuInferior1> createState() => _MenuInferior1State();
}

class _MenuInferior1State extends State<MenuInferior1> {
  RiveIcons seleccionarBoton = bottomNavs.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: mFondo,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottomNavs[index].input!.change(true);
                    if (bottomNavs[index] != seleccionarBoton) {
                      setState(() {
                        seleccionarBoton = bottomNavs[index];
                      });
                    }
                    Future.delayed(const Duration(seconds: 1), (() {
                      bottomNavs[index].input!.change(false);
                    }));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BarraAnimada(
                          estaActivo: bottomNavs[index] == seleccionarBoton),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity:
                              bottomNavs[index] == seleccionarBoton ? 1 : 0.3,
                          child: RiveAnimation.asset(
                            bottomNavs.first.src,
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(
                                artboard,
                                stateMachineName:
                                    bottomNavs[index].stateMachine,
                              );
                              bottomNavs[index].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
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
