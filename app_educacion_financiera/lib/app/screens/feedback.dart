import 'package:flutter/material.dart';

class SavingsFeedbackScreen extends StatelessWidget {
  const SavingsFeedbackScreen({Key? key, required this.friendName}) : super(key: key);

  final String friendName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retroalimentación del desafío de ahorro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Imagenes/feedback_image.png',
                width: 200.0,
                height: 200.0,
              ),
              const SizedBox(height: 32.0),
              Text(
                '¡Hola, $friendName!',
              ),
              const SizedBox(height: 16.0),
               Text(
                '¡Gran esfuerzo $friendName este mes! \n\nPara mejorar aún más, te sugerimos seguir registrando tus gastos diarios y establecer un presupuesto más detallado para controlar mejor tus finanzas.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}