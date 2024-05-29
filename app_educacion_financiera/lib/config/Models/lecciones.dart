class Lecciones {
  final int idLeccion;
  final int idTema;
  final String titulo;
  final String descripcion;
  final String imagen;
  final double progreso;
  final int idEstudiante;

  Lecciones(
      {required this.idLeccion,
      required this.idTema,
      required this.titulo,
      required this.descripcion,
      required this.imagen,
      required this.progreso,
      required this.idEstudiante});

  factory Lecciones.fromJson(Map<String, dynamic> json) {
    return Lecciones(
      idTema: json['idTema'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      idLeccion: json['idLeccion'],
      imagen: json['imagen_Titulo'],
      progreso: json['progreso'],
      idEstudiante: json['idEstudiante'],
    );
  }
  static List<Lecciones> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => Lecciones.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idTema': idTema,
      'titulo': titulo,
      'descripcion': descripcion,
      'idLeccion': idLeccion,
      'imagen_titulo': imagen,
      'progreso': progreso,
      'idEstudiante': idEstudiante
    };
  }
}
