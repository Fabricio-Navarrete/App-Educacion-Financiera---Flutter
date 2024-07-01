import 'package:app_educacion_financiera/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WeeklyBudgetScreen extends StatefulWidget {
  @override
  _WeeklyBudgetScreenState createState() => _WeeklyBudgetScreenState();
}

class _WeeklyBudgetScreenState extends State<WeeklyBudgetScreen> {
  double weeklyBudget = 100.0;
  double spent = 0.0;
  List<Expense> expenses = [];

  void addExpense(String category, double amount) {
    setState(() {
      expenses.add(Expense(category, amount));
      spent += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Presupuesto Semanal'),
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            appRouter.go('/weeklychallenges');
          },
        ),
      ),
      body: Column(
        children: [
          BudgetProgressBar(weeklyBudget: weeklyBudget, spent: spent),
          Expanded(
            child: ExpenseList(expenses: expenses),
          ),
        ],
      ),
      floatingActionButton: AddExpenseButton(onAddExpense: addExpense),
    );
  }
}

class BudgetProgressBar extends StatelessWidget {
  final double weeklyBudget;
  final double spent;

  BudgetProgressBar({required this.weeklyBudget, required this.spent});

  @override
  Widget build(BuildContext context) {
    double percentage = (spent / weeklyBudget).clamp(0.0, 1.0);
    Color progressColor = percentage < 0.7 ? Colors.green : (percentage < 0.9 ? Colors.orange : Colors.red);

    return Container(
      padding:const  EdgeInsets.all(16),
      child: Column(
        children: [
         const Text(
            '¡Tu Misión: Mantén tu presupuesto!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 15.0,
            percent: percentage,
            center: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$${spent.toStringAsFixed(2)}',
                  style:const  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('de \$${weeklyBudget.toStringAsFixed(2)}'),
              ],
            ),
            progressColor: progressColor,
            backgroundColor: Colors.grey[700]!,
            animation: true,
            animationDuration: 1000,
          ),
          const SizedBox(height: 16),
          Text(
            getMotivationalMessage(percentage),
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String getMotivationalMessage(double percentage) {
    if (percentage < 0.5) return '¡Excelente control! Sigue así.';
    if (percentage < 0.7) return 'Vas bien, pero ten cuidado con tus gastos.';
    if (percentage < 0.9) return '¡Alerta! Estás gastando rápido.';
    return '¡Cuidado! Estás a punto de superar tu presupuesto.';
  }
}

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  ExpenseList({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? const Center(child: Text('No hay gastos aún. ¡Añade uno!'))
        : ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: getIconForCategory(expenses[index].category),
                title: Text(expenses[index].category),
                trailing: Text('\$${expenses[index].amount.toStringAsFixed(2)}'),
              );
            },
          );
  }

  Icon getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'comida':
        return const Icon(Icons.fastfood, color: Colors.orange);
      case 'transporte':
        return const Icon(Icons.directions_bus, color: Colors.blue);
      case 'entretenimiento':
        return const Icon(Icons.movie, color: Colors.purple);
      default:
        return const Icon(Icons.attach_money, color: Colors.green);
    }
  }
}

class AddExpenseButton extends StatelessWidget {
  final Function(String, double) onAddExpense;

  AddExpenseButton({required this.onAddExpense});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => _showAddExpenseDialog(context),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    String category = 'Comida';
    String amount = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Añadir Gasto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: category,
                items: ['Comida', 'Transporte', 'Entretenimiento', 'Otros']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) => category = value!,
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto (\$)'),
                onChanged: (value) => amount = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Añadir'),
              onPressed: () {
                if (amount.isNotEmpty) {
                  onAddExpense(category, double.parse(amount));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class Expense {
  final String category;
  final double amount;

  Expense(this.category, this.amount);
}