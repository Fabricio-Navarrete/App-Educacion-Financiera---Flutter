import 'package:app_educacion_financiera/config/Infraestructure/Datasources/LeccionesDataSource.dart';
import 'package:app_educacion_financiera/config/Models/Lecciones.dart';
import 'package:app_educacion_financiera/config/Models/Temas.dart';
import 'package:app_educacion_financiera/config/Models/contenido_lecciones.dart';
import 'package:app_educacion_financiera/config/Models/pregunas.dart';
import 'package:app_educacion_financiera/config/Models/respuestas.dart';
import 'package:app_educacion_financiera/config/constantes/enviroment.dart';
import 'package:dio/dio.dart';

class LeccionesRepository implements LeccionesDataSource {
  final Dio _dio = Dio();

  @override
  Future<List<Temas>> getTemas() async {
    try {
      final response =
          await _dio.get('${Environment.apiUrl}LeccionApp/ListTemas');
      return Temas.fromListJson(response.data);
    } catch (e) {
      throw Exception('Error al obtener los datos de los temas');
    }
  }

  @override
  Future<List<Lecciones>> getLecciones(int idTema) async {
    try {
      final response = await _dio
          .get('${Environment.apiUrl}LeccionApp/ListLecciones?idTema=$idTema');
      return Lecciones.fromListJson(response.data);
    } catch (e) {
      throw Exception('Error al obtener los datos de los temas');
    }
  }

  @override
  Future<List<ContenidoLecciones>> getContenidoLecciones(int idLeccion) async {
    try {
      final response = await _dio.get(
          '${Environment.apiUrl}LeccionApp/ListContenidoLecciones?idLeccion=$idLeccion');
      return ContenidoLecciones.fromListJson(response.data);
    } catch (e) {
      throw Exception('Error al obtener los datos de los temas');
    }
  }

  @override
  Future<List<Preguntas>> getPreguntas(int idLeccion) async {
    try {
      final response = await _dio.get(
          '${Environment.apiUrl}LeccionApp/ListPreguntas?idLeccion=$idLeccion');
      var listPreguntas = Preguntas.fromListJson(response.data);
      return listPreguntas;
    } catch (e) {
      throw Exception('Error al obtener los datos de las preguntas');
    }
  }

  @override
  Future<List<Respuestas>> getRespuestas(int idPregunta) async {
    try {
      final response = await _dio.get(
          '${Environment.apiUrl}LeccionApp/ListRespuestas?idPregunta=$idPregunta');
      var list = Respuestas.fromListJson(response.data);
      return list;
    } catch (e) {
      throw Exception('Error al obtener los datos de las respuestas');
    }
  }
  
  @override
  Future<Lecciones> actualizarProgreso(int correctas , int total, int idLeccion) async{
    try{
      final Lecciones leccion = Lecciones(idLeccion: idLeccion, idTema: 0, titulo: '', descripcion: '', imagen: '', progreso: correctas/total);
      final response = await _dio.post('${Environment.apiUrl}LeccionApp/ActualizarProgreso', data: leccion.toJson());
      return leccion;
    }
    catch(e){
      throw Exception('Error al actualizar el progreso');
    }
  }
}