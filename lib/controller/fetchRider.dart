import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zoomcampus/data/data.dart';
import 'dart:convert';


Future<List<dynamic>> fetchRiders() async {
  final response = await http.post(
    Uri.http("192.168.31.48:8000", "/availableRiders/"),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode({"mail":mail}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return [{"name":"kushal"}];
  }
}
