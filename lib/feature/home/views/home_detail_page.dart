import 'package:flutter/material.dart';
import 'package:flutter_tyba/feature/home/models/models.dart';

import 'add_data_form.dart';

class HomeDetailPage extends StatelessWidget {

  final University university;

  // ignore: use_key_in_widget_constructors
  const HomeDetailPage({required this.university});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la universidad'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('name: ${university.name}',),
            Text('alphaTwoCode: ${university.alphaTwoCode}'),
            Text('country: ${university.country}'),
            Text('stateProvince: ${university.stateProvince}'),
            Text('domains: ${university.domains}'),
            Text('webPages: ${university.webPages}'),
            const AddDataForm()
          ],
        ),
      ),
    );
  }
}