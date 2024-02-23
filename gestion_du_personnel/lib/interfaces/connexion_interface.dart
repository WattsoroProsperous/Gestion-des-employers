import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'inscription_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ajouter_employer.dart';

class ConnexionInterface extends StatefulWidget {
  @override
  _ConnexionInterfaceState createState() => _ConnexionInterfaceState();
}

class _ConnexionInterfaceState extends State<ConnexionInterface> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
  // Vérifier si les contrôleurs contiennent des valeurs valides
  if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
    final String apiUrl = 'http://localhost:8000/api/connexions';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // Authentification réussie
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', responseData['access_token']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AjouterEmployeInterface()),
      );
    } else {
      // Gérer l'erreur d'authentification
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur de connexion'),
            content: Text('Adresse e-mail ou mot de passe incorrect.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } else {
    // Gérer le cas où les champs d'email ou de mot de passe sont vides
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Champs vides'),
          content: Text('Veuillez remplir tous les champs.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Se connecter'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InscriptionInterface()),
                );
              },
              child: Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
