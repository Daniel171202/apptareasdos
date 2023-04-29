import 'package:flutter/material.dart';

class modeloTarea{
  String Nombre;
  String Fecha;
  String etiqueta;
  bool Estado;
  modeloTarea(this.Nombre,this.Fecha,this.etiqueta,this.Estado);
  Map<String,dynamic> toMap(){
    return{'Nombre':Nombre,'Fecha':Fecha,'Etiqueta':etiqueta};
  }
}
class modeloEtiqueta
{
  String Nombre;
  modeloEtiqueta(this.Nombre);
  Map<String,dynamic> toMap(){
    return {'Nombre':Nombre};
  }
}
