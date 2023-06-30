import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mascotitas/interfaces/chat/componentes/userCard.dart';
import 'package:mascotitas/models/chatModeloFirebase.dart';
import 'package:mascotitas/models/userModeloFirebase.dart';
import 'package:mascotitas/utilidades/colores.dart';

import 'chatScreen.dart';

class ChatUsuarios extends StatefulWidget {
  const ChatUsuarios({Key? key}) : super(key: key);

  @override
  State<ChatUsuarios> createState() => _ChatUsuariosState();
}

class _ChatUsuariosState extends State<ChatUsuarios> {
  late String _userID;
  late List<Chat> chats = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUserID(); // Obtener el ID del usuario actual al iniciar la pantalla
  }

  Future<void> _getCurrentUserID() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        _userID = user.uid;
      });
      cargarChats();
    }
  }

  Future<void> cargarChats() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chat')
        .where('user1', isEqualTo: _userID)
        .get();

    final QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection('chat')
        .where('user2', isEqualTo: _userID)
        .get();

    final List<QueryDocumentSnapshot> documents = [
      ...snapshot.docs,
      ...snapshot2.docs
    ];

    final List<String> otherUserIDs = [];

    for (final doc in documents) {
      final chat = Chat.fromSnapshot(doc);
      final otherUserID = chat.user1 == _userID ? chat.user2 : chat.user1;

      if (!otherUserIDs.contains(otherUserID)) {
        otherUserIDs.add(otherUserID);
        final nombreUsuario = await obtenerNombreUsuario(otherUserID);
        final apellidoUsuario = await obtenerApellidoUsuario(otherUserID);

        final nombreCapitalizado = nombreUsuario.capitalize();
        final apellidoCapitalizado = apellidoUsuario.capitalize();

        setState(() {
          chats.add(
            chat.copyWith(user2: '$nombreCapitalizado $apellidoCapitalizado'),
          );
        });
      }
    }
  }

  Future<String> obtenerNombreUsuario(String userID) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userID)
        .get();

    final data = snapshot.data() as Map<String, dynamic>;
    final nombre = data['nombre'] as String;
    return nombre;
  }

  Future<String> obtenerApellidoUsuario(String userID) async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userID)
        .get();

    final data = snapshot.data() as Map<String, dynamic>;
    final apellido = data['apellido'] as String;
    return apellido;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
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
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              15,
              MediaQuery.of(context).padding.top,
              15,
              MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "CHATEA Y ADOPTA",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                          ),
                          child: ListView.builder(
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              final chat = chats[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: UserCard(
                                  fullName: chat.user2,
                                  onChatPressed: () async {
                                    final otherUserID =
                                        await obtenerUserID(chat.user2);
                                    if (otherUserID != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                              userID: _userID,
                                              otherUserID: otherUserID),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> obtenerUserID(String fullName) async {
    final nombreApellido = fullName.split(" ");
    final nombre = nombreApellido[0];
    final apellido = nombreApellido[1];

    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .where('nombre', isEqualTo: nombre.trim().toLowerCase())
        .where('apellido', isEqualTo: apellido.trim().toLowerCase())
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userID = snapshot.docs[0].id;
      return userID;
    }
    return null;
  }
}

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
