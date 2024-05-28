import 'package:flutter/material.dart';

class FriendCompetition extends StatelessWidget {
  const FriendCompetition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Competencia entre amigos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  _buildFriendCard(
                    icon: 'assets/Imagenes/user1.png',
                    name: 'Luis',
                    challengeDescription: '¡Luis ha comenzado el desafío de ahorrar un 10% más este mes! ¿Te unes?',
                    context: context,
                  ),
                  const SizedBox(height: 16.0),
                  _buildFriendCard(
                    icon: 'assets/Imagenes/user2.png',
                    name: 'José',
                    challengeDescription: '¡José quiere ahorrar para un viaje! ¿Quién ahorrará más rápido?',
                    context: context,
                  ),
                  const SizedBox(height: 16.0),
                  _buildFriendCard(
                    icon: 'assets/Imagenes/user3.png',
                    name: 'Gabriela',
                    challengeDescription: 'Gabriela te desafía a reducir gastos innecesarios y ahorrar más este mes. ¿Aceptas?',
                    context: context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendCard({
    required String icon,
    required String name,
    required String challengeDescription,
    required BuildContext context,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/competition');
        },
        child: ListTile(
          leading: Image.asset(
            icon,
            width: 40.0,
            height: 40.0,
          ),
          title: Text(name),
          subtitle: Text(challengeDescription),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
