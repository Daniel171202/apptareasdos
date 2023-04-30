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
        child: BlocBuilder<LabelsCubit, ListLabelState>(
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
                                                    //Borrar etiqueta
                                                    await BlocProvider.of<
                                                                LabelsCubit>(
                                                            context)
                                                        .deleteLabel(
                                                            labels[index].id,
                                                            tokenState
                                                                .authToken);
                                                    //Actualizar lista de etiquetas
                                                    BlocProvider.of<
                                                                LabelsCubit>(
                                                            context)
                                                        .getLabels(tokenState
                                                            .authToken);
                                                    controllers.removeAt(index);
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
                            //Agregar label vacio
                            await BlocProvider.of<LabelsCubit>(context)
                                .addLabel(LabelState(id: 0, name: ''),
                                    tokenState.authToken);
                            //Actualizar lista de labels
                            BlocProvider.of<LabelsCubit>(context)
                                .getLabels(tokenState.authToken);
                          },
                          child: const Text('NUEVO')),
                      ElevatedButton(
                          onPressed: () async {
                            //Verificar que no haya etiquetas vacias
                            bool vacio = false;
                            labels.forEach((element) {
                              if (controllers[labels.indexOf(element)].text ==
                                  '') {
                                vacio = true;
                              }
                            });
                            if (vacio) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'No puede haber etiquetas vacias')));
                            } else {
                              //Actualizar labels
                              for (int i = 0; i < labels.length; i++) {
                                await BlocProvider.of<LabelsCubit>(context)
                                    .updateLabel(
                                        LabelState(
                                            id: labels[i].id,
                                            name: controllers[i].text),
                                        tokenState.authToken);
                              }
                              //Actualizar lista auxiliar de labels
                              BlocProvider.of<LabelsAuxCubit>(context)
                                  .getLabels(tokenState.authToken);
                              //Mostrar mensaje de exito
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Etiquetas actualizadas')));
                              //Actualizar la lista de labels
                              BlocProvider.of<LabelsCubit>(context)
                                  .getLabels(tokenState.authToken);
                              //Volver a la pagina anterior
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('GUARDAR')),
                      BlocBuilder<LabelsAuxCubit, ListLabelState>(
                        builder: (context, auxState) {
                          return ElevatedButton(
                              onPressed: () async {
                                for (int i = 0; i < labels.length; i++) {
                                  await BlocProvider.of<LabelsCubit>(context)
                                      .deleteLabel(
                                          labels[i].id, tokenState.authToken);
                                }
                                for (int i = 0;
                                    i < auxState.labels.length;
                                    i++) {
                                  await BlocProvider.of<LabelsCubit>(context)
                                      .addLabel(
                                          LabelState(
                                              id: 0,
                                              name: auxState.labels[i].name),
                                          tokenState.authToken);
                                }
                                BlocProvider.of<LabelsCubit>(context)
                                    .getLabels(tokenState.authToken);
                                //Salir de la pagina
                                Navigator.of(context).pop();
                              },
                              child: const Text('CERRAR'));
                        },
                      )
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
