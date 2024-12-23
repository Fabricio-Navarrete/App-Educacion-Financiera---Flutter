import 'package:app_educacion_financiera/config/Models/Lecciones.dart';
import 'package:app_educacion_financiera/config/Models/Temas.dart';
import 'package:app_educacion_financiera/config/Models/contenido_lecciones.dart';
import 'package:app_educacion_financiera/config/Models/getNivelEstudiante.dart';
import 'package:app_educacion_financiera/config/Models/listSavingsPlan.dart';
import 'package:app_educacion_financiera/config/Models/pregunas.dart';
import 'package:app_educacion_financiera/config/Models/respuestas.dart';

abstract class LeccionesDataSource {
  Future<List<Temas>> getTemas();
  Future<List<Lecciones>> getLecciones(int idTema);
  Future<List<ContenidoLecciones>> getContenidoLecciones(int idLeccion);
  Future<List<Preguntas>> getPreguntas(int idLeccion);
  Future<List<Respuestas>> getRespuestas(int idPregunta);
  Future<Lecciones> actualizarProgreso(
      int correctas, int total, int idLeccion, int idEstudiante);
  Future<GetNivelEstudiante> getNivelEstudiante(int idEstudiante);
  Future<List<Listsavingsplan>> listaAhorros(int idEstudiante);
  Future<Listsavingsplan> savePlan(String goalname, double cantidad, int id);
  Future<Listsavingsplan> updateSavings(int idMeta, double cantidad);
}
