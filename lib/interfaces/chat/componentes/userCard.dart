import 'package:flutter/material.dart';
import 'package:mascotitas/models/userModeloFirebase.dart';

import '../../../utilidades/colores.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.fullName,
    required this.onChatPressed,
  }) : super(key: key);

  final String fullName;
  final VoidCallback onChatPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: BoxDecoration(
        color: modeloU1,
        borderRadius: const BorderRadius.all(Radius.circular(35)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Image.asset(
              'assets/imagenes/user.png',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: onChatPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Iniciar Chat',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
