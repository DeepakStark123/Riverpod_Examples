import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/model/Joke_model.dart';
import 'package:riverpod_tutorial/services/joke_service.dart';

final jokeServiceProvider = Provider<JokeService>((ref){
 return JokeService();
});

final jokeProvider = FutureProvider<JokeModel?>((ref) async {
    final service = ref.read(jokeServiceProvider);
  return service.fetchJoke();
});