import 'package:apptareas/gestionEtiqueta.dart';
import 'package:apptareas/listaTareas.dart';
import 'package:flutter/material.dart';
import 'modelos.dart';
import 'gestionEtiqueta.dart';
class Tarea extends StatefulWidget {
  const Tarea({Key? key}) : super(key: key);
  @override
  State<Tarea> createState() => _TareaState();
}

class _TareaState extends State<Tarea> {
  TextEditingController controllerNombre= TextEditingController();
  TextEditingController controllerFecha= TextEditingController();
  String? select;

  @override
  void initState() {
    super.initState();
  }
  Future<void> _seleccionFecha(BuildContext context) async{
    final DateTime? Fecha= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if(Fecha!=null)
    {
      controllerFecha.text= '${Fecha.day.toString().padLeft(2, '0')}/${Fecha.month.toString().padLeft(2, '0')}/${Fecha.year.toString()}';
      setState(() {
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRAR NUEVA TAREA"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nombre de la Tarea'),
                    TextField(
                      controller: controllerNombre,
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fecha de cumplimento'),
                    TextField(
                      readOnly: true,
                      controller: controllerFecha,
                      decoration: InputDecoration(
                          border: OutlineInputBorder()
                      ),
                      onTap: () => _seleccionFecha(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Etiqueta'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        listaTareas.listaEtiqueta.isEmpty?Text('No hay etiquetas'):DropdownButton(
                          hint: Text('Seleccione una etiqueta'),
                          value: select,
                          items:listaTareas.listaEtiqueta.map((opcion){
                            return DropdownMenuItem(
                              value: opcion.Nombre,
                              child: Text(opcion.Nombre),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              select=value!;
                            });
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => gestionEtiqueta(),));
                          },
                          child: Icon(Icons.edit),

                        )
                      ],
                    ),
                    Container(height: 200,),
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                          onPressed: () {
                            if(controllerNombre.text=="" || controllerFecha.text=="" || select==null)
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Por favor, llene los datos correctamente.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                            else
                            {
                              listaTareas.listaTarea.add(modeloTarea(controllerNombre.text, controllerFecha.text, select!,false));
                              setState(() {
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Tarea registrada'),
                                  duration: Duration(seconds: 2),
                                ),

                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => listaTareas(),));
                            }
                          }, child: const Text('GUARDAR')),
                    ),
                    SizedBox(
                      width: 500,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                            });
                          }, child: const Text('CANCELAR')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
