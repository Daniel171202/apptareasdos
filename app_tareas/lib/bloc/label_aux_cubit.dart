import 'package:app_tareas/bloc/label_state.dart';
import 'package:app_tareas/services/label_services.dart';
import 'package:bloc/bloc.dart';

class LabelsAuxCubit extends Cubit<ListLabelState> {
  final String token;
  //Constructor con getLabels
  LabelsAuxCubit(this.token) : super(ListLabelState([])) {
    getLabels(token);
  }
  //Obtener etiquetas
  void getLabels(String token) async {
    List<LabelState> labels = await LabelServices.getLabels(token);
    emit(ListLabelState(labels));
  }

  //Eliminar todas las etiquetas
  Future<void> deleteAllLabels() async {
    emit(ListLabelState([]));
  }
}
