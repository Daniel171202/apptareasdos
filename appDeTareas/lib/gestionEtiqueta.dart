import 'package:apptareas/listaTareas.dart';
import 'package:apptareas/modelos.dart';
import 'package:flutter/material.dart';
import 'Tarea.dart';
import 'modelos.dart';
class gestionEtiqueta extends StatefulWidget {
  const gestionEtiqueta({Key? key}) : super(key: key);
  @override
  State<gestionEtiqueta> createState() => _gestionEtiquetaState();
}

class _gestionEtiquetaState extends State<gestionEtiqueta> {
  List<TextEditingController> _controllers = [];
  List<modeloEtiqueta> listAux=[];
  @override
  void initState() {
    super.initState();
    listAux.addAll(listaTareas.listaEtiqueta);
    for (int i = 0; i < listAux.length; i++) {
      _controllers.add(TextEditingController());
      _controllers[i].text=listAux[i].Nombre;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("GESTIONAR ETIQUETA"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
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
                      itemCount: listAux.length,
                        itemBuilder: (context, index) {
                          return listAux.isEmpty?Text('No hay etiquetas'):Card(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 3,
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 150,
                                    height: 30,
                                    child: TextField(
                                      controller: _controllers[index],
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder()
                                      )
                                    ),
                                  ),
                                  TextButton(onPressed: () {
                                    listAux.removeAt(index);
                                    _controllers.removeAt(index);
                                    setState(() {

                                    });
                                  },
                                      child: Icon(Icons.delete))
                                ],
                              ),
                            ),
                          );
                        },
                    ),
                  ),
                ),
                const Divider(
                  height: 50,
                  thickness: 2,
                  color: Colors.black,
                  endIndent: 50,
                  indent: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      listAux.add(modeloEtiqueta(''));
                      _controllers.add(TextEditingController());
                      setState(() {
                      });
                    }, child: const Text('NUEVO')),
                ElevatedButton(
                    onPressed: () {
                      bool datosVacios=false;
                      for(int i=0;i<listAux.length;i++)
                      {
                        listAux[i].Nombre=_controllers[i].text;
                        if(_controllers[i].text=="")
                        {
                          datosVacios=true;
                        }
                      }
                      if(datosVacios)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Hay una etiqueta vacía, corrígela.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                      else
                      {
                        listaTareas.listaEtiqueta.clear();
                        listaTareas.listaEtiqueta.addAll(listAux);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Datos guardados'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tarea()));
                      }

                    }, child: const Text('GUARDAR')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tarea()));
                    }, child: const Text('CERRAR')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
