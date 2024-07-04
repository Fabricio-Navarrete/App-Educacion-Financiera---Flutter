import 'dart:convert';
import 'package:app_educacion_financiera/config/Infraestructure/Repositories/lecciones_repository.dart';
import 'package:app_educacion_financiera/config/Models/Estudiante.dart';
import 'package:app_educacion_financiera/config/Models/listSavingsPlan.dart';
import 'package:app_educacion_financiera/config/Provider/estudiante_provider.dart';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:app_educacion_financiera/app/screens/savings_plan.dart';
import 'package:app_educacion_financiera/config/Models/savingsplan.dart';
import 'package:provider/provider.dart';

class SavingsPlanListScreen extends StatefulWidget {
  const SavingsPlanListScreen({super.key});

  @override
  _SavingsPlanListScreenState createState() => _SavingsPlanListScreenState();
}

class _SavingsPlanListScreenState extends State<SavingsPlanListScreen> {
  List<Listsavingsplan> _plans = [];
  late LeccionesRepository _leccionesRepository;
  int idEstudiante = 0;

  @override
  void initState() {
    super.initState();
    _leccionesRepository = LeccionesRepository();
  }

  Future<void> _loadPlans() async {
    try {
      final plans = await _leccionesRepository.listaAhorros(idEstudiante);
      setState(() {
        _plans = plans;
      });
    } catch (e) {
      // Manejar error
      print('Error al cargar los planes de ahorro: $e');
    }
  }

  Future<void> _updateSavings(
      BuildContext context, Listsavingsplan plan) async {
    final TextEditingController controller = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actualizar ahorro para ${plan.goalName}'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(hintText: 'Ingrese el monto ahorrado'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () async{
                final newSavings = double.tryParse(controller.text);
                if (newSavings != null) {
                  print(
                      'Nuevo monto ahorrado para ${plan.goalName}: \$${newSavings.toStringAsFixed(2)}');
                  // Aquí puedes llamar a tu API para actualizar el ahorro
                  await _leccionesRepository.updateSavings(plan.id, newSavings); // Ejemplo
                  _loadPlans(); // Recargar los planes de ahorro
                  Navigator.of(context).pop();
                } else {
                  print('Entrada no válida');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Estudiante? estudiante = Provider.of<EstudianteModel>(context).estudiante;
    if (estudiante != null) {
      idEstudiante = estudiante.idEstudiante;
      _loadPlans();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis planes de ahorro',
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
      body: _plans.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.savings_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No tienes planes de ahorro',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Crea uno nuevo con el botón +',
              style: TextStyle(fontSize: 14, color: Colors.grey[400]),
            ),
          ],
        ),
      )
    
          : ListView.builder(
              itemCount: _plans.length,
              itemBuilder: (context, index) {
                final plan = _plans[index];
                final progress = plan.currentSavings / plan.targetAmount;
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      // Navegar a la pantalla de detalles del plan
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.goalName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Meta: \$${plan.targetAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${plan.currentSavings.toStringAsFixed(2)} ahorrados',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                              Text(
                                '${(progress * 100).toStringAsFixed(1)}%',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _updateSavings(context, plan),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            child: const Text('Actualizar Ahorro',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SavingsPlanCreationScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
