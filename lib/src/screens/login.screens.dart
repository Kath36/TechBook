import 'package:flutter/material.dart';
import 'package:login/src/Bloc/bloc.dart';
import 'package:login/src/screens/calculator_screen.dart';

class LoginScreen extends StatelessWidget {
  final bloc = Bloc();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(
              margin: EdgeInsets.only(top: 25.0),
            ),
            submitButton(context),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Kado@gmail.com',
            labelText: 'Email',
            errorText: snapshot.error != null ? snapshot.error.toString() : null,
          ),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
           // labelText: 'Contraseña',
            hintText: 'Contraseña',
            errorText: snapshot.error != null ? snapshot.error.toString() : null,
          ),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      child: Text('Iniciar sesión'),
      onPressed: () {
        String username = _emailController.text;
        String password = _passwordController.text;
        if ((username == 'kadova@gmail.com' && password == '123') ||
            (username == 'ka@gmail.com' && password == '123')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CalculatorScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuario o contraseña incorrectos'),
            ),
          );
        }
      },
    );
  }
}
