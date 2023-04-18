import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

Image logoWidget(String imagenLogo) {
  return Image.asset(imagenLogo, fit: BoxFit.fitWidth, width: 240, height: 240);
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

Container btnIniciarSesion_Registrarse(
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
