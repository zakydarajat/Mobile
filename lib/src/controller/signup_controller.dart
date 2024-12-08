import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/src/view/screen/home_screen.dart';

class SignUpController extends GetxController {
  // TextEditingController untuk form input
  final emailController = TextEditingController();
  final usernameController =
      TextEditingController(); // Bisa diabaikan jika tidak digunakan
  final passwordController = TextEditingController();

  // FirebaseAuth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    print("Debug: SignUp process started.");

    // Debug: Menampilkan input pengguna
    print("Debug: Email input: ${emailController.text}");
    print("Debug: Password input: ${passwordController.text}");

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      print("Debug: Email or password is empty.");
      Get.snackbar(
        "Error",
        "Email and password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      print("Debug: Attempting to create user...");
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("Debug: User created successfully.");
      print("Debug: User UID: ${userCredential.user?.uid}");
      print("Debug: User Email: ${userCredential.user?.email}");

      if (userCredential.user != null) {
        print("Debug: Navigating to HomeScreen...");
        Get.off(() => HomeScreen());
      } else {
        print("Debug: UserCredential.user is null after creation.");
      }
    } catch (e) {
      print("Error during sign up: $e");

      // Debug: Menampilkan error spesifik jika FirebaseAuthException
      if (e is FirebaseAuthException) {
        print("Debug: FirebaseAuthException occurred with code: ${e.code}");
      }

      Get.snackbar(
        "Sign Up Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    print("Debug: SignUp process ended.");
  }

  Future<void> logIn() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (userCredential.user != null) {
      print("Debug: Login successful.");
      print("Debug: User UID: ${userCredential.user?.uid}");
      print("Debug: User Email: ${userCredential.user?.email}");
      Get.off(() => HomeScreen());
    } else {
      throw Exception("Login failed: UserCredential.user is null.");
    }
  } catch (e) {
    print("Error during log in: $e");
    Get.snackbar(
      "Login Failed",
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

}
