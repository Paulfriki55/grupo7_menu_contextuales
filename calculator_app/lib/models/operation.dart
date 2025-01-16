// Definición del tipo de operación
typedef Operation = double Function(double num1, double num2);

class Calculator {
  // Operación de suma
  Operation add = (num1, num2) => num1 + num2;

  // Operación de resta
  Operation subtract = (num1, num2) => num1 - num2;

  // Operación de multiplicación
  Operation multiply = (num1, num2) => num1 * num2;

  // Operación de división con validación de división por cero
  Operation divide = (num1, num2) {
    if (num2 == 0) {
      throw ArgumentError('No es posible dividir por cero');
    }
    return num1 / num2;
  };
}