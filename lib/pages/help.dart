import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var isLogin = false;

  String page = "help";

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
