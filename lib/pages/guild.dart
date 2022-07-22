import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:pokeapp/pages/pokedex.dart";
import 'package:pokeapp/pages/config/header.dart';

class GuildList {
  final String name;
  final String master;
  final String created;

  GuildList({required this.name, required this.master, required this.created});

  factory GuildList.fromJson(Map<String, dynamic> json) => GuildList(
      name: json["name"],
      master: json["master_guilde"],
      created: json["created_at"]);
}

Future<List<GuildList>> fetchGuildList() async {
  final response =
      await http.get(Uri.parse("http://pokehub.pandacrp.com/api/getAllTeam"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)["teams"];
    return jsonResponse.map((data) => GuildList.fromJson(data)).toList();
  } else {
    print(response.body);
    throw Exception("Unexpected error occured!");
  }
}

class Guild extends StatefulWidget {
  const Guild({super.key});

  @override
  State<Guild> createState() => _GuildState();
}

class _GuildState extends State<Guild> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var isLogin = false;

  String page = "guild";

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
        body: // Generated code for this Column Widget...
            FutureBuilder<List<GuildList>>(
          future: fetchGuildList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<GuildList>? data = snapshot.data;
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return // Generated code for this Container Widget...
                        Container(
                      width: double.infinity,
                      height: 70,
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
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data![index].name,
                                    ),
                                    Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xFFF5F5F5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            data![index].master,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              child: Icon(
                                Icons.more_vert_rounded,
                                color: Color(0xFF57636C),
                                size: 24,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Text(
                  "Une erreur est survenue pendant la récupération des données");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}


/*
Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDN8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'bir4ever',
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Your team ',
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 4, 0),
                                      child: Text(
                                        'Members',
                                      ),
                                    ),
                                    Text(
                                      '216',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '4.20',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            */