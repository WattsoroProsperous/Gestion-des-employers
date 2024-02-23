import 'package:flutter/material.dart';
import 'package:gestion_du_personnel/interfaces/ajouter_employer.dart';


void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon Application',
      home: AjouterEmployeInterface(), // Remplacez PageAccueil() par le nom de votre page d'accueil
    );
  }
}
