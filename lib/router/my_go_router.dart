import 'package:gestion_tareas/presentation/task/task_page.dart';
import 'package:go_router/go_router.dart';
import '../presentation/home/home_page.dart';

final myGoRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/task/:taskId',
      name: 'taskForm',
      builder: (context, state) => TaskPage(taskId: state.params['taskId'] ?? '0'),
    ),
  ],
);
