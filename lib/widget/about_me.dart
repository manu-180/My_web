import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        'Soy Manuel Navarro, desarrollador especializado en Flutter, Dart y Supabase. '
        'Me dedico a crear aplicaciones eficientes y escalables, cuidando la calidad '
        'del código y la experiencia de usuario.',
        textAlign: TextAlign.start,
        style: textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold
          
        ),
      ),
    );
  }
}
