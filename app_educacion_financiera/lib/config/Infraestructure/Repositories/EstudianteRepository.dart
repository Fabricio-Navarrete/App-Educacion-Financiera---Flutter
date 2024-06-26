import 'package:app_educacion_financiera/config/Infraestructure/Datasources/EstudianteDataSource.dart';
import 'package:app_educacion_financiera/config/Models/Estudiante.dart';
import 'package:app_educacion_financiera/config/constantes/enviroment.dart';
import 'package:dio/dio.dart';

class EstudianteRepository implements EstudianteDataSource {
  final Dio _dio = Dio();

  @override
  Future<Estudiante> validarAcceso(String user, String password) async {
    try {
      final response = await _dio.get(
        '${Environment.apiUrl}UsuariosApp/ValidarAcceso',
        queryParameters: {
          'user': user,
          'pwd': password,
        },
      );
      return Estudiante.fromJson(response.data);
    } catch (e) {
      throw Exception('Error al obtener los datos del estudiante');
    }
  }

  @override
  Future<bool> registrarEstudiante(Estudiante estudiante) async {
    try {
      final response = await _dio.post(
        '${Environment.apiUrl}UsuariosApp/RegistrarEstudiante',
        data: estudiante.toJson(),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<List<Estudiante>> listaUsuarios() async{
    try {
      final response = await _dio.get('${Environment.apiUrl}UsuariosApp/ListarUsuarios');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Estudiante.fromJson(json)).toList();
      } else {
        throw Exception('Error al obtener la lista de usuarios');
      }
    } catch (e) {
      throw Exception('Error al obtener la lista de usuarios');
    }
  }
}
