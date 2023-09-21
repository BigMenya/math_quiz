import 'package:flutter/material.dart';

class QuizScreenWidget extends StatefulWidget {
  const QuizScreenWidget({super.key});

  @override
  State<QuizScreenWidget> createState() => _QuizScreenWidgetState();
}

class _QuizScreenWidgetState extends State<QuizScreenWidget> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter you name and press "Start quiz"',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Start quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
