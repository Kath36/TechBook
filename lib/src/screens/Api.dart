import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto2flutter/src/Bloc/post.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Nasa>> _listadoNasas;

  Future<List<Nasa>> _getNasasForDates(List<String> dates) async {
    List<Nasa> allNasas = [];

    for (var date in dates) {
      final Uri url = Uri.parse(
          "https://api.nasa.gov/planetary/apod?api_key=zQZhBVNuJ1IWR3QtsUxdXpvincMQe5ZOXSXotirv&date=$date");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);

        if (jsonData.containsKey("hdurl")) {
          allNasas.add(Nasa(
              jsonData["title"], jsonData["hdurl"], jsonData["date"]));
        } else {
          throw Exception(
              "El JSON no contiene una URL de imagen en la clave 'hdurl'");
        }
      } else {
        throw Exception("Fallo la conexión");
      }
    }

    return allNasas;
  }

  @override
  void initState() {
    super.initState();
    List<String> dates = [
      "2000-06-29",
      "2002-01-05",
      "2009-09-11",
      "2001-06-11",
      "2018-11-21",
      "2016-11-20",
    ];
    _listadoNasas = _getNasasForDates(dates);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apis NASA',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Apis NASA '),
          backgroundColor: Color.fromARGB(255, 86, 228, 192),
        ),
        body: FutureBuilder(
          future: _listadoNasas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("Error");
            } else {
              final data = snapshot.data as List<Nasa>;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                            ),
                            child: Image.network(
                              data[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  data[index].date,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
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
      theme: ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 45, 44, 45)),
    );
  }
}
