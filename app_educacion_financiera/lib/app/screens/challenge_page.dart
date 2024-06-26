import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  ChallengePageState createState() => ChallengePageState();
}

class ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Desafíos',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopicCard(
              icon: Icons.lightbulb_outline,
              color: Colors.orange,
              title: 'Plan de ahorros',
              context: context,
              route: 'savingsplan',
            ),
            const SizedBox(height: 16.0),
            _buildTopicCard(
              icon: Icons.people_alt_outlined,
              color: Colors.blue,
              title: 'Competencia entre amigos',
              context: context,
              route: 'challengeFriend',
            ),
            const SizedBox(height: 16.0),
            _buildTopicCard(
              icon: Icons.leaderboard_outlined,
              color: Colors.green,
              title: 'Ranking',
              context: context,
              route: 'ranking',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard({
    required IconData icon,
    required Color color,
    required String title,
    required BuildContext context,
    required String route,
  }) {
    return GestureDetector(
      onTap: () {
        // Definir la acción cuando se toca la tarjeta
        appRouter.go('/$route');
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 40.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
            const SizedBox(
                height: 8.0), // Espacio adicional entre el texto y el icono
          ],
        ),
      ),
    );
  }
}
