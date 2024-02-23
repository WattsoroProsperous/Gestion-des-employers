// lib/screens/task_create_screen.dart

import 'package:flutter/material.dart';

class TacheCreationInterface extends StatelessWidget {
    const TacheCreationInterface({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: const Center(
        child:  Text('Task Create Screen'),
      ),
    );
  }
}
