class Estudiante {
  final int idEstudiante;
  final String usuario;
  final String pwd;
  final String nombreUsuario;
  final DateTime fechaNacimiento;
  final double puntaje;
  final int nivel;
  final String email;
  final String apellido;
  final String genero;

  Estudiante({
    required this.idEstudiante,
    required this.usuario,
    required this.pwd,
    required this.nombreUsuario,
    required this.fechaNacimiento,
    required this.puntaje,
    required this.nivel,
    required this.email,
    required this.apellido,
    required this.genero
  });

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      idEstudiante: json['idEstudiante'],
      usuario: json['nombreUsuario'],
      pwd: json['password'],
      nombreUsuario: json['nombres'],
      apellido: json['apellidos'],
      genero: json['genero'],
      fechaNacimiento: DateTime.parse(json['fechaNacimiento']),
      puntaje: json['puntaje'],
      nivel: json['nivel'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'idEstudiante': idEstudiante,
      'nombreUsuario': usuario,
      'password': pwd,
      'nombres': nombreUsuario,
      'fechaNacimiento': fechaNacimiento.toIso8601String(),
      'puntaje': puntaje,
      'nivel': nivel,
      'email': email,
      'genero': genero,
      'apellidos' :apellido
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
    String? apellido,
    String? genero
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
      apellido: apellido ?? this.apellido,
      genero: genero ?? this.genero,
    );
  }
}
