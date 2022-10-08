import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tyba/feature/feature.dart';
import 'package:flutter_tyba/feature/home/bloc/list_university_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de universidades'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ListUniversityBloc()..add(UniversityFetch()),
        child: const UniversityList(),
      ),
    );
  }
}