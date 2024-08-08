import 'package:flutter/material.dart';
import 'package:intro/models/person.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final person1 = Person(id: 1, name: 'bora', email: 'bora@gmail.com');
    print(person1);

    return Scaffold(
      appBar: AppBar(title: const Text('Person')),
    );
  }
}
