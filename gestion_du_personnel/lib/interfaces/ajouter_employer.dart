import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class AjouterEmployeInterface extends StatefulWidget {
const AjouterEmployeInterface({Key? key}) : super(key: key);
  @override
  _AjouterEmployeInterfaceState createState() => _AjouterEmployeInterfaceState();
}

class _AjouterEmployeInterfaceState extends State<AjouterEmployeInterface> {
  String _civilite = 'Monsieur';
  String _typeContrat = 'CDI';

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _numeroCellulaireController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> ajouterEmploye(String civilite, String nom, String prenom, String numeroCellulaire, String typeContrat) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/ajouter-employe');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'civilite': civilite,
        'nom': nom,
        'prenom': prenom,
        'numeroCellulaire': numeroCellulaire,
        'typeContrat': typeContrat,
      }),
    );

    if (response.statusCode == 200) {
      // Employé ajouté avec succès
      print('Employé ajouté avec succès');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employé ajouté avec succès')),
      );
    } else {
      // Erreur lors de l'ajout de l'employé
      print('Erreur lors de l\'ajout de l\'employé: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'ajout de l\'employé')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un employé'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _civilite,
                onChanged: (value) {
                  setState(() {
                    _civilite = value!;
                  });
                },
                items: ['Monsieur', 'Madame', 'Mademoiselle']
                    .map((civilite) => DropdownMenuItem(
                          value: civilite,
                          child: Text(civilite),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Civilité'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nomController,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _prenomController,
                decoration: InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prénom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _numeroCellulaireController,
                decoration: InputDecoration(labelText: 'Numéro de cellulaire'),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un numéro de cellulaire';
                  }
                  if (value.length != 10) {
                    return 'Le numéro de cellulaire doit avoir 10 chiffres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _typeContrat,
                onChanged: (value) {
                  setState(() {
                    _typeContrat = value!;
                  });
                },
                items: ['CDI', 'Stage', 'CDD', 'Intérim']
                    .map((contrat) => DropdownMenuItem(
                          value: contrat,
                          child: Text(contrat),
                        ))
                    .toList(),
                decoration: InputDecoration(labelText: 'Type de contrat'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ajouterEmploye(
                      _civilite,
                      _nomController.text,
                      _prenomController.text,
                      _numeroCellulaireController.text,
                      _typeContrat,
                    );
                  }
                },
                child: Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
