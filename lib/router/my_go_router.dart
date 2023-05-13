import 'package:go_router/go_router.dart';
import '../presentation/home/home_page.dart';

final myGoRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
  ],
);
