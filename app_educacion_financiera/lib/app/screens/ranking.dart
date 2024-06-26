import 'package:app_educacion_financiera/config/Infraestructure/Repositories/EstudianteRepository.dart';
import 'package:app_educacion_financiera/config/Models/Estudiante.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  final EstudianteRepository estudianteRepository = EstudianteRepository();

  RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tabla de posición',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Estudiante>>(
          future: estudianteRepository.listaUsuarios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay usuarios disponibles'));
            } else {
              final usuarios = snapshot.data!;
              // Ordenar los usuarios por nivel de mayor a menor
              usuarios.sort((a, b) => b.nivel.compareTo(a.nivel));
              return _buildRankingTable(usuarios);
            }
          },
        ),
      ),
    );
  }

   Widget _buildRankingTable(List<Estudiante> usuarios) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowHeight: 48,
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
        headingRowColor: WidgetStateColor.resolveWith(
          (states) => Colors.grey[900]!,
        ),
        border: TableBorder.all(color: Colors.grey[800]!),
        columns: const [
          DataColumn(label: Text('Pos')),
          DataColumn(label: Text('Jugador')),
          DataColumn(label: Text('Nivel')),
        ],
        rows: List<DataRow>.generate(
          usuarios.length,
          (index) {
            final usuario = usuarios[index];
            return _buildPlayerDataRow(
              rank: index + 1,
              playerName: usuario.nombreUsuario,
              playerScore: usuario.nivel,
              isOdd: index.isOdd,
            );
          },
        ),
      ),
    );
  }
  DataRow _buildPlayerDataRow({
    required int rank,
    required String playerName,
    required int playerScore,
    required bool isOdd,
  }) {
    return DataRow(
      color: MaterialStateColor.resolveWith(
        (states) => isOdd ? Colors.grey[850]! : Colors.grey[800]!,
      ),
      cells: [
        DataCell(
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 8),
              Text(
                '$rank',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            width: 150, // Ajusta el ancho de la columna "Jugador" según sea necesario
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    playerName[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    playerName,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        DataCell(
          Text(
            '$playerScore',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
