class Preguntas {
  final int idPregunta;
  final int idLeccion;
  final String descripcion;
  final bool estado;

  Preguntas(
      {required this.idPregunta,
      required this.idLeccion,
      required this.descripcion,
      required this.estado});

  factory Preguntas.fromJson(Map<String, dynamic> json) {
    return Preguntas(
      idPregunta: json['idPregunta'],
      idLeccion: json['idLeccion'],
      descripcion: json['descripcion'],
      estado: json['estado'],
    );
  }
  static List<Preguntas> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => Preguntas.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'idPregunta': idPregunta,
      'idLeccion': idLeccion,
      'descripcion': descripcion,
      'estado': estado,
    };
  }
}
