import 'package:flutter/material.dart';
import 'package:gestion_du_personnel/interfaces/connexion_interface.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'ajouter_employer.dart';

class InscriptionInterface extends StatefulWidget {
  @override
  _InscriptionInterfaceState createState() => _InscriptionInterfaceState();
}

class _InscriptionInterfaceState extends State<InscriptionInterface> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    final String apiUrl = 'http://localhost:8000/api/inscriptions';
    final response = await http.post(Uri.parse(apiUrl), body: {
      'name': _nameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    });
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', responseData['token']);
      // Redirection vers une autre interface
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AjouterEmployeInterface()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur d\'inscription'),
            content: Text(responseData['message']),
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
        title: Text('Inscription'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            SizedBox(height: 20.0),
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
              onPressed: _signup,
              child: Text('S\'inscrire'),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConnexionInterface()),
      );
              },
              child: Text('Retour à la connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
