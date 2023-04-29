import 'package:flutter/material.dart';
import 'modelos.dart';
import 'Tarea.dart';
class listaTareas extends StatefulWidget {
  static List<modeloTarea> listaTarea=[];
  static List<modeloEtiqueta> listaEtiqueta=[];
  const listaTareas({Key? key}) : super(key: key);
  @override
  State<listaTareas> createState() => _listaTareasState();
}

class _listaTareasState extends State<listaTareas> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO APP"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: listaTareas.listaTarea.isEmpty ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text('No tienes tareas registradas')),
        ) : Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  width: 300,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listaTareas.listaTarea.length,
                      itemBuilder: (context, index) {
                        modeloTarea tarea = listaTareas.listaTarea[index];
                        return Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${tarea.Nombre}'),
                                      Text('${tarea.Fecha}'),
                                      Text('${tarea.etiqueta}')
                                    ],
                                  ),
                                  width: 150,
                                ),
                                Container(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      tarea.Estado ? complete(index) : pendiente(index)
                                    ],
                                  ),
                                )
                              ],
                            ),

                          ),
                        );
                      },),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Tarea()));
        },
      ),
    );
  }

  Widget complete(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Completado'),
        TextButton(onPressed: () {
          listaTareas.listaTarea[index].Estado = false;
          setState(() {

          });
        }, child: Text('MARCAR COMO PENDIENTE'))
      ],
    );
  }

  Widget pendiente(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pendiente'),
        TextButton(onPressed: () {
          listaTareas.listaTarea[index].Estado = true;
          setState(() {

          });
        }, child: Text('COMPLETAR'),
        )
      ],
    );
  }
}