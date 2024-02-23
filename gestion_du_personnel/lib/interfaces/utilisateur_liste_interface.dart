// lib/screens/user_list_screen.dart

import 'package:flutter/material.dart';

class UtilisateurInterface extends StatelessWidget {
  const UtilisateurInterface({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: const Center(
        child: Text('User List Screen'),
      ),
    );
  }
}
