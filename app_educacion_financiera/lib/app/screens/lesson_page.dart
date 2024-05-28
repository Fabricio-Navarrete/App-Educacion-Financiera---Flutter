import 'package:app_educacion_financiera/app/widgets/carrusel_cards.dart';
import 'package:app_educacion_financiera/config/Infraestructure/Repositories/lecciones_repository.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';

class LessonPage extends StatelessWidget {
  final int idLeccion;
  final String title;
  final LeccionesRepository _leccionesRepository = LeccionesRepository();
  LessonPage({super.key, required this.idLeccion, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.go('/learning');
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ContentCarousel(
              cardData: _leccionesRepository.getContenidoLecciones(idLeccion),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.8, // Ocupa todo el ancho
              child: ElevatedButton(
                onPressed: () {
                  appRouter
                      .go('/cuestionario/${idLeccion.toString()}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blue, // Cambia el color del botón a azul
                ),
                child: const Text(
                  '¡Pon a prueba tu conocimiento!',
                  style: TextStyle(
                      color:
                          Colors.white), // Cambia el color del texto a blanco
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
