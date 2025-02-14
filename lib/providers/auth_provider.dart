import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_tutorial/services/auth_service.dart';

// Auth state model
class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? errorMessage;

  AuthState({required this.isLoggedIn, this.isLoading = false, this.errorMessage});

  AuthState copyWith({bool? isLoggedIn, bool? isLoading, String? errorMessage}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

// Riverpod provider for auth state
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref)..checkLoginStatus();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;

  AuthNotifier(this.ref) : super(AuthState(isLoggedIn: false));

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }

  Future<void> loginUser(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authService = ref.read(authServiceProvider);
      await authService.loginUser(username, password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      state = state.copyWith(isLoggedIn: true, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: "Invalid email or password");
    }
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = state.copyWith(isLoggedIn: false);
  }
}
