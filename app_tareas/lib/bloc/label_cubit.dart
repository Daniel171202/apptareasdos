import 'package:app_tareas/bloc/label_state.dart';
import 'package:app_tareas/services/label_services.dart';
import 'package:bloc/bloc.dart';

class LabelsCubit extends Cubit<ListLabelState> {
  final String token;
  //Constructor con getLabels
  LabelsCubit(this.token) : super(ListLabelState([])) {
    getLabels(token);
  }
  //Obtener etiquetas
  void getLabels(String token) async {
    List<LabelState> labels = await LabelServices.getLabels(token);
    emit(ListLabelState(labels));
  }

  //Obtener etiqueta por id
  void getLabelById(int id, String token) async {
    try {
      LabelState label = await LabelServices.getLabel(id, token);
      emit(ListLabelState([label]));
    } catch (e) {
      print(e);
    }
  }

  //Eliminar todas las etiquetas
  Future<void> deleteAllLabels() async {
    emit(ListLabelState([]));
  }

  //Actualizar etiqueta
  Future<void> updateLabel(LabelState label, String token) async {
    try {
      LabelState newLabel = await LabelServices.updateLabel(label, token);
      final List<LabelState> newLabels = List.from(state.labels)
        ..[state.labels.indexOf(label)] = newLabel;
      emit(ListLabelState(newLabels));
    } catch (e) {
      print(e);
    }
  }

  //Agregar etiqueta
  Future<void> addLabel(LabelState label, String token) async {
    await LabelServices.createLabel(label, token);
  }

  //Eliminar etiqueta por id
  Future<void> deleteLabel(int id, String token) async {
    await LabelServices.deleteLabel(id, token);
  }
}
