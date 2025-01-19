import 'package:go_router/go_router.dart';
import 'package:my_web/screens/my_home_page.dart';
import 'package:my_web/screens/cv_page.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const MyHomePage(),
    ),
    GoRoute(
      path: "/cv",
      builder: (context, state) => const CVPage(),
    ),
    
  ]
);
