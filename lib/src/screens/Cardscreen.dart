import 'package:flutter/material.dart';
import 'package:proyecto2flutter/src/screens/Api.dart';
import 'package:proyecto2flutter/src/screens/Prost.dart';

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
      appBar: AppBar(
        title: Text('TECBOOK '),
        backgroundColor: Color.fromARGB(255, 86, 211, 228),
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
                                  // URL de la imagen
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.network(
                                      posts[index].imageUrl,
                                      width: 200, // ajusta el ancho de la imagen
                                      height: 200, // ajusta la altura de la imagen
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Nombre de usuario
                                        Text(
                                          widget.currentUser.split('@').first,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        // Titulo
                                        Text(
                                          posts[index].title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        // Contenido
                                        Text(posts[index].body),
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
            top: kToolbarHeight + 5.0, // ajusta la posición del botón debajo del AppBar
            right: 30.0, // ajusta la posición del botón a la esquina superior derecha
            child: FloatingActionButton(
              onPressed: () {
                _showAddPostDialog(context);
              },
              child: Icon(Icons.add),
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
              child: Text('API'),
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
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Descripción'),
                  onChanged: (value) => title = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Lugar'),
                  onChanged: (value) => body = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Imagen'),
                  onChanged: (value) => imageUrl = value,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  posts.add(Post(
                      title: title,
                      body: body,
                      imageUrl: imageUrl,
                      createdBy: widget.currentUser));
                });
                Navigator.of(context).pop();
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
}
