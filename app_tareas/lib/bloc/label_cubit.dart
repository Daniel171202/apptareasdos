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
  Future<String> getLabels(String token) async {
    try {
      List<LabelState> labels = await LabelServices.getLabels(token);
      if (labels.isEmpty) return 'Lista vacía';
      if (labels[0].name == 'Error 500' || labels[0].name == 'Error 404')
        return 'Error 500';
      emit(ListLabelState(labels));
      return 'Ok';
    } catch (e) {
      return 'Error 500';
    }
  }

  //Remplazar todas las etiquetas
  Future<String> replaceAllLabels(List<LabelState> labels, String token) async {
    try {
      String response = await LabelServices.updateAllLabels(labels, token);
      if (response == 'Error 500') return 'Error 500';
      emit(ListLabelState(labels));
      return 'Ok';
    } catch (e) {
      return 'Error 500';
    }
  }
}
