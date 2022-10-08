// To parse this JSON data, do
//
//     final university = universityFromMap(jsonString);

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class University extends Equatable {
  University({
    required this.alphaTwoCode,
    required this.domains,
    required this.country,
    required this.stateProvince,
    required this.webPages,
    required this.name,
    this.image,
    this.numberOfStudents
  });

  final String alphaTwoCode;
  final List<dynamic> domains;
  final String country;
  final String stateProvince;
  final List<dynamic> webPages;
  final String name;
  final String? image;
  final int? numberOfStudents;

  @override
  List<Object?> get props => [
    alphaTwoCode,
    domains,
    country,
    stateProvince,
    webPages,
    name,
  ];

}
