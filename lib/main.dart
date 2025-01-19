import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_web/config/router/app_router.dart';
import 'package:my_web/config/theme/app_theme.dart';
import 'package:my_web/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme themeNotify = ref.watch(themeNotifyProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Manu Dev',
      theme: themeNotify.getColor()
    );
  }
}

