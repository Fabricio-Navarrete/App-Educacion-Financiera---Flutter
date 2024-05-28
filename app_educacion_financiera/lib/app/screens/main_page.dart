import 'package:app_educacion_financiera/config/Models/Estudiante.dart';
import 'package:app_educacion_financiera/config/Provider/estudiante_provider.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Estudiante? estudiante = Provider.of<EstudianteModel>(context).estudiante;
    String user = '';
    double puntaje = 0.0;
    if (estudiante != null) {
      user = estudiante.nombreUsuario;
      puntaje = estudiante.puntaje;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Oculta el botón de retroceso
        title: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                user,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    height: 8,
                    child: LinearProgressIndicator(
                      value: puntaje,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // Icono para cerrar sesión
            onPressed: () {
              appRouter.go('/'); // Navegar a la pantalla de inicio de sesión
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: _buildButton(
                      icon: Image.asset(
                        'assets/Imagenes/chatbot.png',
                        width: 100,
                        height: 100,
                      ),
                      text: 'Asistente Virtual',
                      onPressed: () {
                        appRouter.go('/chatbot', extra: estudiante);
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: _buildButton(
                      icon: Image.asset(
                        'assets/Imagenes/leccion.png',
                        width: 100,
                        height: 100,
                      ),
                      text: 'Aprendizaje',
                      onPressed: () {
                        // Navegar a la pantalla de aprendizaje
                        appRouter.go('/learning', extra: estudiante);
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: _buildButton(
                      icon: Image.asset(
                        'assets/Imagenes/desafio.png',
                        width: 100,
                        height: 100,
                      ),
                      text: 'Desafío',
                      onPressed: () {
                        appRouter.go('/challenge', extra: estudiante);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required Image icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 10.0),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLevelUpDialog(BuildContext context, int level) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Subiste de nivel!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow[600],
                size: 100.0,
              ),
              Text(
                '$level',
                style: const TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
