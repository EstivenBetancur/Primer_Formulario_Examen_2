import 'package:flutter/material.dart';

class ImcView extends StatefulWidget {
  const ImcView({super.key});

  @override
  State<ImcView> createState() => _ImcViewState();
}

class _ImcViewState extends State<ImcView> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  String resultado = '';
  String categoria = '';

  void calcularIMC() {
    String pesoTexto = pesoController.text.trim();
    String alturaTexto = alturaController.text.trim();

    // Validar campos vacíos
    if (pesoTexto.isEmpty || alturaTexto.isEmpty) {
      setState(() {
        resultado = 'Error: Complete todos los campos';
        categoria = '';
      });
      return;
    }

    // Validar números válidos
    double? peso = double.tryParse(pesoTexto);
    double? altura = double.tryParse(alturaTexto);

    if (peso == null || altura == null) {
      setState(() {
        resultado = 'Error: Ingrese números válidos';
        categoria = '';
      });
      return;
    }

    // Validar valores positivos
    if (peso <= 0 || altura <= 0) {
      setState(() {
        resultado = 'Error: Los valores deben ser positivos';
        categoria = '';
      });
      return;
    }

    // Calcular IMC
    double imc = peso / (altura * altura);

    String clasificacion;

    if (imc < 18.5) {
      clasificacion = 'Bajo peso';
    } else if (imc < 25) {
      clasificacion = 'Peso normal';
    } else if (imc < 30) {
      clasificacion = 'Sobrepeso';
    } else {
      clasificacion = 'Obesidad';
    }

    setState(() {
      resultado = 'Tu IMC es: ${imc.toStringAsFixed(2)}';
      categoria = 'Categoría: $clasificacion';
    });
  }

  @override
  void dispose() {
    pesoController.dispose();
    alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: pesoController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.monitor_weight),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: alturaController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.height),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: calcularIMC,
              child: const Text('Calcular IMC'),
            ),

            const SizedBox(height: 30),

            Text(
              resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              categoria,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}