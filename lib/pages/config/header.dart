import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokeapp/pages/help.dart';
import '../login.dart';
import '../guild.dart';
import '../help.dart';
import '../pokedex.dart';
import '../home.dart';

class default_AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  default_AppBar({Key? key, required this.parms}) : super(key: key);

  final parms;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Visibility(
        child: new IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        visible: parms["leadingVisible"] ?? true,
      ),
      actions: [
        Visibility(
            child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => Scaffold.of(context).openEndDrawer()),
            visible: parms["actionVisible"] ?? true)
      ],
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      title: Center(
        child: Image.asset("assets/logos/logo.png", width: 40, height: 40),
      ),
    );
  }
}

class default_Container extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  default_Container({Key? key, required this.parms}) : super(key: key);

  final parms;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        child: Drawer(
          child: Column(
            children: <Widget>[
              Divider(
                color: Colors.transparent,
              ),
              ListTile(
                  leading: Image.network(
                      "https://img.icons8.com/ios/50/000000/dog-house.png"),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(
                    'Home',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new Home()),
                    );
                  },
                  enabled: (parms['page'] != "home")),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                  leading: Image.network(
                      "https://img.icons8.com/ios/50/000000/pokeball--v1.png"),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(
                    'Pokedex',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new Pokedex()),
                    );
                  },
                  enabled: (parms['page'] != "pokedex")),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                  leading: Image.network(
                      "https://img.icons8.com/ios/50/000000/user-group-man-man.png"),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(
                    'Guild',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new Guild()),
                    );
                  },
                  enabled: (parms['page'] != "guild")),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                  leading: Image.network(
                      "https://img.icons8.com/ios/50/000000/help.png"),
                  dense: true,
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(
                    'Help',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => new Help()),
                    );
                  },
                  enabled: (parms['page'] != "help")),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                      leading: Image.network(
                          "https://img.icons8.com/ios/50/000000/user-male-circle.png"),
                      dense: true,
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text(
                        (parms['account']["isLogged"] ? "Account" : "Login"),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Login()),
                        );
                      },
                      enabled: (parms['page'] != "account" &&
                          parms['page'] != "login")),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
            ],
          ),
        ));
  }
}

class Data {
  final int chat_id;
  final String chat_image;
  final String user_name;
  final String last_message;

  Data(
      {required this.chat_id,
      required this.chat_image,
      required this.user_name,
      required this.last_message});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      chat_id: json['chat_id'],
      chat_image: json['chat_image'],
      user_name: json['user_name'],
      last_message: json['last_message'],
    );
  }
}

Future<List<Data>> fetchData() async {
  final response = await http.get(Uri.parse('http://localhost/chat.json'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['chat'];
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class default_Drawer extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  default_Drawer({Key? key, required this.parms}) : super(key: key);

  final parms;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: Center(
        child: FutureBuilder<List<Data>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Data>? data = snapshot.data;
              return ListView.builder(
                  itemCount: data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Image.network(
                              data![index].chat_image,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(data[index].user_name),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 0, 0),
                                  child: Text(data[index].last_message),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Color(0xFFF1F4F8),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                              child: Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Color(0xFF57636C),
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Text(data![index].user_name),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(
                  "Une erreur est survenue pendant la récupération des données");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
