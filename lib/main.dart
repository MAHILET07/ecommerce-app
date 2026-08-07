import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';


void main() {

  runApp(

    const ProviderScope(

      child: ZembilGoApp(),

    ),

  );

}



class ZembilGoApp extends ConsumerWidget {


  const ZembilGoApp({super.key});



  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
  ) {


    final themeMode =
        ref.watch(themeProvider);



    return MaterialApp(

      debugShowCheckedModeBanner: false,


      title: "ZembilGo",


      theme: AppTheme.lightTheme,


      darkTheme: AppTheme.darkTheme,


      themeMode: themeMode,



      home: const Scaffold(

        body: Center(

          child: Text(

            "Welcome to ZembilGo 🛒",

          ),

        ),

      ),

    );

  }

}