import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rive/rive.dart' as r;

import '../../models/iconosRiveS.dart';
import '../../utilidades/colores.dart';

class NavegacionPrincipal extends StatefulWidget {
  const NavegacionPrincipal({Key? key, required this.onNavSelect})
      : super(key: key);

  final Function(int navIndex) onNavSelect;

  @override
  State<NavegacionPrincipal> createState() => _NavegacionPrincipalState();
}

class _NavegacionPrincipalState extends State<NavegacionPrincipal> {
  final List<IconoSeleccionado> iconos = IconoSeleccionado.bottomNavs;
  int itemSelect = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 22, left: 15, right: 15, top: 0),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          gradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0),
          ]),
        ),
        child: Container(
          clipBehavior: Clip.hardEdge,
          padding: const EdgeInsets.only(top: 1),
          decoration: BoxDecoration(
            color: mFondo.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: mFondo.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 20),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(iconos.length, (index) {
              IconoSeleccionado icons = iconos[index];
              return Expanded(
                key: icons.id,
                child: CupertinoButton(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  onPressed: () {
                    iconoPresionado(index);
                  },
                  child: AnimatedOpacity(
                    opacity: itemSelect == index ? 1 : 0.2,
                    duration: const Duration(seconds: 1),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: -12,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 817),
                            height: 5,
                            width: itemSelect == index ? 35 : 0,
                            margin: const EdgeInsets.fromLTRB(0, 7, 0, 8),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 145, 0, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: r.RiveAnimation.asset(
                            "assets/imagenes/riveIcons.riv",
                            stateMachines: [icons.stateMachine],
                            artboard: icons.artboard,
                            onInit: (artboard) {
                              seleccionarBoton1(artboard, index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void seleccionarBoton1(r.Artboard artboard, index) {
    final controller = r.StateMachineController.fromArtboard(
        artboard, iconos[index].stateMachine);
    artboard.addController(controller!);

    iconos[index].estado = controller.findInput<bool>("active") as r.SMIBool;
  }

  void iconoPresionado(int index) {
    if (itemSelect != index) {
      setState(() {
        itemSelect = index;
      });
      widget.onNavSelect(index);
      iconos[index].estado!.change(true);
      Future.delayed(const Duration(seconds: 3), () {
        iconos[index].estado!.change(false);
      });
    }
  }
}
