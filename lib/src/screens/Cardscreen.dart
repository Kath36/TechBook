import 'package:flutter/material.dart';
import 'package:proyecto2flutter/src/screens/Api.dart';
import 'package:proyecto2flutter/src/screens/Post.dart';
import 'package:proyecto2flutter/src/screens/login.screens.dart';

class CardScreen extends StatefulWidget {
  final String currentUser;

  CardScreen({required this.currentUser});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('TECBOOK'),
          automaticallyImplyLeading: false, 
  backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.network(
                                      posts[index].imageUrl,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.currentUser.split('@').first,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        // Titulo
                                        Text(
                                          posts[index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        // Contenido
                                        Text(
                                          posts[index].body,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    posts.removeAt(index);
                                  });
                                },
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: kToolbarHeight + 5.0,
            right: 30.0,
            child: FloatingActionButton(
              onPressed: () {
                _showAddPostDialog(context);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.purple,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text(
                'API',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    String title = '';
    String body = '';
    String imageUrl = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Post'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nombre: ${widget.currentUser.split('@').first}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) => title = value,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Lugar',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) => body = value,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Imagen',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onChanged: (value) => imageUrl = value,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && body.isNotEmpty && imageUrl.isNotEmpty) {
                  setState(() {
                    posts.add(Post(
                      title: title,
                      body: body,
                      imageUrl: imageUrl,
                      createdBy: widget.currentUser,
                    ));
                  });
                  Navigator.of(context).pop();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Todos los campos son obligatorios.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('+'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cerrar sesión'),
          content: Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }
}
