class ContenidoLecciones {
  
  final int idcontenido;
  final int idleccion;
  final String titleCard; // Cambiado a lowerCamelCase
  final String content;
  final String cardColor;
  final String icon;

  ContenidoLecciones(
      {required this.idcontenido,
      required this.idleccion,
      required this.titleCard, // Cambiado a lowerCamelCase
      required this.content,
      required this.cardColor,
      required this.icon});

  factory ContenidoLecciones.fromJson(Map<String, dynamic> json) {
    return ContenidoLecciones(
      idcontenido: json['id_Contenido'],
      idleccion: json['idLeccion'],
      titleCard: json['title_card'], // Cambiado a lowerCamelCase
      content: json['content'],
      cardColor: json['card_color'],
      icon: json['icon'],
    );
  }
  static List<ContenidoLecciones> fromListJson(List<dynamic> listJson) {
    return listJson.map((json) => ContenidoLecciones.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id_Contenido': idcontenido,
      'idleccion': idleccion,
      'title_card': titleCard, // Cambiado a lowerCamelCase
      'content': content,
      'card_color': cardColor,
      'icon': icon,
    };
  }
}