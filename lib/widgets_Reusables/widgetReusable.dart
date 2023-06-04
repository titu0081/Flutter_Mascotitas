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

FormBuilderTextField reusableTextField(
  String texto,
  IconData icono,
  bool isPassword,
  TextEditingController controller,
  BuildContext context,
  List<String? Function(String?)>? validators,
) {
  return FormBuilderTextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 17),
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
      errorStyle: const TextStyle(fontSize: 17),
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

Widget reusableDescriptionField(
  String labelText,
  IconData prefixIcon,
  TextEditingController controller,
  BuildContext context,
  List<String? Function(String?)>? validators,
) {
  return FormBuilderTextField(
    controller: controller,
    maxLines: 3,
    cursorColor: Colors.black,
    style: TextStyle(
      color: Colors.black.withOpacity(0.9),
      fontSize: 17,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon, color: Colors.black, size: 30),
      hintText: labelText,
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromRGBO(186, 249, 250, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      errorStyle: const TextStyle(fontSize: 17),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    keyboardType: TextInputType.multiline, // Permitir entrada de varias líneas
    validator: FormBuilderValidators.compose(
      validators ?? <String? Function(String?)>[],
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    name: '',
  );
}

FormBuilderTextField reusableTextFieldE(
  String initialText,
  IconData icono,
  bool isPassword,
  TextEditingController controller,
  BuildContext context,
  List<String? Function(String?)>? validators,
) {
  controller.text = initialText; // Set the initial value for the text field

  return FormBuilderTextField(
    controller: controller,
    obscureText: isPassword,
    enableSuggestions: !isPassword,
    autocorrect: !isPassword,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9), fontSize: 17),
    decoration: InputDecoration(
      prefixIcon: Icon(icono, color: Colors.black, size: 30),
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromRGBO(186, 249, 250, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      errorStyle: const TextStyle(fontSize: 17),
      errorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    keyboardType:
        isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
    validator: FormBuilderValidators.compose(
        validators ?? <String? Function(String?)>[]),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    name: '',
  );
}

Widget reusableDescriptionField1(
  String labelText,
  IconData prefixIcon,
  TextEditingController controller,
  BuildContext context,
  List<String? Function(String?)>? validators,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      FormBuilderTextField(
        controller: controller,
        maxLines: 4,
        cursorColor: Colors.black,
        style: TextStyle(
          color: Colors.black.withOpacity(0.9),
          fontSize: 17,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.black, size: 30),
          hintText: labelText, // Usar labelText como hint text
          hintStyle: TextStyle(
            color: Colors.black
                .withOpacity(0.6), // Color más claro para el hint text
            fontSize: 17,
          ),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: const Color.fromRGBO(186, 249, 250, 1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          errorStyle: const TextStyle(fontSize: 17),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        keyboardType:
            TextInputType.multiline, // Permitir entrada de varias líneas
        validator: FormBuilderValidators.compose(
          validators ?? <String? Function(String?)>[],
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        name: '',
        onChanged:
            (value) {}, // Necesario para que se actualice la UI al ingresar texto
      ),
      SizedBox(height: 8),
      Text(
        controller.text,
        style: TextStyle(
          color: Colors.black.withOpacity(0.9),
          fontSize: 17,
        ),
      ),
    ],
  );
}

Widget reusableDescriptionFieldE(
    String labelText,
    IconData prefixIcon,
    TextEditingController controller,
    BuildContext context,
    List<String? Function(String?)>? validators,
    {required bool readOnly}) {
  return FormBuilderTextField(
    controller: controller,
    maxLines: 3,
    cursorColor: Colors.black,
    style: TextStyle(
      color: Colors.black.withOpacity(0.9),
      fontSize: 17,
    ),
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon, color: Colors.black, size: 30),
      hintText: labelText,
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: const Color.fromRGBO(186, 249, 250, 1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
      errorStyle: const TextStyle(fontSize: 17),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    keyboardType: TextInputType.multiline, // Permitir entrada de varias líneas
    validator: FormBuilderValidators.compose(
      validators ?? <String? Function(String?)>[],
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    name: '',
    readOnly: readOnly, // Permitir edición de los campos
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
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

ElevatedButton btnConfiguracion(
  BuildContext context, {
  required String imagePath,
  required String buttonText,
  required double height,
  required double width,
  required double fontSize,
  required Function onTap,
}) {
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
          imagePath,
          fit: BoxFit.contain,
          height: height, // custom height passed to the button
          width: width, // custom width passed to the button
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

ElevatedButton btnOpciones(
  BuildContext context, {
  required String imagePath,
  required String buttonText,
  required double height,
  required double width,
  required double verticalP,
  required double horizontalP,
  required double fontSize,
  required Function onTap,
}) {
  return ElevatedButton(
    onPressed: () {
      onTap();
    },
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      side: const BorderSide(width: 7, color: Colors.white),
      elevation: 6,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: verticalP, horizontal: horizontalP),
          child: Image.asset(
            imagePath,
            width: width,
            height: height,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: fontSize, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

ElevatedButton btnAddMascota(
  BuildContext context, {
  required IconData icon,
  required double iconSize,
  required String buttonText,
  required double height,
  required double width,
  required double verticalP,
  required double horizontalP,
  required double fontSize,
  required void Function() onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      side: const BorderSide(width: 7, color: Colors.white),
      elevation: 6,
      backgroundColor: Colors.orangeAccent,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: verticalP, horizontal: horizontalP),
          child: Icon(
            icon,
            size: iconSize,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

class ReusableAreasDropdownButton extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final String hintText;

  const ReusableAreasDropdownButton({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        hint: Center(
          child: Text(
            hintText,
            style: const TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
        dropdownColor: Colors.lightBlue,
        icon: const Icon(
          Icons.arrow_downward,
          size: 40,
          color: Colors.black,
        ),
        isExpanded: true,
        items: items.map((area) {
          return DropdownMenuItem<String>(
            value: area,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                area,
                style: const TextStyle(color: Colors.black, fontSize: 19),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ReusableCheckboxGroup extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final void Function(String?) onChanged;

  ReusableCheckboxGroup({
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: options.map((option) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<String>(
                value: option,
                groupValue: selectedOption,
                onChanged: onChanged,
              ),
              Text(
                option,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 19.0,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
