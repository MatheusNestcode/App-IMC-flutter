import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  String imcResult = '';

  void calcularIMC() {
    // Verificar se ambos os campos estão preenchidos
    if (pesoController.text.isNotEmpty && alturaController.text.isNotEmpty) {
      final double peso = double.parse(pesoController.text);
      final double altura =
          double.parse(alturaController.text) / 100; // converter cm para metros
      final double imc = peso / (altura * altura);

      String resultado;
      if (imc < 18.5) {
        resultado = 'Abaixo do peso';
      } else if (imc < 24.9) {
        resultado = 'Peso normal';
      } else if (imc < 29.9) {
        resultado = 'Sobrepeso';
      } else if (imc < 34.9) {
        resultado = 'Obesidade grau 1';
      } else if (imc < 39.9) {
        resultado = 'Obesidade grau 2';
      } else {
        resultado = 'Obesidade grau 3';
      }

      setState(() {
        imcResult = 'Seu IMC é ${imc.toStringAsFixed(3)}. $resultado';
      });
    } else {
      setState(() {
        imcResult = 'Por favor, preencha todos os campos.';
      });
    }
  }

  void limparCampos() {
    pesoController.clear();
    alturaController.clear();
    setState(() {
      imcResult = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: limparCampos,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.person_outline,
              size: 120,
              color: Colors.green,
            ),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Peso (Kg)',
                labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
            ),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Altura (cm)',
                labelStyle: TextStyle(color: Colors.green),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: calcularIMC,
                  child: const Text(
                    'Calcular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              imcResult,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
