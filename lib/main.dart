import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tyba/app.dart';
import 'package:flutter_tyba/simple_bloc_obverser.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}