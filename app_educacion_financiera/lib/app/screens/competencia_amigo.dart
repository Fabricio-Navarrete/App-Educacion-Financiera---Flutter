import 'dart:async';
import 'dart:convert';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';

class FinancialChallengeModule extends StatelessWidget {
  const FinancialChallengeModule({super.key});

  @override
  Widget build(BuildContext context) {
    return OpponentSelectionScreen();
  }
}

class OpponentSelectionScreen extends StatelessWidget {
  final List<String> opponents = [
    'Fabricio',
    'Sandra',
    'Sandro',
    'Luis',
    'David',
    'Sandro'
  ]; // Simulated list of users

  OpponentSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecciona un oponente',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.go('/challenge');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: opponents.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                opponents[index],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Nivel: ${1}',
                style: TextStyle(fontSize: 16),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  opponents[index][0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        QuizScreen(opponent: opponents[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String opponent;

  const QuizScreen({Key? key, required this.opponent}) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  late Timer _timer;
  int _timeLeft = 30;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() async {
    // Simular carga de preguntas desde un archivo JSON
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/questions.json");
    List<dynamic> jsonResult = json.decode(data);
    setState(() {
      _questions = jsonResult.map((q) => Question.fromJson(q)).toList();
    });
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _timer.cancel();
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    _timer.cancel();
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isAnswered = false;
        _timeLeft = 30;
      });
      _startTimer();
    } else {
      // Fin del quiz
      _showResult();
    }
  }

  int? _selectedAnswerIndex;

  void _selectAnswer(int index, bool isCorrect) {
    if (!_isAnswered) {
      setState(() {
        _selectedAnswerIndex = index;

        _isAnswered = true;
        if (isCorrect) _score++;
      });
      _timer.cancel();
      Future.delayed(const Duration(seconds: 2), _nextQuestion);
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resultado del Desafío'),
          content: Text(
              'Tu puntuación: $_score/${_questions.length}\nOponente: ${widget.opponent}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Volver'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafío contra ${widget.opponent}'),
        elevation: 0,
      ),
      body: _questions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProgressAndTimer(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildQuestion(),
                          _buildAnswers(),
                        ],
                      ),
                    ),
                  ),
                  _buildStatusMessage(),
                ],
              ),
            ),
    );
  }

  Widget _buildProgressAndTimer() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pregunta ${_currentQuestionIndex + 1}/${_questions.length}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  _timeLeft <= 10 ? Colors.red.shade100 : Colors.blue.shade100,
            ),
            child: Text(
              '$_timeLeft',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _timeLeft <= 10 ? Colors.red : Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        _questions[_currentQuestionIndex].questionText,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnswers() {
    return Column(
      children: _questions[_currentQuestionIndex]
          .answers
          .asMap()
          .entries
          .map((entry) {
        final int idx = entry.key;
        final Answer answer = entry.value;
        final bool isSelected = _selectedAnswerIndex == idx;
        final bool showResult = _isAnswered && isSelected;

        Color getButtonColor() {
          if (!_isAnswered) return Colors.white;
          if (isSelected) {
            return answer.isCorrect
                ? Colors.green.shade100
                : Colors.red.shade100;
          }
          if (_isAnswered && answer.isCorrect) return Colors.green;
          return Colors.white;
        }

        Color getBorderColor() {
          if (!_isAnswered) return Colors.grey.shade300;
          if (isSelected) {
            return answer.isCorrect ? Colors.green : Colors.red;
          }
          if (_isAnswered && answer.isCorrect) return Colors.green;
          return Colors.grey.shade300;
        }

        IconData? getIcon() {
          if (!showResult) return null;
          return answer.isCorrect ? Icons.check_circle : Icons.cancel;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ElevatedButton(
              onPressed: _isAnswered
                  ? null
                  : () => _selectAnswer(idx, answer.isCorrect),
              style: ElevatedButton.styleFrom(
                backgroundColor: getButtonColor(),
                foregroundColor: Colors.black87,
                elevation: isSelected ? 4 : 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: getBorderColor(), width: 2),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      answer.text,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (showResult)
                    Icon(
                      getIcon(),
                      color: answer.isCorrect ? Colors.green : Colors.red,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatusMessage() {
    return _isAnswered
        ? Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey,
            child: const Text(
              'Esperando siguiente pregunta...',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

class Question {
  final String questionText;
  final List<Answer> answers;

  Question({required this.questionText, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    var answersJson = json['answers'] as List;
    List<Answer> answersList =
        answersJson.map((i) => Answer.fromJson(i)).toList();

    return Question(
      questionText: json['questionText'],
      answers: answersList,
    );
  }
}

class Answer {
  final String text;
  final bool isCorrect;

  Answer({required this.text, required this.isCorrect});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}
