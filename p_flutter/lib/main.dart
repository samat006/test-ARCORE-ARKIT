import 'package:flutter/material.dart';
import 'form_page.dart';
import 'result_page.dart';
import 'map_page.dart';
import 'ar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  home: const HomePage(),

  routes: {
    '/form': (context) => const FormPage(),
   '/result': (context) => const ResultPage(),
     '/map': (context) => const MapPage(),
     '/ar': (context) => const ArPage(),
  },
);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nomController = TextEditingController();
  String nom = '';
  String message = '';
  @override
  void dispose() {
    nomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon application')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // Bienvenue + photo
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'Bienvenue',
                    style: TextStyle(fontSize: 28),
                  ),
                ),

                const Spacer(),

                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://picsum.photos/200'),
                ),
              ],
            ),

            const SizedBox(height: 20),

       /*     // Navigation
           "" Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [Text('Accueil'), Text('Carte'), Text('Profil')],
            ),

            const SizedBox(height: 20),

            // Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Row(
                  children: [
                    const Icon(Icons.person, size: 40),

                    const SizedBox(width: 15),

                    const Text('Bonjour', style: TextStyle(fontSize: 20)),

                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                       Navigator.pushNamed(context, '/form');
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Formulaire
            const Text('Créer un compte', style: TextStyle(fontSize: 22)),

            const SizedBox(height: 20),

            TextField(
              controller: nomController,
              decoration: const InputDecoration(hintText: 'Votre nom'),
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(hintText: 'Votre email'),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (nomController.text.isEmpty) {
                  print('Veuillez entrer votre nom');
                  setState(() {
                    Message = 'Veuillez entrer votre nom';
                  });
                  return;
                }

                setState(() {
                  nom = nomController.text;
                  Message = '';
                });
              },
              child: const Text('Valider'),
            ),
            if (Message.isEmpty)
              Text(nom, style: const TextStyle(fontSize: 22))
            else
              Text(Message, style: const TextStyle(fontSize: 22)),
            ElevatedButton(
              onPressed: () async {
                final resultat = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormPage()),
                );

                if (resultat != null) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(resultat)));
                }
              },
              child: const Text('Créer un compte'),
            ),*/
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
              child: const Text('Voir la carte'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ar');
              },
              child: const Text('Voir en AR'),
            ),
          ],
        ),
      ),
    );
  }
}
