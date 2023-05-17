import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Image logoWidget(String imagenLogo) {
  return Image.asset(imagenLogo, fit: BoxFit.fitWidth, width: 240, height: 240);
}

Image imagenesMascotas(String imagenLogo) {
  return Image.asset(imagenLogo,
      fit: BoxFit.fitHeight, width: 180, height: 180);
}

final ScrollController _scrollController = ScrollController();

FormBuilderTextField reusableTextField(
  String texto,
  IconData icono,
  bool isPassword,
  TextEditingController controller,
  BuildContext context,
  List<String? Function(String?)>? validators, // actualización aquí
) {
  return FormBuilderTextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 20),
    decoration: InputDecoration(
      prefixIcon: Icon(icono, color: Colors.black, size: 30),
      labelText: texto,
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromRGBO(186, 249, 250, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      errorStyle: const TextStyle(fontSize: 20),
      errorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
    validator: FormBuilderValidators.compose(
      validators ?? <String? Function(String?)>[],
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    name: '',
  );
}

Container btnIniciarSesionRegistrarse(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: 200,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        isLogin ? 'Iniciar Sesión' : 'Registrarse',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
  );
}

Container btnAdoptar(BuildContext context, Function onTap) {
  return Container(
    width: 125,
    height: 50,
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.orangeAccent;
          }
          if (states.contains(MaterialState.hovered)) {
            return Colors.orangeAccent;
          }
          return Colors.white;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.white;
          }
          return Colors.orangeAccent;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Más",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "Información",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    ),
  );
}

class MenuInferior extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final _model = ValueNotifier<double>(0);

  MenuInferior({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _model,
      builder: (context, child) {
        return Positioned(
          bottom: _model.value,
          right: 22,
          left: 22,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 15, color: Colors.black.withOpacity(0.4)),
              ],
              borderRadius: BorderRadius.circular(45),
            ),
            height: 75,
            alignment: Alignment.center,
            child: Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.home_rounded,
                      size: 36,
                      color: Colors.black,
                    ),
                    onPressed: () => onItemTapped(0),
                    color: selectedIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_today_rounded,
                      size: 36,
                      color: Colors.black,
                    ),
                    onPressed: () => onItemTapped(1),
                    color: selectedIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 36,
                      color: Colors.black,
                    ),
                    onPressed: () => onItemTapped(2),
                    color: selectedIndex == 2 ? Colors.blue : Colors.grey,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.person,
                      size: 36,
                      color: Colors.black,
                    ),
                    onPressed: () => onItemTapped(3),
                    color: selectedIndex == 3 ? Colors.blue : Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

ElevatedButton btnConfiguracion(BuildContext context, bool isUserMas,
    double height, double width, double fontSize, Function onTap) {
  return ElevatedButton(
    onPressed: () {
      onTap();
    },
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      side: const BorderSide(width: 7, color: Colors.white),
      elevation: 6,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          isUserMas ? "assets/imagenes/pets2.gif" : "assets/imagenes/user1.gif",
          fit: BoxFit.contain,
          height: height, // custom height passed to the button
          width: width, // custom width passed to the button
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            isUserMas ? "Administrar Mascotas" : "Configuracion de Usuario",
            style: TextStyle(fontSize: fontSize, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
