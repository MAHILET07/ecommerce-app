import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/storage_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends ConsumerState<SignupScreen> {
  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  Future<void> signup() async {
    final username =
        usernameController.text.trim();

    final password =
        passwordController.text;

    final confirmPassword =
        confirmPasswordController.text;

    // =========================
    // Validation
    // =========================

    if (username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all fields.',
          ),
        ),
      );

      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Passwords do not match.',
          ),
        ),
      );

      return;
    }

    if (password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password must be at least 4 characters.',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final storage =
          ref.read(storageProvider);

      // Check whether an account already exists.
      final existingUsername =
          await storage.getUsername();

      if (existingUsername != null &&
          existingUsername == username) {
        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Username already exists. Please choose another.',
            ),
          ),
        );

        return;
      }

      // =========================
      // Save new account
      // =========================

      await storage.saveUser(
        username,
        password,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Account created successfully! 🎉',
          ),
        ),
      );

      // Return to Login screen.
      Navigator.pop(context);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 20),

              // =========================
              // Icon
              // =========================

              Center(
                child: Container(
                  height: 90,
                  width: 90,

                  decoration:
                      BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary,

                    shape:
                        BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.person_add,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // Title
              // =========================

              Text(
                'Create your account',

                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                      fontWeight:
                          FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 8),

              Text(
                'Join ZembilGo and start shopping.',

                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
              ),

              const SizedBox(height: 30),

              // =========================
              // Username
              // =========================

              TextField(
                controller:
                    usernameController,

                decoration:
                    InputDecoration(
                  labelText: 'Username',

                  prefixIcon:
                      const Icon(
                    Icons.person_outline,
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // Password
              // =========================

              TextField(
                controller:
                    passwordController,

                obscureText:
                    obscurePassword,

                decoration:
                    InputDecoration(
                  labelText: 'Password',

                  prefixIcon:
                      const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon:
                      IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons
                              .visibility_off
                          : Icons.visibility,
                    ),

                    onPressed: () {
                      setState(() {
                        obscurePassword =
                            !obscurePassword;
                      });
                    },
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // Confirm Password
              // =========================

              TextField(
                controller:
                    confirmPasswordController,

                obscureText:
                    obscureConfirmPassword,

                decoration:
                    InputDecoration(
                  labelText:
                      'Confirm Password',

                  prefixIcon:
                      const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon:
                      IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons
                              .visibility_off
                          : Icons.visibility,
                    ),

                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword =
                            !obscureConfirmPassword;
                      });
                    },
                  ),

                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =========================
              // Create Account
              // =========================

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : signup,

                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,

                          child:
                              CircularProgressIndicator(
                            color:
                                Colors.white,
                          ),
                        )
                      : const Text(
                          'CREATE ACCOUNT',

                          style:
                              TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // Login
              // =========================

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: const Text(
                    'Already have an account? Login',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}