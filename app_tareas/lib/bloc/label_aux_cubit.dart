import 'package:app_tareas/bloc/label_state.dart';
import 'package:bloc/bloc.dart';

class LabelsAuxCubit extends Cubit<ListLabelAuxState> {
  LabelsAuxCubit() : super(ListLabelAuxState([]));
  //Obtener etiquetas sin emitir
  void getLabelsNoEmit(List<LabelState> labels) async {
    emit(ListLabelAuxState(labels));
  }

  //Agregar etiqueta sin emitir
  void addLabelNoEmit(LabelState label) async {
    final List<LabelState> newLabels = List.from(state.labels)..add(label);
    emit(ListLabelAuxState(newLabels));
  }

  //Eliminar etiqueta sin emitir
  void deleteLabelNoEmit(LabelState label) async {
    final List<LabelState> newLabels = List.from(state.labels)..remove(label);
    emit(ListLabelAuxState(newLabels));
  }
}
