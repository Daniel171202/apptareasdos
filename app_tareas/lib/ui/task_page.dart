import 'package:app_tareas/bloc/label_aux_cubit.dart';
import 'package:app_tareas/bloc/label_cubit.dart';
import 'package:app_tareas/bloc/label_select_cubit.dart';
import 'package:app_tareas/bloc/label_state.dart';
import 'package:app_tareas/bloc/task_cubit.dart';
import 'package:app_tareas/bloc/task_state.dart';
import 'package:app_tareas/bloc/token_cubit.dart';
import 'package:app_tareas/bloc/token_state.dart';
import 'package:app_tareas/ui/label_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);
  static String? select;
  static int? idLabel;
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController dateController = TextEditingController();

    return BlocBuilder<TokenCubit, TokenState>(
      builder: (context, tokenState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("REGISTRAR NUEVA TAREA"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nombre de la Tarea'),
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Fecha de cumplimento'),
                        TextField(
                          readOnly: true,
                          controller: dateController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          onTap: () async =>
                              await _selectionDate(dateController, context),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Etiqueta'),
                        BlocBuilder<LabelsCubit, ListLabelState>(
                            builder: (context, state) {
                          final items = state.labels;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BlocBuilder<LabelSelectCubit, LabelState>(
                                builder: (context, selectState) {
                                  return DropdownButton<String>(
                                    value: select,
                                    onChanged: (String? newValue) {
                                      select = newValue;
                                      //Buscar el objeto LabelState que coincida con el nombre de la etiqueta seleccionada
                                      LabelState aux =
                                          LabelState(id: 0, name: '');
                                      items.forEach((element) {
                                        if (element.name == newValue) {
                                          aux = LabelState(
                                              id: element.id, name: newValue!);
                                        }
                                      });
                                      BlocProvider.of<LabelSelectCubit>(context)
                                          .selectLabel(aux);
                                      idLabel = aux.id;
                                    },
                                    items: items.map<DropdownMenuItem<String>>(
                                        (LabelState value) {
                                      return DropdownMenuItem<String>(
                                        value: value.name,
                                        child: Text(value.name),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                              TextButton(
                                onPressed: () {
                                  select = null;
                                  idLabel = null;
                                  //Crear lista auxiliar para guardar las etiquetas seleccionadas
                                  BlocProvider.of<LabelsAuxCubit>(context)
                                      .getLabels(tokenState.authToken);
                                  BlocProvider.of<LabelSelectCubit>(context)
                                      .selectLabel(LabelState(id: 0, name: ''));
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        const LabelPage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ));
                                },
                                child: const Icon(Icons.edit),
                              )
                            ],
                          );
                        }),
                        Container(
                          height: 200,
                        ),
                        SizedBox(
                          width: 500,
                          child: ElevatedButton(
                              onPressed: () async {
                                //Crear la tarea
                                //Verificar que los campos no esten vacios
                                if (dateController.text != "" &&
                                    nameController != "") {
                                  //Verificar que se haya seleccionado una etiqueta
                                  if (select != null) {
                                    TaskState task = TaskState(
                                        date: dateController.text,
                                        labelName: select!,
                                        description: nameController.text,
                                        taskId: 0);
                                    await BlocProvider.of<TasksCubit>(context)
                                        .addTask(task, tokenState.authToken);
                                    //Actualizar la lista de tareas
                                    BlocProvider.of<TasksCubit>(context)
                                        .getTasks(tokenState.authToken);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Tarea registrada con exito')));
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Debe seleccionar una etiqueta')));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Debe llenar todos los campos')));
                                }
                              },
                              child: const Text('GUARDAR')),
                        ),
                        SizedBox(
                          width: 500,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('CANCELAR')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> _selectionDate(
      TextEditingController dateController, BuildContext context) async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (date != null) {
      dateController.text =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
    }
    return dateController.text;
  }
}
