import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';

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
    );
  }
}
