import 'dart:convert';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'package:app_tareas/bloc/task_state.dart';

class TasksServices {
  //Obtiene todas las tareas
  static Future<List<TaskState>> getAllTasks(String token) async {
    var url = Uri.parse(baseUrl + '/task');
    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] == '0000') {
        List<TaskState> tasks = [];
        for (var taskMap in responseMap['response']) {
          TaskState task = TaskState.fromMap(taskMap);
          tasks.add(task);
        }
        return tasks;
      } else {
        return [
          TaskState(
              taskId: -1,
              description: 'Error 404',
              date: 'Error 404',
              labelName: "Error 404",
              finish: false)
        ];
      }
    } else {
      print('Error: ${response.statusCode}');
      return [
        TaskState(
            taskId: -1,
            description: '${response.statusCode}',
            date: 'Error 500',
            labelName: "Error 500",
            finish: false)
      ];
    }
  }

  //Actualiza una tarea
  static Future<TaskState> updateTask(TaskState task, String token) async {
    Map data = {
      'taskId': task.taskId,
      'description': task.description,
      'date': task.date,
      'label': task.labelName,
      'done': task.finish,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/task/${task.taskId}');
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: body,
    );
    if (response.statusCode == 200) {
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] != "0000") {
        return const TaskState(
            taskId: -1,
            description: 'Task not found',
            date: 'Error 404',
            labelName: "Error 404",
            finish: false);
      }
      TaskState taskData = TaskState.fromMap(responseMap['response']);
      return taskData;
    } else {
      return TaskState(
          taskId: -1,
          description: '${response.statusCode}',
          date: 'Error 404',
          labelName: "Error 404",
          finish: false);
    }
  }

  //Agrega una tarea
  static Future<String> addTask(TaskState task, String token) async {
    Map data = {
      'taskId': task.taskId,
      'description': task.description,
      'date': task.date.toString(),
      'label': task.labelName,
      'finish': task.finish,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/task');
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] == "0000") {
        return 'Task added';
      } else {
        return 'Error 404';
      }
    } else {
      return 'Error 404';
    }
  }
}
