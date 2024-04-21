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
      backgroundColor: Colors.blueGrey[50], 
      appBar: AppBar(
        title: Text('TECBOOK'),
        backgroundColor: Colors.blue,  
          automaticallyImplyLeading: false, 

      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'WELCOME TO TECBOOK LOGIN KATHERINE DOMINGUEZ',
              
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue, 
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            emailField(),
            SizedBox(height: 20.0), 
            passwordField(),
            SizedBox(height: 20.0), 
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
            border: OutlineInputBorder( 
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true, 
            fillColor: Colors.white, 
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
            border: OutlineInputBorder( 
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true, 
            fillColor: Colors.white,
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
        if ((username == 'katherine@gmail.com' && password == '123')||
           (username == 'Abril@gmail.com' && password == '890')||
            (username == 'ka@gmail.com' && password == '123')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardScreen(currentUser: username)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Usuario o contraseña incorrectos'),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom( 
        backgroundColor: Colors.blue, 
        padding: EdgeInsets.all(15.0), 
        shape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
