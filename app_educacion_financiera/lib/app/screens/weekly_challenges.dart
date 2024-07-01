import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class WeeklyChallengesScreen extends StatelessWidget {
  WeeklyChallengesScreen({Key? key}) : super(key: key);

  final String jsonData = '''
  {
    "weeklyChallenge": {
      "week": 23,
      "challenges": [
        {
          "id": 1,
          "title": "Presupuesto semanal",
          "description": "Crea un presupuesto para tus gastos de la próxima semana",
          "difficulty": "medium",
          "points": 100
        },
        {
          "id": 2,
          "title": "Ahorro inteligente",
          "description": "Encuentra tres formas de reducir tus gastos diarios",
          "difficulty": "easy",
          "points": 50
        },
        {
          "id": 3,
          "title": "Inversión simulada",
          "description": "Investiga y simula una inversión de S/. 1000 en acciones",
          "difficulty": "hard",
          "points": 200
        }
      ]
    }
  }
  ''';

  @override
  Widget build(BuildContext context) {
    final weeklyChallenge = json.decode(jsonData)['weeklyChallenge'];

    return Scaffold(
      appBar: AppBar(
        title: const  Text('Desafíos Semanales'),
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.go('/challenge');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Semana ${weeklyChallenge['week']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: weeklyChallenge['challenges'].length,
                itemBuilder: (context, index) {
                  final challenge = weeklyChallenge['challenges'][index];
                  return ChallengeCard(challenge: challenge);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final Map<String, dynamic> challenge;

  const ChallengeCard({Key? key, required this.challenge}) : super(key: key);

  Color _getDifficultyColor() {
    switch (challenge['difficulty']) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        appRouter.go('/presupuestoSemanal');
      },
      child: Card(
        color: const Color(0xFF1E1E1E),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                challenge['title'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                challenge['description'],
                style: TextStyle(color: Colors.grey[400]),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    challenge['difficulty'].toUpperCase(),
                    style: TextStyle(
                      color: _getDifficultyColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${challenge['points']} pts',
                    style: TextStyle(
                      color: Colors.blue[300],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}