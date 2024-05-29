class Estudiante {
  final int idEstudiante;
  final String usuario;
  final String pwd;
  final String nombreUsuario;
  final DateTime fechaNacimiento;
  final double puntaje;
  final int nivel;
  final String email;

  Estudiante({
    required this.idEstudiante,
    required this.usuario,
    required this.pwd,
    required this.nombreUsuario,
    required this.fechaNacimiento,
    required this.puntaje,
    required this.nivel,
    required this.email,
  });

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      idEstudiante: json['idEstudiante'],
      usuario: json['usuario'],
      pwd: json['contraseña'],
      nombreUsuario: json['nombreUsuario'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      puntaje: json['puntaje'],
      nivel: json['nivel'],
      email: json['email'],
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'idEstudiante': idEstudiante,
      'usuario': usuario,
      'contraseña': pwd,
      'nombreUsuario': nombreUsuario,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'puntaje': puntaje,
      'nivel': nivel,
      'email': email,
    };
  }
  Estudiante copyWith({
    int? idEstudiante,
    String? usuario,
    String? pwd,
    String? nombreUsuario,
    DateTime? fechaNacimiento,
    double? puntaje,
    int? nivel,
    String? email,
  }) {
    return Estudiante(
      idEstudiante: idEstudiante ?? this.idEstudiante,
      usuario: usuario ?? this.usuario,
      pwd: pwd ?? this.pwd,
      nombreUsuario: nombreUsuario ?? this.nombreUsuario,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      puntaje: puntaje ?? this.puntaje,
      nivel: nivel ?? this.nivel,
      email: email ?? this.email,
    );
  }
}