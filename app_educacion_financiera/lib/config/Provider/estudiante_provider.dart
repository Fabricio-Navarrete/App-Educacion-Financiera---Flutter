import 'package:app_educacion_financiera/config/Models/Estudiante.dart';
import 'package:flutter/material.dart';

class EstudianteModel extends ChangeNotifier{
  Estudiante? _estudiante;

  Estudiante? get estudiante => _estudiante;

  void setEstudiante(Estudiante estudiante){
    _estudiante = estudiante;
    notifyListeners();
  }
}