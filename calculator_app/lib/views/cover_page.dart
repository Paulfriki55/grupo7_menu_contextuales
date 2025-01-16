import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';

class CoverPage extends ConsumerWidget {
  const CoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDarkMode ? Colors.blue.shade900 : Colors.blue.shade900,
              isDarkMode ? Colors.blue.shade700 : Colors.blue.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'UNIVERSIDAD DE LAS FUERZAS ARMADAS ESPE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(duration: const Duration(milliseconds: 500)).slideY(begin: -0.2),
                  const SizedBox(height: 20),
                  _buildInfoCard(
                    'Carrera',
                    'Ingeniería en Software',
                    Icons.school,
                    ref,
                  ).animate().fadeIn(delay: const Duration(milliseconds: 100)),
                  _buildInfoCard('NRC', '2553', Icons.numbers, ref)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 200)),
                  _buildInfoCard(
                    'Asignatura',
                    'Desarrollo de Aplicaciones Móviles',
                    Icons.mobile_friendly,
                    ref,
                  ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
                  _buildInfoCard(
                    'Profesor',
                    'ING. Doris Chicaiza',
                    Icons.person,
                    ref,
                  ).animate().fadeIn(delay: const Duration(milliseconds: 400)),
                  _buildInfoCard('Grupo', '7', Icons.group, ref)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 500)),
                  const SizedBox(height: 20),
                  Text(
                    'INTEGRANTES',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.white,
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 600)),
                  const SizedBox(height: 10),
                  _buildMemberCard('ALMEIDA MARLYN', ref)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 700)),
                  _buildMemberCard('PULLAGUARI AXEL', ref)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 800)),
                  _buildMemberCard('SANCHEZ PAUL', ref)
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 900)),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context, ref),
        child: const Icon(Icons.menu),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade900),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
        ),
        subtitle: Text(
          content,
          style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white70 : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildMemberCard(String name, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: isDarkMode ? Colors.white.withOpacity(0.9) : Colors.white.withOpacity(0.9),
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.blue),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.black : Colors.black),
        ),
      ),
    );
  }
}