class Respuestas {
  final int idRespuesta;
  final int idPregunta;
  final String descripcion;
  final bool estado;
  final bool correcto;

  Respuestas({required this.idRespuesta, required this.idPregunta, required this.descripcion, required this.estado, required this.correcto});

  factory Respuestas.fromJson(Map<String, dynamic> json) {
    return Respuestas(
      idRespuesta: json['idRespuesta'],
      idPregunta: json['idPregunta'],
      descripcion: json['descripcion'],
      estado: json['estado'],
      correcto: json['correcto'],
    );
  }
  static List<Respuestas> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => Respuestas.fromJson(json)).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      'idRespuesta': idRespuesta,
      'idPregunta': idPregunta,
      'descripcion': descripcion,
      'estado': estado,
      'correcto': correcto,
    };
  }
} 
