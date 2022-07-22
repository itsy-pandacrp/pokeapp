import "dart:async";
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:pokeapp/pages/account.dart';
import "package:pokeapp/pages/login.dart";
import "package:pokeapp/pages/guild.dart";
import "package:pokeapp/pages/pokedex.dart";
import "package:pokeapp/pages/home.dart";
import "package:pokeapp/pages/config/objects.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key? key, required this.parms}) : super(key: key);

  final parms;

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  Size get preferredSize => const Size.fromHeight(100);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Visibility(
        visible: widget.parms["leadingVisible"] ?? true,
        child: new IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        Visibility(
            visible: widget.parms["actionVisible"] ?? true,
            child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => Scaffold.of(context).openEndDrawer()))
      ],
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Center(
        child: Image.asset("assets/logos/logo.png", width: 40, height: 40),
      ),
    );
  }
}

class DefaultContainer extends StatefulWidget implements PreferredSizeWidget {
  const DefaultContainer({Key? key, required this.parms}) : super(key: key);

  final Map<String, dynamic> parms;

  @override
  State<DefaultContainer> createState() => _DefaultContainerState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _DefaultContainerState extends State<DefaultContainer> {
  final storage = new FlutterSecureStorage();
  String userToken = "";
  Size get preferredSize => const Size.fromHeight(100);

  @override
  void initState() {
    super.initState();
    storage.read(key: 'uti_token').then((value) {
      setState(() {
        userToken = value ?? "";
        if (userToken == "") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        }
      });
    });
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 250,
        child: Drawer(
          child: Column(
            children: <Widget>[
              const Divider(
                color: Colors.transparent,
              ),
              ListTile(
                  leading: Image.network(
                      "https://img.icons8.com/ios/50/000000/dog-house.png"),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: const Text(
                    "Home",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                  enabled: (widget.parms["page"] != "home")),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                  leading: Image.network(
                      "https://img.icons8.com/ios/50/000000/pokeball--v1.png"),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: const Text(
                    "Pokedex",
                  ),
                  onTap: () {
                    var push = Navigator.push(
                      context,
                      new MaterialPageRoute(builder: (context) => PokeDex()),
                    );
                  },
                  enabled: (widget.parms["page"] != "pokedex")),
              const Divider(
                color: Colors.grey,
              ),
              ListTile(
                  leading: Image.network(
                      "https://img.icons8.com/ios/50/000000/user-group-man-man.png"),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  title: const Text(
                    "Guild",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => const Guild()),
                    );
                  },
                  enabled: (widget.parms["page"] != "guild")),
              const Divider(
                color: Colors.grey,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                      leading: Image.network(
                          "https://img.icons8.com/ios/50/000000/user-male-circle.png"),
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4),
                      title: const Text(
                        "Account",
                      ),
                      onTap: () {
                        var materialPageRoute = MaterialPageRoute(
                            builder: (context) => const Account());
                        Navigator.push(
                          context,
                          materialPageRoute,
                        );
                      },
                      enabled: (widget.parms["page"] != "account")),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
            ],
          ),
        ));
  }
}

Future<List<Chat>> fetchData() async {
  final response = await http.get(Uri.parse("http://10.176.128.167/chat.json"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)["chat"];
    return jsonResponse.map((data) => new Chat.fromJson(data)).toList();
  } else {
    throw Exception("Unexpected error occured!");
  }
}

// ignore: must_be_immutable
class DefaultDrawer extends StatefulWidget implements PreferredSizeWidget {
  DefaultDrawer({super.key, required this.parms}) {
    const Size.fromHeight(100);
  }

  // ignore: prefer_typing_uninitialized_variables
  var parms;
  @override
  State<DefaultDrawer> createState() => _DefaultDrawerState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _DefaultDrawerState extends State<DefaultDrawer> {
  Size get preferredSize => const Size.fromHeight(100);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Center(
      child: FutureBuilder<List<Chat>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Chat>? data = snapshot.data;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            data![index].chatImage,
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Text(data[index].userName),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    12, 0, 0, 0),
                                child: Text(data[index].lastMessage),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: const Color(0xFFF1F4F8),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
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
            return const Text(
                "Une erreur est survenue pendant la récupération des données");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}
