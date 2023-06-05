import 'package:flutter/material.dart';
import 'package:mascotitas/models/mascotasModeloFirebase.dart';

class CardBuscarMascota extends StatelessWidget {
  const CardBuscarMascota({
    Key? key,
    required this.resultados,
    required this.onTap,
  }) : super(key: key);

  final Function(MascotitasM) onTap;
  final Future<List<MascotitasM>> resultados;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MascotitasM>>(
      future: resultados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final mascotas = snapshot.data ?? [];
          return Expanded(
            child: ListView.builder(
              itemCount: mascotas.length,
              itemBuilder: (context, index) {
                final mascota = mascotas[index];
                return GestureDetector(
                  onTap: () {
                    onTap(mascota);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              mascota.imagen,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                mascota.nombre,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
