import 'package:flutter/material.dart';

class Tarefa {
  final String tipo;
  final String titulo;
  final String tituloResumido;
  final int peso;
  final String periodo;
  double? nota; // Adiciona um campo para a nota (pode ser nulo inicialmente)

  Tarefa({
    required this.tipo,
    required this.titulo,
    required this.tituloResumido,
    required this.peso,
    required this.periodo,
    this.nota,
  });

  // Método para atribuir a nota
  void setNota(double novaNota) {
    nota = novaNota;
  }

  // Calcula o valor ponderado da nota
  double getNotaPonderada() {
    if (nota != null) {
      return nota! * peso;
    }
    return 0.0; // Se a nota for nula, retorna 0
  }

  // Método para converter de JSON
  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      tipo: json['tipo'] ??
          '', // Adicione um valor padrão para evitar erros de null
      titulo: json['titulo'] ?? '',
      tituloResumido: json['tituloResumido'] ?? json['titulo'],
      peso: json['peso'] ??
          0, // Adicione um valor padrão para evitar erros de null
      periodo: json['periodo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tipo': tipo,
      'titulo': titulo,
      'tituloResumido': tituloResumido,
      'peso': peso,
      'periodo': periodo,
    };
  }
}

class NotasController extends ChangeNotifier {
  static final NotasController instance = NotasController();

  static final List<Map<String, dynamic>> notas = [
    {
      "tipo": "Tarefas",
      "titulo": "Tarefa - Mapa Mental (Individual Peso 1)",
      "tituloResumido": "Mapa Mental",
      "peso": 1,
      "periodo": "G1"
    },
    {
      "tipo": "Tarefas",
      "titulo":
          "Tarefa - Atividade: Praticando Git e Resumo de Padrões de Projeto Mobile - Peso 2 - Individual",
      "tituloResumido": "Praticando Git",
      "peso": 2,
      "periodo": "G1"
    },
    {
      "tipo": "Tarefas",
      "titulo":
          "Tarefa: Desenvolvimento de Aplicativo Mobile para Cadastro de Potenciais Clientes - Grupo - Peso 3",
      "tituloResumido": "Cadastro de Potenciais Clientes",
      "peso": 3,
      "periodo": "G1"
    },
    {
      "tipo": "Tarefas",
      "titulo":
          "Tarefa - Aplicativo para calcular a nota dos trabalhos da disciplina - Individual/Duplas -Peso 4",
      "tituloResumido": "Aplicativo para calcular a nota",
      "peso": 4,
      "periodo": "G1"
    },
    {
      "tipo": "Trabalho Final",
      "titulo": "Sprint 4 - Review - Avaliação G1",
      "peso": 7,
      "periodo": "G1"
    }
  ];

  final List<Tarefa> tarefas =
      notas.map((json) => Tarefa.fromJson(json)).toList();

  dynamic notaFinal;

  double calcularMediaPonderadaConvertida() {
    double somaNotasPonderadas = 0.0;
    int somaPesos = 0;

    for (var tarefa in tarefas) {
      if (tarefa.nota != null) {
        somaNotasPonderadas += (tarefa.nota! / 10) * 3 * tarefa.peso;
        somaPesos += tarefa.peso;
      }
    }

    return somaPesos > 0 ? somaNotasPonderadas / somaPesos : 0.0;
  }

  void calcularNotaFinal(double notaProva) {
    double mediaPonderadaConvertida = calcularMediaPonderadaConvertida();
    double notaProvaConvertida = (notaProva / 10) * 7;

    notaFinal = mediaPonderadaConvertida + notaProvaConvertida;
    notifyListeners();
  }

  void atribuirNota(String titulo, double nota) {
    final tarefa = tarefas.firstWhere((tarefa) => tarefa.titulo == titulo,
        orElse: () => throw Exception('Tarefa não encontrada'));
    tarefa.setNota(nota);
    notifyListeners(); // Notifica ouvintes sobre mudanças
  }
}
