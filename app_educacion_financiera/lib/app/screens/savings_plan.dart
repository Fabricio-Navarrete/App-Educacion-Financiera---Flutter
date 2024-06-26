import 'package:flutter/material.dart';

class SavingsPlanCreationScreen extends StatefulWidget {
  const SavingsPlanCreationScreen({super.key});

  @override
  _SavingsPlanCreationScreenState createState() => _SavingsPlanCreationScreenState();
}

class _SavingsPlanCreationScreenState extends State<SavingsPlanCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _goalName = '';
  double _targetAmount = 0;
  int _months = 0;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _savePlan();
      _showSummary();
    }
  }

  void _savePlan() {
    // Aquí simularíamos guardar el plan en una base de datos o API
    print('Plan guardado: $_goalName, \$${_targetAmount}, $_months meses');
  }

  void _showSummary() {
    double monthlySavings = _targetAmount / _months;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Resumen del Plan de Ahorro', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _summaryItem('Meta', _goalName),
              _summaryItem('Monto objetivo', '\$${_targetAmount.toStringAsFixed(2)}'),
              _summaryItem('Plazo', '$_months meses'),
              _summaryItem('Ahorro mensual', '\$${monthlySavings.toStringAsFixed(2)}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Aceptar', style: TextStyle(color: Colors.cyan)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Volver a la pantalla de introducción
              },
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        );
      },
    );
  }

  Widget _summaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: const Text('Crear Plan de Ahorro'),
        elevation: 0,
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Diseña tu Plan de Ahorro',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  label: 'Nombre de tu meta',
                  icon: Icons.flag,
                  validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre para tu meta' : null,
                  onSaved: (value) => _goalName = value!,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Monto objetivo (\$)',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Por favor ingresa un monto';
                    if (double.tryParse(value) == null) return 'Por favor ingresa un número válido';
                    return null;
                  },
                  onSaved: (value) => _targetAmount = double.parse(value!),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Plazo (meses)',
                  icon: Icons.calendar_today,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Por favor ingresa un plazo';
                    if (int.tryParse(value) == null) return 'Por favor ingresa un número entero';
                    return null;
                  },
                  onSaved: (value) => _months = int.parse(value!),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text('Crear Plan', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
  }) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.cyan),
        prefixIcon: Icon(icon, color: Colors.cyan),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.cyan),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.cyan.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.cyan),
        ),
        filled: true,
        fillColor: Colors.grey[800],
      ),
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}