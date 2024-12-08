import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/src/controller/signup_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  final RxBool isSignUpSelected = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              // Toggle Sign Up / Log In Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Sign Up Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSignUpSelected.value = true;
                        },
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: isSignUpSelected.value
                                  ? Colors.blue
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                              ),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: isSignUpSelected.value
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Log In Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isSignUpSelected.value = false;
                        },
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: !isSignUpSelected.value
                                  ? Colors.blue
                                  : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: !isSignUpSelected.value
                                      ? Colors.white
                                      : Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Text Header
              Obx(
                () => Text(
                  isSignUpSelected.value
                      ? "Let's get\nStarted!"
                      : "Welcome Back!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Email TextField
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Username TextField, hanya muncul di Sign Up
              Obx(
                () => isSignUpSelected.value
                    ? Column(
                        children: [
                          TextField(
                            controller: controller.usernameController,
                            decoration: const InputDecoration(
                              labelText: "Username",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : const SizedBox(),
              ),

              // Password TextField
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 30),

              // Create Account / Log In Button
              Obx(
                () => ElevatedButton(
                  onPressed: isSignUpSelected.value
                      ? controller.signUp
                      : controller.logIn, // Sign Up atau Log In sesuai pilihan
                  child: Text(
                    isSignUpSelected.value ? "Create an account" : "Log in",
                    style: const TextStyle(
                        color: Colors.white), // Warna teks diatur di sini
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Link to Log in / Sign up
              Obx(
                () => TextButton(
                  onPressed: () {
                    isSignUpSelected.value = !isSignUpSelected.value;
                  },
                  child: Text(
                    isSignUpSelected.value
                        ? "Already have an account? Log in"
                        : "Don't have an account? Sign up",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
