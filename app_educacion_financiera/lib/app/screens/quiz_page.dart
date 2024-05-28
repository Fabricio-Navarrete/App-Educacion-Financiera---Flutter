import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _selectedOption = -1;
  int _correctAnswer = 2; // Índice de la respuesta correcta
  List<String> respuestas = ['El ahorro es simplemente la acumulación de dinero sin un propósito definido.', 
  'El ahorro se refiere exclusivamente a la inversión en bienes raíces para obtener beneficios a corto plazo.', 
  'El ahorro se define como la acción de reservar una parte de los ingresos o recursos disponibles para utilizarlos en el futuro.'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuestionario', style: TextStyle(fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Cuál es la definición de ahorro?',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 16.0),
              
              ...List<Widget>.generate(respuestas.length, (index) => RadioListTile<int>(
                  title: Text(respuestas[index], 
                  style: const TextStyle(fontSize: 15)), // Usamos las respuestas de la lista
                  value: index,
                  groupValue: _selectedOption,
                  onChanged: (int? value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                )),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_selectedOption == _correctAnswer) {
                    // Muestra un mensaje si la respuesta es correcta
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('¡Correcto!')),
                    );
                  } else {
                    // Muestra un mensaje si la respuesta es incorrecta
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Incorrecto. Intenta de nuevo.')),
                    );
                  }
                },
               child: const Text(
                    'Enviar',
                    style: TextStyle(color: Colors.white),
                  ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 20),
                   
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}