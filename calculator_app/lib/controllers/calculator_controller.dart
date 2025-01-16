import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/operation.dart';

// Proveedor global para el controlador de la calculadora
final calculatorProvider = Provider((ref) => CalculatorController());

class CalculatorController {
  final Calculator calculator = Calculator();

  // Método para ejecutar cualquier operación
  double executeOperation(double num1, double num2, Operation operation) {
    try {
      return operation(num1, num2);
    } catch (e) {
      rethrow; // Propaga el error para manejarlo en la UI
    }
  }
}