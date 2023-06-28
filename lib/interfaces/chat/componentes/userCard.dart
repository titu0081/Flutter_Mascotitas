import 'package:flutter/material.dart';

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
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    fullName,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: onChatPressed,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Iniciar Chat',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
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
