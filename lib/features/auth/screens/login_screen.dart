import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() =>
      _LoginScreenState();
}


class _LoginScreenState extends ConsumerState<LoginScreen> {

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();


  bool obscurePassword = true;

  bool isLoading = false;



  Future<void> login() async {

    setState(() {
      isLoading = true;
    });


    try {

      final result = await ref
          .read(authRepositoryProvider)
          .login(
            usernameController.text.trim(),
            passwordController.text.trim(),
          );


      if (!mounted) return;


      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            "Login successful 🎉 Token: ${result.token.substring(0,10)}",
          ),
        ),

      );


    } catch (e) {


      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),

      );


    } finally {

      setState(() {
        isLoading = false;
      });

    }

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(24),


          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,


            crossAxisAlignment:
                CrossAxisAlignment.start,


            children: [


              Center(

                child: Container(

                  height: 90,

                  width: 90,

                  decoration: BoxDecoration(

                    color: Theme.of(context)
                        .colorScheme
                        .primary,

                    shape: BoxShape.circle,

                  ),


                  child: const Icon(

                    Icons.shopping_bag,

                    color: Colors.white,

                    size: 50,

                  ),

                ),

              ),



              const SizedBox(height: 30),



              Text(

                "Welcome Back 👋",

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

                "Login to continue shopping with ZembilGo",

                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,

              ),



              const SizedBox(height: 35),



              TextField(

                controller: usernameController,

                decoration: InputDecoration(

                  labelText: "Username",

                  prefixIcon:
                      const Icon(Icons.person),

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(15),

                  ),

                ),

              ),



              const SizedBox(height: 20),



              TextField(

                controller: passwordController,

                obscureText: obscurePassword,


                decoration: InputDecoration(

                  labelText: "Password",

                  prefixIcon:
                      const Icon(Icons.lock),


                  suffixIcon: IconButton(

                    icon: Icon(

                      obscurePassword

                          ? Icons.visibility_off

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
                        BorderRadius.circular(15),

                  ),

                ),

              ),



              const SizedBox(height: 30),



              SizedBox(

                width: double.infinity,

                height: 55,


                child: ElevatedButton(

                  onPressed: isLoading
                      ? null
                      : login,


                  style:
                      ElevatedButton.styleFrom(

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(15),

                    ),

                  ),


                  child: isLoading

                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )

                      : const Text(

                          "LOGIN",

                          style: TextStyle(

                            fontSize: 16,

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),

                ),

              ),



              const SizedBox(height: 20),



              Center(

                child: TextButton(

                  onPressed: () {

                    // signup later

                  },

                  child: const Text(

                    "Don't have an account? Sign Up",

                  ),

                ),

              )

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

    super.dispose();

  }

}