import 'package:app_tareas/bloc/label_aux_cubit.dart';
import 'package:app_tareas/bloc/label_cubit.dart';
import 'package:app_tareas/bloc/label_state.dart';
import 'package:app_tareas/bloc/task_cubit.dart';
import 'package:app_tareas/bloc/task_state.dart';
import 'package:app_tareas/bloc/token_cubit.dart';
import 'package:app_tareas/bloc/token_state.dart';
import 'package:app_tareas/ui/task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenCubit, TokenState>(
      builder: (context, tokenState) {
        return BlocBuilder<LabelsCubit, ListLabelState>(
          builder: (context, labelState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("TODO APP"),
                centerTitle: true,
              ),
              body: BlocBuilder<TasksCubit, ListTaskState>(
                builder: (context, taskState) {
                  final items = taskState.tasks;
                  return items.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                              Center(child: Text('No hay tareas registradas')),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 400,
                                width: 300,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return _itemTask(context, items[index],
                                          index, tokenState.authToken);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  //Obtener los labels para mostrarlos en el dropdown
                  BlocProvider.of<LabelsCubit>(context)
                      .getLabels(tokenState.authToken);
                  //Ir a la página de creación de tareas
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TaskPage(),
                  ));
                },
              ),
            );
          },
        );
      },
    );
  }
}

Widget _itemTask(
    BuildContext context, TaskState task, int index, String token) {
  return Card(
    child: ListTile(
      title: Row(
        children: [
          SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.description),
                Text(task.date),
                Text(task.labelName.toString()),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                task.finish
                    ? _complete(context, task, token, index)
                    : _pending(context, task, token, index)
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _complete(
    BuildContext context, TaskState task, String token, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Completado'),
      TextButton(
          onPressed: () async {
            TaskState newTask = TaskState(
              taskId: task.taskId,
              description: task.description,
              date: task.date,
              finish: false,
              labelName: task.labelName,
            );
            String msg = await BlocProvider.of<TasksCubit>(context)
                .updateTask(newTask, token, index);
            if (msg == 'Ok') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tarea marcada como pendiente'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Error al marcar como pendiente'),
                ),
              );
            }
          },
          child: const Text('MARCAR COMO PENDIENTE'))
    ],
  );
}

Widget _pending(BuildContext context, TaskState task, String token, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Pendiente'),
      TextButton(
        onPressed: () async {
          TaskState newTask = TaskState(
            taskId: task.taskId,
            description: task.description,
            date: task.date,
            finish: true,
            labelName: task.labelName,
          );
          String msg = await BlocProvider.of<TasksCubit>(context)
              .updateTask(newTask, token, index);
          if (msg == 'Ok') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tarea marcada como completada'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error al marcar como completada'),
              ),
            );
          }
        },
        child: const Text('COMPLETAR'),
      )
    ],
  );
}
