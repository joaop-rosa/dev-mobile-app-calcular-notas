import 'package:flutter/material.dart';
import 'package:flutter_application_1/notas_controller.dart';
import 'components/trabalho.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double notaProva = 0;

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
                  titleTextStyle:
                      const TextStyle(color: Colors.white, fontSize: 20)),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  child: ListView(children: [
                    ...NotasController.instance.tarefas.map(
                      (item) => Column(
                        children: [
                          const SizedBox(height: 20),
                          Trabalho(tarefa: item),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Column(children: [
                      const Text(
                          style: Trabalho.inputTextStyle, 'Nota da prova'),
                      const SizedBox(height: 5),
                      TextField(
                          decoration: Trabalho.inputStyle,
                          keyboardType: const TextInputType.numberWithOptions(),
                          onChanged: (value) {
                            setState(() {
                              if (value != '') {
                                notaProva = double.parse(value);
                              }
                            });
                          })
                    ]),
                    const SizedBox(height: 35),
                    ElevatedButton(
                        onPressed: () => NotasController.instance
                            .calcularNotaFinal(notaProva),
                        child: const Text('Calcular')),
                    const SizedBox(height: 35),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            'Nota final: '),
                        Text(
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            '${NotasController.instance.notaFinal?.toStringAsFixed(2) ?? '--'}')
                      ],
                    ))
                  ]),
                ),
              ),
            ),
          );
        });
  }
}
