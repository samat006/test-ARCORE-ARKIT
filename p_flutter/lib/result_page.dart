import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nom = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Résultat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bonjour $nom', style: const TextStyle(fontSize: 25)),
            
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 201, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 67, 107, 53),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Bonjour',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
                Expanded(
          child:   ListView(
  children: [
    const Text('Alice'),
    const Text('Karim'),
    const Text('Sophie'),
    const Text('Thomas'),
  ],
),),
          ],
        ),
      ),
    );
  }
}
