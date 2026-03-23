import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class DetailsFormScreen extends StatelessWidget {
  const DetailsFormScreen({super.key});

  @override  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue, // Sets the circle color
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: 'Full Name')),
            const TextField(decoration: InputDecoration(labelText: 'Bio')),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthProvider>().login();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Complete Setup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}