import 'package:flutter/material.dart';
import 'package:flutter_application_1/notas_controller.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: NotasController.instance,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(brightness: Brightness.dark),
            home: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.black,
                  title: const Text('Calculador de notas'),
                  titleTextStyle: const TextStyle(color: Colors.white)),
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: NotasController.instance.tarefas
                        .map((item) => ListTile(title: Text(item.titulo)))
                        .toList()),
              ),
            ),
          );
        });
  }
}
