class Temas {
  final int idTema;
  final String titulo;
  final String descripcion;
  final String icono;

  Temas({required this.idTema, required this.titulo, required this.descripcion, required this.icono});
  
  factory Temas.fromJson(Map<String, dynamic> json) {
    return Temas(
      idTema: json['idTema'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      icono: json['icono'],
    );
  }
  static List<Temas> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => Temas.fromJson(json)).toList();
  }
  Map<String, dynamic> toJson() {
    return {
      'idTema': idTema,
      'titulo': titulo,
      'descripcion': descripcion,
      'icono': icono,
    };
  }
}
