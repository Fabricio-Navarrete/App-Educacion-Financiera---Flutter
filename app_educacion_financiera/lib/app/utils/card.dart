import 'package:app_educacion_financiera/config/constantes/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ContentCard extends StatelessWidget {
  final String title;
  final String content;
  final Color cardColor;
  final String iconPath;

  const ContentCard({
    Key? key,
    required this.title,
    required this.content,
    required this.cardColor,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.network('${Environment.apiAnimate}/$iconPath',
                  height: 200), // Icono animado
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF03301F),
                    fontFamily: 'Roboto'),
              ),
              const SizedBox(height: 8),
              Text(content,
                  style: const TextStyle(
                      color: Color(
                          0xFF03301F), // Cambia el color del texto del contenido aquí
                      fontFamily: 'Roboto')),
            ],
          ),
        ),
      ),
    );
  }
}
