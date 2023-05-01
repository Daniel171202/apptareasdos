import 'package:app_tareas/bloc/task_state.dart';
import 'package:app_tareas/services/tasks_services.dart';
import 'package:bloc/bloc.dart';

class TasksCubit extends Cubit<ListTaskState> {
  TasksCubit() : super(ListTaskState([]));
  //Obtener tareas
  Future<String> getTasks(String token) async {
    List<TaskState> tasks = await TasksServices.getAllTasks(token);
    if (tasks.isNotEmpty) {
      if (tasks[0].description == '500') return 'Error 500';
      emit(ListTaskState(tasks));
      return 'Ok';
    } else {
      emit(ListTaskState([]));
      return 'Lista vacía';
    }
  }

  //Actualizar tarea
  Future<String> updateTask(TaskState task, String token, int index) async {
    TaskState newTasks = await TasksServices.updateTask(task, token);
    if (newTasks.date == 'Error 404') return 'Error 500';
    //Emitir nueva lista de tareas
    List<TaskState> newList = state.tasks;
    newList[index] = task;
    emit(ListTaskState(newList));
    return 'Ok';
  }

  //Agregar tarea
  Future<String> addTask(TaskState task, String token) async {
    String response = await TasksServices.addTask(task, token);
    if (response == 'Task added') {
      List<TaskState> newList = state.tasks;
      newList.add(task);
      emit(ListTaskState(newList));
      return 'Ok';
    } else {
      return 'Error 500';
    }
  }
}
