import 'package:flutter/material.dart';
import 'package:flutter_tyba/feature/home/models/models.dart';
import 'package:flutter_tyba/feature/home/views/home_detail_page.dart';

class ListUniversityItem extends StatelessWidget {
  final University university;
  final int index;
  // ignore: use_key_in_widget_constructors
  const ListUniversityItem({required this.university, required this.index});


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomeDetailPage(university: university)));
        },
        child: ListTile(
          leading: Text('${index + 1}', style: textTheme.caption),
          title: Text(university.name, style: textTheme.caption),
          isThreeLine: true,
          subtitle: Column(
            children: [
              Text(university.stateProvince),
              Text(university.country),
            ],
          ),
        ),
      ),
    );
  }
}