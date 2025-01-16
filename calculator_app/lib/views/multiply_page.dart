import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/calculator_page.dart';
import '../controllers/calculator_controller.dart';
import 'cover_page.dart';
import '../main.dart';


class MultiplyPage extends ConsumerStatefulWidget {
  const MultiplyPage({super.key});

  @override
  ConsumerState<MultiplyPage> createState() => _MultiplyPageState();
}

class _MultiplyPageState extends ConsumerState<MultiplyPage> {
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  String result = '';
  String error = '';
  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  ref.read(selectedPageProvider.notifier).state = const WelcomePage();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Carátula'),
                onTap: () {
                  ref.read(selectedPageProvider.notifier).state = const CoverPage();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _performOperation(String num1Text, String num2Text) {
    setState(() {
      error = '';
      result = '';
    });

    final num1 = double.tryParse(num1Text);
    final num2 = double.tryParse(num2Text);

    if (num1 == null || num2 == null) {
      setState(() {
        error = 'Por favor, ingresa números válidos';
      });
      return;
    }

    try {
      final calculator = ref.read(calculatorProvider);
      final multiplyResult = calculator.executeOperation(
        num1,
        num2,
        calculator.calculator.multiply,
      );
      setState(() {
        result = multiplyResult.toStringAsFixed(2);
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context, ref),
        child: const Icon(Icons.menu),
      ),
      body: CalculatorPage(
        title: 'Multiplicación',
        color: Colors.blue,
        onCalculate: _performOperation,
        result: result,
        error: error,
        num1Controller: num1Controller,
        num2Controller: num2Controller,
      ),
    );
  }

  @override
  void dispose() {
    num1Controller.dispose();
    num2Controller.dispose();
    super.dispose();
  }
}