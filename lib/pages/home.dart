// ignore_for_file: unnecessary_const

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokeapp/pages/config/objects.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() {
    return _Home();
  }
}

Future<List<Feed>> fetchFeed() async {
  final response =
      await http.get(Uri.parse("http://pokehub.pandacrp.com/api/getAllFeed"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)["feed"];
    return jsonResponse.map((data) => Feed.fromJson(data)).toList();
  } else {
    print(response.body);
    throw Exception("Unexpected error occured!");
  }
}

class _Home extends State<Home> {
  final storage = new FlutterSecureStorage();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<Feed>> feeds;

  @override
  void initState() {
    super.initState();
  }

  var isLogin = false;
  String page = "home";

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
      body: FutureBuilder<List<Feed>>(
        future: fetchFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Feed>? data = snapshot.data;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  print(data![index].image);
                  return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 7,
                            color: Color(0x2F1D2429),
                            offset: Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Visibility(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: Image.network(
                                    "https://randomwordgenerator.com/img/picture-generator/57e3d6424351ad14f1dc8460962e33791c3ad6e04e507440772d7cdd9144c4_640.jpg", //data![index].image,
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                visible: data[index].image != ""),
                            Visibility(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16, 8, 16, 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        data[index].title,
                                      ),
                                    ],
                                  ),
                                ),
                                visible: data[index].title != ""),
                            Visibility(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      data[index].date,
                                    ),
                                  ],
                                ),
                              ),
                              visible: data[index].date != "",
                            ),
                            Visibility(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data[index].content,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              visible: data[index].content != "",
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            print(snapshot.data);
            return const Text(
                "Une erreur est survenue pendant la r??cup??ration des donn??es");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
