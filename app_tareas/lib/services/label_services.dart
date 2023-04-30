import 'package:app_tareas/bloc/label_state.dart';
import 'dart:convert';
import 'globals.dart';
import 'package:http/http.dart' as http;

class LabelServices {
  //Obtiene la lista de etiquetas
  static Future<List<LabelState>> getLabels(String token) async {
    var url = Uri.parse(baseUrl + '/label');

    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] != "0000") {
        return [LabelState(id: -1, name: 'Error 404')];
      }
      List<LabelState> labels = [];
      for (var labelMap in responseMap['response']) {
        LabelState label = LabelState.fromMap(labelMap);
        labels.add(label);
      }
      return labels;
    } else {
      print('Error: ${response.statusCode}');
      return [LabelState(id: -1, name: 'Error 404')];
    }
  }

  //Obtiene una etiqueta por id
  static Future<LabelState> getLabel(int id, String token) async {
    var url = Uri.parse(baseUrl + '/label/$id');
    http.Response response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] != "0000") {
        return LabelState(id: -1, name: 'Label not found');
      }
      LabelState label = LabelState.fromMap(responseMap);
      return label;
    } else {
      print('Error: ${response.statusCode}');
      return LabelState(id: -1, name: 'Error 404');
    }
  }

  //Actualiza una etiqueta
  static Future<LabelState> updateLabel(
      LabelState newLabel, String token) async {
    Map data = {
      'labelId': newLabel.id,
      'name': newLabel.name,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/label/${newLabel.id}');
    http.Response response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] != "0000") {
        return LabelState(id: -1, name: 'Label not found');
      }
      LabelState label = LabelState.fromMap(responseMap);
      return label;
    } else {
      print('Error: ${response.statusCode}');
      return LabelState(id: -1, name: 'Error 404');
    }
  }

  //Agrega una etiqueta
  static Future<String> createLabel(LabelState label, String token) async {
    var url = Uri.parse(baseUrl + '/label');
    Map data = {
      'labelId': label.id,
      'name': label.name,
    };
    var body = json.encode(data);
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
      body: body,
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] != "0000") {
        return 'Error 404';
      }
      return 'Label created';
    } else {
      print('Error: ${response.statusCode}');
      return 'Error 404';
    }
  }

  //Elimina una etiqueta por id
  static Future<String> deleteLabel(int id, String token) async {
    var url = Uri.parse(baseUrl + '/label/$id');
    http.Response response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] != "0000") {
        return 'Label not found';
      }
      return 'Etiqueta eliminada';
    } else {
      return 'Error 404';
    }
  }
}
