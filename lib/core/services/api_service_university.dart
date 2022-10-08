import 'dart:convert';
import 'dart:developer';

import 'package:flutter_tyba/feature/home/models/university_model.dart';
import 'package:http/http.dart' as http;


class ApiServiceUniversity {

  static Future<List<University>> fetchUniversity() async {
    final url = Uri.parse('https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json');

    try {
      final resp = await http.get(url);
      if(resp.statusCode == 200) {
        final body = json.decode(resp.body) as List;
        return body.map((data) {
          final map = data as Map<String, dynamic>;
          log('${map.length}');
          return University(
            alphaTwoCode: map['alpha_two_code'] as String,
            domains: map['domains'],
            country: map['country'] as String,
            stateProvince: map['state-province'] ?? 'None',
            webPages: map['web_pages'],
            name: map['name'] as String
          );
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('ERROR => $e');
      throw Exception('Error fetch posts');
    }
  }

}