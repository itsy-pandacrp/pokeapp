// ignore_for_file: unnecessary_const

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokeapp/pages/config/objects.dart';
import 'package:http/http.dart' as http;

class Pokemon {
  final String name;
  final String picture;

  Pokemon({required this.name, required this.picture});

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      Pokemon(name: json["name"], picture: json["picture"]);
}

class PokeDex extends StatefulWidget {
  const PokeDex({Key? key}) : super(key: key);

  @override
  _PokeDex createState() {
    return _PokeDex();
  }
}

Future<List<Pokemon>> fetchFeed() async {
  final response = await http
      .post(Uri.parse("http://pokehub.pandacrp.com/api/getListPokemon"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)["feed"];
    return jsonResponse.map((data) => Pokemon.fromJson(data)).toList();
  } else {
    print(response.body);
    throw Exception("Unexpected error occured!");
  }
}

class _PokeDex extends State<PokeDex> {
  final storage = new FlutterSecureStorage();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Pokemon>> feeds;

  @override
  void initState() {
    super.initState();
  }

  var isLogin = false;
  String page = "pokedex";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: const DefaultAppBar(
        parms: {},
      ),
      drawer: DefaultContainer(parms: {
        'page': page,
        'account': const {'isLogged': false}
      }),
      endDrawer: DefaultDrawer(
        parms: const {},
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: fetchFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pokemon>? data = snapshot.data;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: // Generated code for this Container Widget...
                          Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  data![index].picture,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data![index].name,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                });
          } else if (snapshot.hasError) {
            print(snapshot.data);
            return const Text(
                "Une erreur est survenue pendant la récupération des données");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
