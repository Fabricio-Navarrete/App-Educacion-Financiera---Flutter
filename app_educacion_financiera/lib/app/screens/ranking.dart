import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRankingTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingTable() {
    return DataTable(
      headingRowHeight: 48,
      dataRowHeight: 64,
      headingTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.white,
      ),
      columns: [
        DataColumn(label: Text('Posición')),
        DataColumn(label: Text('Jugador')),
        DataColumn(label: Text('Puntos')),
      ],
      rows: [
        _buildPlayerDataRow(rank: 1, playerName: 'Fabricio', playerScore: 100),
        _buildPlayerDataRow(rank: 2, playerName: 'Sandra', playerScore: 95),
        _buildPlayerDataRow(rank: 3, playerName: 'Juan', playerScore: 90),
        // Agrega más filas de jugadores para más posiciones
      ],
    );
  }

  DataRow _buildPlayerDataRow({
    required int rank,
    required String playerName,
    required int playerScore,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow),
              SizedBox(width: 8),
              Text(
                '$rank',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  playerName[0].toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 8),
              Text(
                playerName,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            '$playerScore',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
