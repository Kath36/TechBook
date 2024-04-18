import 'package:flutter/material.dart';
import 'package:proyecto2flutter/src/Bloc/bloc.dart';
import 'package:proyecto2flutter/src/screens/Cardscreen.dart';

class LoginScreen extends StatelessWidget {
  final bloc = Bloc();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Cambié el color de fondo a un tono grisáceo
      appBar: AppBar(
        title: Text('TECBOOK'), // Cambié el título del AppBar a "TECBOOK"
        backgroundColor: Colors.blue, // Establecí el color de fondo del AppBar a azul
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'WELCOME TO TECBOOK LOGIN', // Agregué un título adicional
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Cambié el color del texto a azul
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            emailField(),
            SizedBox(height: 20.0), // Agregué un espacio adicional entre los campos de texto
            passwordField(),
            SizedBox(height: 20.0), // Agregué un espacio adicional entre los campos de texto y el botón
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
            hintText: 'example@gmail.com',
            labelText: 'Email',
            errorText: snapshot.error != null ? snapshot.error.toString() : null,
            border: OutlineInputBorder( // Agregué un borde alrededor del campo de texto
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true, // Establecí que el campo de texto esté lleno con un color de fondo
            fillColor: Colors.white, // Cambié el color de fondo del campo de texto a blanco
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
            hintText: 'Contraseña',
            labelText: 'Contraseña',
            errorText: snapshot.error != null ? snapshot.error.toString() : null,
            border: OutlineInputBorder( // Agregué un borde alrededor del campo de texto
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true, // Establecí que el campo de texto esté lleno con un color de fondo
            fillColor: Colors.white, // Cambié el color de fondo del campo de texto a blanco
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
        if ((username == 'katherine@gmail.com' && password == '123') ||
            (username == 'ka@gmail.com' && password == '123')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardScreen(currentUser: username)), // Pasar el nombre de usuario como argumento
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuario o contraseña incorrectos'),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom( // Agregué estilos al botón
        backgroundColor: Colors.blue, // Cambié el color de fondo del botón a azul
        padding: EdgeInsets.all(15.0), // Aumenté el espacio de padding dentro del botón
        shape: RoundedRectangleBorder( // Redondeé los bordes del botón
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
