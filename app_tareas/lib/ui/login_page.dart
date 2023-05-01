import 'package:app_tareas/bloc/label_cubit.dart';
import 'package:app_tareas/bloc/login_state.dart';
import 'package:app_tareas/bloc/task_cubit.dart';
import 'package:app_tareas/bloc/token_cubit.dart';
import 'package:app_tareas/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/token_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO APP"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Usuario'),
                    TextField(
                      controller: userController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Contraseña'),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  //Intento de login
                  BlocProvider.of<TokenCubit>(context).login(LoginUserState(
                      user: userController.text,
                      password: passwordController.text));
                  //Verificar si el login fue exitoso
                  BlocProvider.of<TokenCubit>(context)
                      .stream
                      .listen((state) async {
                    if (state is TokenState) {
                      if (state.authToken == "error 404" ||
                          state.authToken == 'Error de autenticación') {
                        //Login fallido
                        state.authToken == "error 404"
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text('Error 404'),
                              ))
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text('Error de autenticación'),
                              ));
                      } else {
                        //Login exitoso'
                        //Obtener las tareas
                        await BlocProvider.of<TasksCubit>(context)
                            .getTasks(state.authToken);
                        //Ir a la pagina de tareas
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                      }
                    }
                  });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                ),
                child: const Text(
                  'INGRESAR',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
