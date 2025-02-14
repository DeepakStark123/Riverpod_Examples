// Define a FutureProvider
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';


// FutureProvider to fetch data from api
final jokeFutureProvider = FutureProvider<String>((ref) async {
  final response =
      await http.get(Uri.parse("https://api.chucknorris.io/jokes/random"));
  final data = jsonDecode(response.body);
  return data["value"]; // Extract joke text
});


