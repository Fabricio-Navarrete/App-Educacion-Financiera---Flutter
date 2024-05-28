import 'package:app_educacion_financiera/config/Infraestructure/Repositories/lecciones_repository.dart';
import 'package:app_educacion_financiera/config/Models/pregunas.dart';
import 'package:app_educacion_financiera/config/Models/respuestas.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';

class QuestionnaireScreen extends StatefulWidget {
  final int idLeccion;

  const QuestionnaireScreen({super.key, required this.idLeccion});

  @override
  QuestionnaireScreenState createState() => QuestionnaireScreenState();
}

class QuestionnaireScreenState extends State<QuestionnaireScreen> {
  late int idLeccion;
  List<Preguntas> questions = [];
  List<Respuestas> respuestas = [];
  final LeccionesRepository _leccionesRepository = LeccionesRepository();

  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int correctAnswersCount = 0;

  @override
  void initState() {
    super.initState();
    idLeccion = widget.idLeccion;
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    questions = await _leccionesRepository.getPreguntas(idLeccion);
    if (questions.isNotEmpty) {
      loadRespuestas(questions[currentQuestionIndex].idPregunta);
    }
    setState(() {});
  }

  Future<void> loadRespuestas(int idPregunta) async {
    respuestas = await _leccionesRepository.getRespuestas(idPregunta);
    selectedAnswerIndex = null;
    setState(() {});
  }
  Future<void> updateProgress() async {
    await _leccionesRepository.actualizarProgreso(correctAnswersCount, questions.length, idLeccion);
  } 

  void selectAnswer(int index) {
    setState(() {
      selectedAnswerIndex = index;
      if (respuestas[index].correcto) {
        correctAnswersCount++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        loadRespuestas(questions[currentQuestionIndex].idPregunta);
      });
    } else {
      updateProgress();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Resultado del cuestionario'),
            content: Text('Respuestas correctas: $correctAnswersCount/${questions.length}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  appRouter.go('/learning');
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuestionario'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.go('/learning');
          },
        ),
      ),
      body: questions.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildQuestionCard(),
                  if (selectedAnswerIndex != null) ...[
                    const SizedBox(height: 16.0),
                    _buildNextButton(),
                  ],
                ],
              ),
            ),
    );
  }

  Widget _buildQuestionCard() {
    final pregunta = questions[currentQuestionIndex];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            pregunta.descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          ...respuestas.asMap().entries.map((entry) {
            final index = entry.key;
            final respuesta = entry.value;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedAnswerIndex == index ? Colors.green : Colors.white,
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: selectedAnswerIndex == index ? Colors.green.shade100 : Colors.white,
              ),
              child: ElevatedButton(
                onPressed: () => selectAnswer(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    respuesta.descripcion,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: nextQuestion,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 22, 11, 171),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text('Siguiente'),
    );
  }
}
