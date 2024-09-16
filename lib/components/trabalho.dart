import 'package:flutter/material.dart';
import 'package:flutter_application_1/notas_controller.dart';

class Trabalho extends StatelessWidget {
  final Tarefa tarefa;

  const Trabalho({super.key, required this.tarefa});

  static const TextStyle inputTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  static const InputDecoration inputStyle =
      InputDecoration(label: Text('Nota'), border: OutlineInputBorder());

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(style: inputTextStyle, tarefa.tituloResumido),
      Text(style: inputTextStyle, 'Peso: ${tarefa.peso}'),
      const SizedBox(height: 5),
      TextField(
        decoration: inputStyle,
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: (value) => {
          if (value != '') {tarefa.setNota(double.parse(value))}
        },
      )
    ]);
  }
}
