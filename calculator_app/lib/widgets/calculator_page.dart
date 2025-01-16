import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CalculatorPage extends StatelessWidget {
  final String title;
  final Color color;
  final void Function(String, String) onCalculate;
  final String result;
  final String error;
  final TextEditingController num1Controller;
  final TextEditingController num2Controller;

  const CalculatorPage({
    super.key,
    required this.title,
    required this.color,
    required this.onCalculate,
    required this.result,
    required this.error,
    required this.num1Controller,
    required this.num2Controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: color.withOpacity(0.2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: num1Controller,
                        decoration: InputDecoration(
                          labelText: 'Primer número',
                          border: const OutlineInputBorder(),
                          errorText: error.isNotEmpty ? error : null,
                          prefixIcon: Icon(Icons.numbers, color: color),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: num2Controller,
                        decoration: InputDecoration(
                          labelText: 'Segundo número',
                          border: const OutlineInputBorder(),
                          errorText: error.isNotEmpty ? error : null,
                          prefixIcon: Icon(Icons.numbers, color: color),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => onCalculate(
                          num1Controller.text,
                          num2Controller.text,
                        ),
                        icon: Icon(Icons.calculate, color: Colors.white),
                        label: Text('Calcular $title'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (result.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Card(
                    color: color.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Resultado: $result',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn().slideY(
                    begin: 0.3,
                    curve: Curves.easeOutBack,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}