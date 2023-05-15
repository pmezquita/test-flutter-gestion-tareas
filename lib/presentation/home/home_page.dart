import 'package:flutter/material.dart';
import 'package:gestion_tareas/api/api_task.dart' as api;
import 'package:gestion_tareas/presentation/home/widgets/card_task.dart';
import 'package:gestion_tareas/presentation/home/widgets/fab.dart';
import 'package:gestion_tareas/providers/home_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Fab(onPressed: () => context.pushNamed('taskForm', params: {'taskId': '0'})),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<HomeProvider>().selectedIndex,
        onTap: (index) => context.read<HomeProvider>().selectedIndex = index,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.text_snippet_outlined, size: sizeIconBottomNavBar),
            activeIcon: Icon(Icons.text_snippet, size: sizeIconBottomNavBarSelected),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.check, size: sizeIconBottomNavBar),
            activeIcon: Icon(Icons.check_circle, size: sizeIconBottomNavBarSelected),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _sliverTaskList(context, context.watch<HomeProvider>().selectedIndex),
        ],
      ),
    );
  }

  Widget _sliverTaskList(BuildContext context, int selectedIndex) {
    final isCompleted = selectedIndex == 0 ? 0 : 1;

    return FutureBuilder<List<Task>?>(
        future: api.getTasksType(isCompleted),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final tasks = snapshot.data as List<Task>;

            return (tasks.length == 0)
                ? SliverToBoxAdapter(
                    child: Center(
                    child: Text(
                      'Sin resultados',
                      style: TextStyle(color: secondary),
                    ),
                  ))
                : SliverList(delegate: SliverChildListDelegate(tasks.map((task) => CardTask(task: task)).toList()));
          } else {
            return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
