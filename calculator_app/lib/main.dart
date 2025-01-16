import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/sum_page.dart';
import 'views/subtract_page.dart';
import 'views/multiply_page.dart';
import 'views/divide_page.dart';
import 'views/cover_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final selectedPageProvider = StateProvider<Widget>((ref) => const WelcomePage());

// Provider para el modo oscuro
final isDarkModeProvider = StateProvider<bool>((ref) => false);

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

    return MaterialApp(
      title: 'Operaciones Básicas',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      )
          : ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(selectedPageProvider);

    void _showBottomSheet(BuildContext context, WidgetRef ref) {
      final isDarkMode = ref.watch(isDarkModeProvider);
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
                    ref.read(selectedPageProvider.notifier).state =
                    const WelcomePage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Carátula'),
                  onTap: () {
                    ref.read(selectedPageProvider.notifier).state =
                    const CoverPage();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  title: Text(isDarkMode ? 'Modo Claro' : 'Modo Oscuro'),
                  onTap: () {
                    ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operaciones Básicas'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Calculadora',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Suma'),
              onTap: () {
                ref.read(selectedPageProvider.notifier).state =
                const SumPage();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.remove),
              title: const Text('Resta'),
              onTap: () {
                ref.read(selectedPageProvider.notifier).state =
                const SubtractPage();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('Multiplicación'),
              onTap: () {
                ref.read(selectedPageProvider.notifier).state =
                const MultiplyPage();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.percent),
              title: const Text('División'),
              onTap: () {
                ref.read(selectedPageProvider.notifier).state =
                const DividePage();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: selectedPage,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context, ref),
        child: const Icon(Icons.menu),
      ),
    );
  }
}

class WelcomePage extends ConsumerWidget {
  const WelcomePage({Key? key}) : super(key: key);

  void _showBottomSheet(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
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
                  ref.read(selectedPageProvider.notifier).state =
                  const WelcomePage();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Carátula'),
                onTap: () {
                  ref.read(selectedPageProvider.notifier).state =
                  const CoverPage();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                title: Text(isDarkMode ? 'Modo Claro' : 'Modo Oscuro'),
                onTap: () {
                  ref.read(isDarkModeProvider.notifier).state = !isDarkMode;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a la Calculadora',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecciona una operación en el menú lateral\no usa el menú inferior para más opciones.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () => _showBottomSheet(context, ref),
              icon: const Icon(Icons.menu),
              label: const Text('Abrir Menú'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context, ref),
        child: const Icon(Icons.menu),
      ),
    );
  }
}