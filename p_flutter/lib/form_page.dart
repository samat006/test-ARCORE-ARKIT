
import 'package:flutter/material.dart';
import 'result_page.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
  context,
  '/result',
  arguments: _nomController.text,
);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: _nomController,

                decoration: const InputDecoration(
                  labelText: 'Nom',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre nom';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,

                decoration: const InputDecoration(
                  labelText: 'Email',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }

                  return null;
                },
              ),
TextFormField(
  controller: _passwordController,
  obscureText: true,
  decoration: const InputDecoration(
    labelText: 'Mot de passe',
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }

    if (value.length < 2) {
      return 'Minimum 6 caractères';
    }

    return null;
  },
),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Valider'),
              ),
  ElevatedButton(
  onPressed: () {
    Navigator.pop(
      context,
      'Compte créé avec succès !',
    );
  },
  child: const Text('Terminer'),
),
            ],
          ),
        ),
      ),
    );
  }
}
