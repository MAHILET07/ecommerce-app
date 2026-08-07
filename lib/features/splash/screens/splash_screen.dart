import 'package:flutter/material.dart';

import '../../auth/screens/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {


  late AnimationController _controller;

  late Animation<double> _scaleAnimation;

  late Animation<double> _fadeAnimation;



  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );


    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );


    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );


    _controller.forward();


    Future.delayed(
      const Duration(seconds: 3),
      () {

        if (!mounted) return;


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );

      },
    );
  }



  @override
  void dispose() {

    _controller.dispose();

    super.dispose();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: FadeTransition(

          opacity: _fadeAnimation,

          child: ScaleTransition(

            scale: _scaleAnimation,

            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [


                Container(

                  height: 100,

                  width: 100,

                  decoration: BoxDecoration(

                    color: Theme.of(context)
                        .colorScheme
                        .primary,

                    shape: BoxShape.circle,

                  ),

                  child: const Icon(

                    Icons.shopping_bag,

                    size: 55,

                    color: Colors.white,

                  ),

                ),


                const SizedBox(height: 25),


                Text(

                  'ZembilGo',

                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),

                ),


                const SizedBox(height: 10),


                const Text(

                  'Your smart shopping companion',

                ),


                const SizedBox(height: 40),


                const CircularProgressIndicator(),

              ],

            ),

          ),

        ),

      ),

    );

  }

}