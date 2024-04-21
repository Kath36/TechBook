import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photo {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String createdAt; 

  Photo({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['alt_description'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urls']['regular'],
      createdAt: json['created_at'], 
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Photo>> _fetchPhotos;

  Future<List<Photo>> _getPhotos() async {
    final response = await http.get(
      Uri.parse('https://api.unsplash.com/photos/?client_id=ARZwEoKxZudyZlGTcSna4SxPS80P9_qHD9T_44o3j3E'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPhotos = _getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      title: 'Galeria Api',
      theme: ThemeData(
        primaryColor: Colors.blue,
        backgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black87),
          headline6: TextStyle(color: Colors.black),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50], 
        appBar: AppBar(
          title: Text(
            'TECBOOK',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.blue,  
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<List<Photo>>(
          future: _fetchPhotos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            } else {
              final List<Photo> photos = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  final photo = photos[index];
                  return Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 300, 
                            child: Image.network(
                              photo.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              photo.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              photo.description,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '${photo.createdAt}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
