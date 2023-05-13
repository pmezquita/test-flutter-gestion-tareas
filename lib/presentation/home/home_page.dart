import 'package:flutter/material.dart';
import 'package:gestion_tareas/presentation/home/widgets/fab.dart';
import 'package:gestion_tareas/providers/home_provider.dart';
import 'package:provider/provider.dart';


import '../../theme/app_theme.dart';

class HomePage extends StatelessWidget {
  final String idUser;

  const HomePage({Key? key, this.idUser = '0'})
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
      floatingActionButton:
          Fab(onPressed: () => {}),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<Home>().selectedIndex,
        onTap: (index) => context.read<Home>().selectedIndex = index,
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
          _sliverTaskList(context, context.watch<Home>().selectedIndex),
        ],
      ),
    );
  }

  Widget _sliverTaskList(BuildContext context, int selectedIndex) {
    return SliverToBoxAdapter(
        child: Center(
          child: Text(
            'Sin resultados',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ));

    // final type = selectedIndex == 0 ? 0 : 1;
    // return FutureBuilder<List<Task>?>(
    //     future: TaskDb.getTaskType(type, int.tryParse(idUser)),
    //     initialData: const [],
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasData) {
    //         if (snapshot.data is List<Task>?) {
    //           final tareas = snapshot.data as List<Task>;
    //           return SliverList(delegate: SliverChildListDelegate(tareas.map((e) => CardTask(tarea: e)).toList()));
    //         }
    //         return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
    //       } else {
    //         return SliverToBoxAdapter(
    //             child: Center(
    //           child: Text(
    //             'Sin resultados',
    //             style: Theme.of(context).textTheme.displaySmall,
    //           ),
    //         ));
    //       }
    //     });
  }
}
