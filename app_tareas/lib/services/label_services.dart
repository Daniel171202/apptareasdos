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

  //Actualizar todas las etiquetas
  static Future<String> updateAllLabels(
      List<LabelState> labels, String token) async {
    print("LABELS: $labels");
    var url = Uri.parse(baseUrl + '/label');
    List<Map> labelsMap = [];
    for (var label in labels) {
      labelsMap.add(label.toMap());
    }
    var body = json.encode(labelsMap);
    http.Response response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: body);
    if (response.statusCode == 200) {
      Map responseMap = json.decode(response.body);
      if (responseMap["code"] != "0000") {
        return 'Error 404';
      }
      return 'Labels updated';
    } else {
      return 'Error 500';
    }
  }
}
