import 'package:app_educacion_financiera/config/Models/Estudiante.dart';

abstract class EstudianteDataSource {
  
  Future<Estudiante> validarAcceso(String user, String password);
  Future<bool> registrarEstudiante(Estudiante estudiante);
}