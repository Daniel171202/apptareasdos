import 'listaTareas.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TODO APP"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(

            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Usuario'),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder()
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contraseña'),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder()
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => listaTareas(),));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color> (Colors.blueAccent),
                ),
                  child: const Text('INGRESAR', style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        ),
      );
  }
}
