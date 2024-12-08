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
    try {
      print("SignUp initiated");
      print(
          "Email: ${emailController.text}, Password: ${passwordController.text}");

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("User created: ${userCredential.user}");
      if (userCredential.user != null) {
        Get.off(() => HomeScreen());
      }
    } catch (e) {
      print("Error during sign up: $e");
      Get.snackbar(
        "Sign Up Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logIn() async {
    try {
      // Validasi input
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar(
          "Error",
          "Email and password cannot be empty",
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Logging untuk debugging
      print("Logging in with Email: ${emailController.text}");

      // Proses Log In menggunakan Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Validasi hasil Log In
      if (userCredential.user != null) {
        // Debugging: Log data user
        print("Login successful: User UID: ${userCredential.user!.uid}");
        print("User Email: ${userCredential.user!.email}");

        // Navigasi ke HomeScreen
        Get.off(() => HomeScreen());
      } else {
        throw Exception("Failed to retrieve user details after login.");
      }
    } catch (e) {
      // Logging error untuk debugging
      print("Login error: $e");

      // Tangani error dengan pesan yang lebih spesifik
      String errorMessage = "An unknown error occurred.";
      if (e is FirebaseAuthException) {
        print("test");
        switch (e.code) {
          case "user-not-found":
            errorMessage = "No user found for this email.";
            break;
          case "wrong-password":
            errorMessage = "Incorrect password provided.";
            break;
          case "invalid-email":
            errorMessage = "The email address is badly formatted.";
            break;
          default:
            errorMessage = e.message ?? errorMessage;
        }
      }

      Get.snackbar(
        "Login Failed",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
