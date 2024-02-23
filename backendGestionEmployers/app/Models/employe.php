<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Employe extends Model
{
    protected $table = 'employes'; // Nom de la table dans la base de données

    protected $fillable = ['civilite', 'nom', 'prenom', 'numero_cellulaire', 'type_contrat'];

    // Autres propriétés ou méthodes de la classe
}
