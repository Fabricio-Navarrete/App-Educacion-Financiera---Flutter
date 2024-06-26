import 'dart:convert';
import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:app_educacion_financiera/app/screens/savings_plan.dart';
import 'package:app_educacion_financiera/config/Models/savingsplan.dart';

class SavingsPlanListScreen extends StatefulWidget {
  const SavingsPlanListScreen({super.key});

  @override
  _SavingsPlanListScreenState createState() => _SavingsPlanListScreenState();
}

class _SavingsPlanListScreenState extends State<SavingsPlanListScreen> {
  List<SavingsPlan> _plans = [];

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    final String response = await DefaultAssetBundle.of(context).loadString('assets/savings_plans.json');
    final data = await json.decode(response);
    setState(() {
      _plans = (data['savingsPlans'] as List)
          .map((planJson) => SavingsPlan.fromJson(planJson))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _plans.length,
              itemBuilder: (context, index) {
                final plan = _plans[index];
                final progress = plan.currentSavings / plan.targetAmount;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Meta: \$${plan.targetAmount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${plan.currentSavings.toStringAsFixed(2)} ahorrados',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                              Text(
                                '${(progress * 100).toStringAsFixed(1)}%',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                              ),
                            ],
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
            MaterialPageRoute(builder: (context) => const SavingsPlanCreationScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}