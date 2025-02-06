import 'package:go_router/go_router.dart';
import 'package:realtime_innovations_task/src/features/home/presentation/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
  ],
);
