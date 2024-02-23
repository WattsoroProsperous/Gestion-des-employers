<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Employe; // Assurez-vous d'importer le modèle Employe

class EmployeController extends Controller
{
    public function ajouterEmploye(Request $request)
    {
        // Valider les données entrantes
        $request->validate([
            'civilite' => 'required',
            'nom' => 'required',
            'prenom' => 'required',
            'numeroCellulaire' => 'required',
            'typeContrat' => 'required',
        ]);

        // Créer un nouvel employé
        $employe = new Employe();
        $employe->civilite = $request->civilite;
        $employe->nom = $request->nom;
        $employe->prenom = $request->prenom;
        $employe->numero_cellulaire = $request->numeroCellulaire;
        $employe->type_contrat = $request->typeContrat;

        // Enregistrer l'employé dans la base de données
        $employe->save();

        // Répondre avec un message de succès
        return response()->json(['message' => 'Employé ajouté avec succès'], 200);
    }
}
