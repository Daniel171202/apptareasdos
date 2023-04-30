import 'package:app_tareas/bloc/label_state.dart';
import 'package:bloc/bloc.dart';

class LabelSelectCubit extends Cubit<LabelState> {
  final LabelState label;
  LabelSelectCubit(this.label) : super(LabelState(id: 0, name: '')) {
    selectLabel(label);
  }

  void selectLabel(LabelState label) {
    emit(label);
  }
}
