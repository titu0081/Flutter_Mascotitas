import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mascotitas/interfaces/buscar/componentes/cardMascostasBuscar.dart';
import 'package:mascotitas/interfaces/paginaPrincipal/detalleMascota.dart';
import 'package:mascotitas/models/mascotasModeloFirebase.dart';
import '../../utilidades/colores.dart';

class BuscarMascotas extends StatefulWidget {
  const BuscarMascotas({Key? key}) : super(key: key);

  @override
  State<BuscarMascotas> createState() => _BuscarMascotasState();
}

class _BuscarMascotasState extends State<BuscarMascotas> {
  String query = '';
  Future<List<MascotitasM>> resultados = Future.value([]);

  void buscarMascotas() {
    setState(() {
      resultados = MascotitasM.buscarMascotasSinDueno(query);
    });
  }

  void abrirMascota(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalleMascota(idMascota: id),
      ),
    );
  }

  void filtrarPorTipo(String tipo) {
    setState(() {
      query = tipo;
      buscarMascotas();
    });
  }

  void filtrarPorSexo(String sexo) {
    setState(() {
      query = sexo;
      buscarMascotas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#1575b3"),
              hexStringToColor("#00ffef"),
              hexStringToColor("#37d0d1"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 50, 20, 15),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          query = text;
                        });
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Buscar Mascotas',
                        hintStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: buscarMascotas,
                      icon: const Icon(Icons.search),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => filtrarPorTipo('perro'),
                    child: const Text('Perro'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => filtrarPorTipo('gato'),
                    child: const Text('Gato'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => filtrarPorSexo('macho'),
                    child: const Text('Macho'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => filtrarPorSexo('hembra'),
                    child: const Text('Hembra'),
                  ),
                ],
              ),
              CardBuscarMascota(
                resultados: resultados,
                onTap: (mascota) {
                  abrirMascota(mascota.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
