import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'core/widgets/primary_button.dart';

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
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ZembilGo',

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: themeMode,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('ZembilGo'),
        ),

        body: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 40),

              Text(
                'Welcome to ZembilGo 🛒',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),

              Text(
                'Your smart shopping companion.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
              ),

              const SizedBox(height: 30),

              PrimaryButton(
                text: 'Start Shopping',
                icon: Icons.shopping_bag_outlined,
                onPressed: () {
                  // We will navigate to the home screen later.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}