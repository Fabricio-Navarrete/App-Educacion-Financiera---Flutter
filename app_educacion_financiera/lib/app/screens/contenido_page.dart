import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:app_educacion_financiera/config/Infraestructure/Repositories/lecciones_repository.dart';
import 'package:app_educacion_financiera/config/Models/Lecciones.dart';
import 'package:app_educacion_financiera/config/constantes/enviroment.dart';

class LearningCourse extends StatelessWidget {
  final int idTema;
  LearningCourse({Key? key, required this.idTema}) : super(key: key);
  final LeccionesRepository _leccionesRepository = LeccionesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecciones'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.go('/learning');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Lecciones>>(
          future: _leccionesRepository.getLecciones(idTema),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error al cargar las lecciones: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No se encontraron lecciones.'),
              );
            } else {
              return SingleChildScrollView(
                child: Wrap(
                  spacing: 20, // Espacio entre cards en la dirección horizontal
                  runSpacing:
                      20, // Espacio entre cards en la dirección vertical
                  children: List.generate(
                    snapshot.data!.length,
                    (index) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5 -
                          30, // Ancho de cada card
                      child: LessonCard(leccion: snapshot.data![index]),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final Lecciones leccion;

  const LessonCard({Key? key, required this.leccion}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         appRouter.go('/contenidoAprendizaje/${leccion.idLeccion}/${leccion.titulo}');
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 350, // Altura fija de la tarjeta
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.network(
                        '${Environment.apiImg}/${leccion.imagen}',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leccion.titulo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        leccion.descripcion,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: leccion.progreso,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                        
                      ),
                      if (leccion.progreso == 1)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              '¡Completado!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
