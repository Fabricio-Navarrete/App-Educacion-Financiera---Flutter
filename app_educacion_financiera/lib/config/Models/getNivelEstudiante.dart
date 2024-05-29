class GetNivelEstudiante{

  final int idEstudiante;
  final int nivel;

  GetNivelEstudiante({required this.idEstudiante, required this.nivel});
  
  factory GetNivelEstudiante.fromJson(Map<String, dynamic> json) {
    return GetNivelEstudiante(
      idEstudiante: json['idEstudiante'],
      nivel: json['nivel'],
    );
  }
}