import 'package:flutter/material.dart';
import 'package:gestion_tareas/models/task_model.dart';
import 'package:gestion_tareas/presentation/shared/widgets/button_update.dart';
import 'package:gestion_tareas/presentation/task/widgets/button_task.dart';
import 'package:gestion_tareas/presentation/task/widgets/button_task_update.dart';
import 'package:gestion_tareas/providers/task_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:gestion_tareas/api/api_task.dart' as api;

import '../../helpers/constants.dart';
import '../../helpers/utils.dart';
import '../../theme/app_theme.dart';
import '../shared/widgets/alertdialog_error.dart';
import '../shared/widgets/decoration_field.dart';
import '../shared/widgets/label_field.dart';

class TaskPage extends StatelessWidget {
  final String taskId;

  const TaskPage({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Task task = new Task();
    TextEditingController tecFecha = TextEditingController();

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
                Padding(
                  padding: myPaddingForm,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const LabelField(label: 'Título*'),
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
                          onSaved: (value) {
                            task.description = value;
                          },
                        ),
                        const LabelField(label: 'Comentarios'),
                        TextFormField(
                          initialValue: task.comments,
                          enabled: task.isEditable,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: textFieldDecoration(
                            hint: 'Agrega algunos comentarios a tu tarea',
                            enabled: task.isEditable,
                          ),
                          onSaved: (value) {
                            task.comments = value;
                          },
                        ),
                        const LabelField(label: 'Tags'),
                        TextFormField(
                          initialValue: task.tags,
                          enabled: task.isEditable,
                          decoration: textFieldDecoration(
                            hint: 'Escribe algunos tags a tarea',
                            enabled: task.isEditable,
                          ),
                          onSaved: (value) {
                            task.tags = value ?? '';
                          },
                        ),
                        const LabelField(label: 'Fecha'),
                        GestureDetector(
                          onTap: () => {if (task.isEditable) _seleccionarFecha(context, tecFecha)},
                          child: TextFormField(
                            controller: tecFecha,
                            enabled: false,
                            decoration: textFieldDecoration(
                              hint: 'Puedes indicar una fecha límite',
                              enabled: false,
                            ),
                          ),
                        ),
                        _getButtonLimpiarFecha(task, context, formKey, tecFecha),
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

  void _seleccionarFecha(BuildContext context, TextEditingController tecFecha) async {
    final DateTime? selected = await showDatePicker(
      errorInvalidText: "ERROR",
      context: context,
      initialDate: context.read<TaskProvider>().selectedDate,
      firstDate: FECHA_INI_APP,
      lastDate: FECHA_FIN_APP,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: primary91,
          ),
        ),
        child: child!,
      ),
    );
    if (selected != null) {
      tecFecha.text = formatDate(selected);
      context.read<TaskProvider>().selectedDate = selected;
    }
  }

  Widget _getButtonLimpiarFecha(
    Task task,
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController tecFecha,
  ) {
    return (task.isEditable)
        ? ButtonSecondary(
            text: 'Limpiar fecha',
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              tecFecha.text = '';
              task.dueDate = null;
            },
          )
        : const SizedBox.shrink();
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
      formKey.currentState?.save();
      final context = formKey.currentContext!;

      // Crear tarea en la BD
      if (tarea.isNew) {
        // if ((await api.insert(tarea)) == 0) {
        //   if (context.mounted) {
        //     showDialog<String>(
        //         context: context,
        //         builder: (BuildContext context) => const AlertDialogError(msg: 'Error creando tarea'));
        //   }
        //   return;
        // }
      } else {
        if (markCompleted) tarea.setCompleted();

        // if ((await api.patch(tarea)) == 0) {
        //   if (context.mounted) {
        //     showDialog<String>(
        //         context: context,
        //         builder: (BuildContext context) => const AlertDialogError(msg: 'Error acrualizando tarea'));
        //   }
        //   return;
        // }
      }
      // Emitir estado y Redireccionar a Home
      context.pop();
    }
  }
}
