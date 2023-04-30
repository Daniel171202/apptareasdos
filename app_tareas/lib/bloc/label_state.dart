import 'package:equatable/equatable.dart';

class LabelState extends Equatable {
  final int id;
  final String name;
  //Constructor
  LabelState({
    required this.id,
    required this.name,
  });
  //Map
  factory LabelState.fromMap(Map labelMap) {
    return LabelState(
      id: labelMap['labelId'],
      name: labelMap['name'],
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [id, name];

  LabelState copyWith({required String name}) {
    return LabelState(
      id: this.id,
      name: name,
    );
  }
}

class ListLabelState {
  final List<LabelState> labels;
  ListLabelState(
    List<LabelState> newLabels, {
    List<LabelState>? labels,
  }) : labels = newLabels;
}
