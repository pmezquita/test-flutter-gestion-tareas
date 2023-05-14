import 'package:flutter/material.dart';
import 'package:gestion_tareas/providers/home_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/task_model.dart';
import '../../../theme/app_theme.dart';
import '../../shared/widgets/alertdialog_2_option.dart';

class CardTask extends StatelessWidget {
  final Task task;

  const CardTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;
    return Padding(
      padding: myPaddingCard,
      child: GestureDetector(
        child: Card(
          child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(task.title, style: tema.labelLarge),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Text(
                        task.completada ? 'Terminado' : 'Pendiente',
                        style: task.completada ? tema.labelSmall?.copyWith(color: primary60) : tema.labelSmall,
                        textAlign: TextAlign.start,
                      )),
                      Expanded(
                          child: Text(
                        task.formatDate,
                        style: tema.labelSmall,
                        textAlign: TextAlign.end,
                      )),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
              onTap: () => context.pushNamed('taskForm', params: {'taskId': '${task.id}'})),
        ),
        onLongPress: () => _onDelete(context),
      ),
    );
  }

  void _onDelete(BuildContext context) => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog2Opt(
            title: '¿Seguro que quieres eliminar ésta tarea?',
            content: 'No podrás recuperar las tareas eliminadas',
            onPressed1Opt: () => Navigator.pop(context),
            onPressed2Opt: () async {
              // Eliminar task de DB
              // await TaskDb.delete(task.id!);

              if (context.mounted) {
                // Emitir estado
                context.read<Home>().selectedIndex = task.isCompleted;
                // cerrar alert
                Navigator.pop(context);
              }
            },
          ));
}
