import 'package:app_tareas/bloc/label_aux_cubit.dart';
import 'package:app_tareas/bloc/label_cubit.dart';
import 'package:app_tareas/bloc/label_state.dart';
import 'package:app_tareas/bloc/token_cubit.dart';
import 'package:app_tareas/bloc/token_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabelPage extends StatelessWidget {
  const LabelPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("GESTIONAR ETIQUETA"),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<LabelsAuxCubit, ListLabelAuxState>(
          builder: (context, state) {
            final labels = state.labels;
            final List<TextEditingController> controllers = [];
            for (int i = 0; i < labels.length; i++) {
              controllers.add(TextEditingController());
              controllers[i].text = labels[i].name;
            }
            return SingleChildScrollView(
              child: BlocBuilder<TokenCubit, TokenState>(
                builder: (context, tokenState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 400,
                        width: 300,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: labels.length,
                              itemBuilder: (context, index) {
                                return labels.isEmpty
                                    ? const Text('No hay etiquetas')
                                    : Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        elevation: 3,
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: 150,
                                                height: 30,
                                                child: TextField(
                                                  controller:
                                                      controllers[index],
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    //Borrar sin guardar
                                                    BlocProvider.of<
                                                                LabelsAuxCubit>(
                                                            context)
                                                        .deleteLabelNoEmit(
                                                            labels[index]);
                                                  },
                                                  child:
                                                      const Icon(Icons.delete))
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            )),
                      ),
                      const Divider(
                        height: 50,
                        thickness: 2,
                        color: Colors.black,
                        endIndent: 50,
                        indent: 50,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<LabelsAuxCubit>(context)
                                .addLabelNoEmit(LabelState(id: 0, name: ''));
                          },
                          child: const Text('NUEVO')),
                      ElevatedButton(
                          onPressed: () async {
                            bool save = true;
                            //Verificar que ningun controlador este vacio
                            for (int i = 0; i < controllers.length; i++) {
                              if (controllers[i].text.isEmpty) {
                                save = false;
                                break;
                              }
                            }
                            if (!save) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'No se puede guardar una etiqueta vacia')));
                            } else {
                              List<LabelState> newLabels = [];
                              //Guardar etiquetas
                              for (int i = 0; i < labels.length; i++) {
                                newLabels.add(LabelState(
                                    id: labels[i].id,
                                    name: controllers[i].text));
                              }
                              //Actualizar lista de etiquetas
                              String msg =
                                  await BlocProvider.of<LabelsCubit>(context)
                                      .replaceAllLabels(
                                          newLabels, tokenState.authToken);

                              if (msg == 'Ok') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Se actualizo las etiquetas')));
                                //Salir de la pagina
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'No se pudo actualizar las etiquetas')));
                              }
                            }
                          },
                          child: const Text('GUARDAR')),
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Text('CERRAR'))
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
