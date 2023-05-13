import 'dart:async';
import 'dart:io';

import 'package:gestion_tareas/models/task_model.dart';
import 'package:http/http.dart' as http;

const String _apiScheme = "https";
const String _apiHost = "ecsdevapi.nextline.mx";
const String _prefix = "/vdev/tasks-challenge/tasks";
const String _auth =
    'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';
const String token = 'prueba1'; // TODO: cambiar
// const String token = '3kr-0Vi1*Vlx';

const _headers = {'Authorization': _auth};

Uri _uri(String endpoint, {Map<String, dynamic>? queryParameters}) =>
    Uri(scheme: _apiScheme, host: _apiHost, path: "$_prefix$endpoint", queryParameters: queryParameters);

Future<List<Task>?> getAllTasks() async {
  Uri url = _uri("", queryParameters: {
    'token': token,
  });
  try {
    final http.Response resp = await http.get(url, headers: _headers);
    if (resp.statusCode != HttpStatus.ok) return null;

    return TaskListFromJson(resp.body);
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<List<Task>> getTasksType(int isCompleted) async {
  final tasks = await getAllTasks();

  if (tasks == null) return [];

  return tasks.where((element) => element.isCompleted == isCompleted).toList();
}
