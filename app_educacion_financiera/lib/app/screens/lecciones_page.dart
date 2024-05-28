import 'package:app_educacion_financiera/config/Infraestructure/Repositories/lecciones_repository.dart';
import 'package:app_educacion_financiera/config/Models/Temas.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';

class LearningTopics extends StatelessWidget {
  
  LearningTopics({Key? key}) : super(key: key);
  final LeccionesRepository _leccionesRepository = LeccionesRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas de Aprendizaje'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.go('/main');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aprende sobre finanzas personales',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            FutureBuilder<List<Temas>>(
              future: _leccionesRepository.getTemas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtienen los datos
                } else if (snapshot.hasError) {
                  return Text('Error al cargar los temas: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No se encontraron temas.');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Temas tema = snapshot.data![index];
                        return _buildTopicCard(
                          icon: 'assets/Imagenes/${tema.icono}',
                          title: tema.titulo,
                          context: context,
                          idTema: tema.idTema,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard(
      {required String icon,
      required String title,
      required BuildContext context,
      required int idTema}) {
    return SizedBox(
      height: 100, // Ajusta a tu necesidad
      width: double.infinity, // Ocupa todo el ancho disponible
      child: Card(
        child: Center(
          child: ListTile(
            leading: Image.asset(
              icon,
              width: 50,
              height: 50,
            ),
            title: Text(title),
            onTap: () {
              appRouter.go('/leccion/$idTema');
            },
          ),
        ),
      ),
    );
  }
}
