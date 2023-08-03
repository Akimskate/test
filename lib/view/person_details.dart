import 'package:flutter/material.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Person Details'),
      ),
    );
  }
}
