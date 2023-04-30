import 'package:app_tareas/bloc/task_state.dart';
import 'package:app_tareas/services/tasks_services.dart';
import 'package:bloc/bloc.dart';

class TasksCubit extends Cubit<ListTaskState> {
  TasksCubit() : super(ListTaskState([]));
  //Obtener tareas
  Future<void> getTasks(String token) async {
    List<TaskState> tasks = await TasksServices.getAllTasks(token);
    emit(ListTaskState(tasks));
  }

  //Obtener tarea por id
  Future<void> getTaskById(int id, String token) async {
    try {
      TaskState task = await TasksServices.getTaskById(id, token);
      emit(ListTaskState([task]));
    } catch (e) {
      print(e);
    }
  }

  //Actualizar tarea
  Future<void> updateTask(TaskState task, String token) async {
    await TasksServices.updateTask(task, token);
  }

  //Agregar tarea
  Future<void> addTask(TaskState task, String token) async {
    await TasksServices.addTask(task, token);
  }
}
