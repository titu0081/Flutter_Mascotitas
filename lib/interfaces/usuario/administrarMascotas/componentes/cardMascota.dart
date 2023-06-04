import 'package:flutter/material.dart';

class MascotasCard extends StatelessWidget {
  final String nombre;
  final String imagen;
  final VoidCallback? onEditar;
  final VoidCallback? onEliminar;

  const MascotasCard({
    Key? key,
    required this.nombre,
    required this.imagen,
    this.onEditar,
    this.onEliminar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Image.network(
                imagen,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text(
                  nombre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: onEditar,
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: onEliminar,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
