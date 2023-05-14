import 'package:flutter/material.dart';
import 'package:gestion_tareas/models/task_model.dart';
import 'package:gestion_tareas/presentation/task/widgets/button_task.dart';
import 'package:gestion_tareas/presentation/task/widgets/button_task_update.dart';

import '../../helpers/constants.dart';
import '../../theme/app_theme.dart';
import '../shared/widgets/decoration_field.dart';
import '../shared/widgets/label_field.dart';

class TaskPage extends StatelessWidget {
  final String taskId;

  const TaskPage({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Task task = new Task();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tarea'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30.0),
                Padding(
                  padding: myPaddingForm,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const LabelField(label: 'Título'),
                        TextFormField(
                          initialValue: task.title,
                          enabled: task.isEditable,
                          decoration: textFieldDecoration(
                            hint: 'Escribe aquí el título de tu tarea',
                            enabled: task.isEditable,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return errorCampoObligatorio;

                            return null;
                          },
                          onSaved: (value) {
                            task.title = value ?? '';
                          },
                        ),
                        const LabelField(label: 'Descripción'),
                        TextFormField(
                          initialValue: task.description,
                          enabled: task.isEditable,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: textFieldDecoration(
                            hint: 'Describe cómo será tu tarea',
                            enabled: task.isEditable,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return errorCampoObligatorio;

                            return null;
                          },
                          onSaved: (value) {
                            task.description = value;
                          },
                        ),
                        const LabelField(label: 'Fecha'),
                        // _rowFecha(task, context),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox.shrink()),
                _getButtonActualizar(task, context, formKey),
                _getButtonPrincipal(task, context, formKey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getButtonActualizar(
    Task tarea,
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) {
    return (!tarea.isNew && tarea.isEditable)
        ? ButtonTaskUpdate(
            text: 'Actualizar',
            onPressed: () => _onCreateUpdate(tarea: tarea, formKey: formKey),
          )
        : const SizedBox.shrink();
  }

  Widget _getButtonPrincipal(
    Task tarea,
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) {
    return tarea.isNew
        ? ButtonTask(
            text: 'Crear',
            icon: Icons.check,
            onPressed: () => _onCreateUpdate(tarea: tarea, formKey: formKey),
          )
        : tarea.isEditable
            ? ButtonTask(
                text: 'Completar Tarea',
                icon: Icons.check,
                onPressed: () => _onCreateUpdate(
                  tarea: tarea,
                  formKey: formKey,
                  markCompleted: true,
                ),
              )
            : const SizedBox.shrink();
  }

  void _onCreateUpdate({
    required Task tarea,
    required GlobalKey<FormState> formKey,
    bool markCompleted = false,
  }) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    } else {
      // formKey.currentState?.save();
      // final context = formKey.currentContext!;
      //
      // // Crear tarea en la BD
      // tarea.fecha = DateTime(tarea.anio!, tarea.mes!, tarea.dia!);
      // if (tarea.isNew) {
      //   tarea.createdBy = int.tryParse(idUser);
      //   if ((await TaskDb.insert(tarea)) == 0) {
      //     if (context.mounted) {
      //       showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => const AlertDialogError(msg: 'Error creando tarea'));
      //     }
      //     return;
      //   }
      // } else {
      //   if (markCompleted) tarea.setCompleted();
      //
      //   if ((await TaskDb.update(tarea)) == 0) {
      //     if (context.mounted) {
      //       showDialog<String>(
      //           context: context,
      //           builder: (BuildContext context) => const AlertDialogError(msg: 'Error acrualizando tarea'));
      //     }
      //     return;
      //   }
      // }
      // // Emitir estado y Redireccionar a Home
      // if (context.mounted) {
      //   BlocProvider.of<HomeBloc>(context).add(SetHomeEvent(0));
      //   Navigator.pop(context);
      // }
    }
  }
}
