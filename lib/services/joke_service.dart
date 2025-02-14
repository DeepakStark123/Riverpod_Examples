import 'package:flutter/material.dart';
import 'package:riverpod_tutorial/core/api_url.dart';
import 'package:riverpod_tutorial/model/Joke_model.dart';
import 'package:http/http.dart' as http;

class JokeService {
  Future<JokeModel> fetchJoke() async {
    try {
      final response = await http.get(Uri.parse(ApiUrl.jokeApi));
      if (response.statusCode == 200) {
        final jokeModel = jokeModelFromJson(response.body);
        return jokeModel;
      } else {
        throw Exception("Failed to load joke");
      }
    } catch (e, stack) {
      debugPrint("Exception: $e, Stacktrace: $stack");
      throw Exception("Failed to load joke");
    }
  }
}
