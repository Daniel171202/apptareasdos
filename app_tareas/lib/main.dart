import 'package:app_tareas/bloc/label_aux_cubit.dart';
import 'package:app_tareas/bloc/label_cubit.dart';
import 'package:app_tareas/bloc/label_select_cubit.dart';
import 'package:app_tareas/bloc/label_state.dart';
import 'package:app_tareas/bloc/task_cubit.dart';
import 'package:app_tareas/bloc/token_cubit.dart';
import 'package:flutter/material.dart';
import 'package:app_tareas/ui/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TokenCubit>(create: (context) => TokenCubit()),
      BlocProvider<TasksCubit>(create: (context) => TasksCubit()),
      BlocProvider<LabelsCubit>(create: (context) => LabelsCubit('')),
      BlocProvider<LabelsAuxCubit>(create: (context) => LabelsAuxCubit()),
      BlocProvider<LabelSelectCubit>(
          create: (context) => LabelSelectCubit(LabelState(id: 0, name: '')))
    ], child: const MaterialApp(home: LoginPage()));
  }
}
