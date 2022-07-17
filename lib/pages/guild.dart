import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'config/header.dart';

class Guild extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Guild({super.key});
  var isLogin = false;
  String page = "guild";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: default_AppBar(
        parms: {},
      ),
      drawer: new default_Container(parms: {
        'page': page,
        'account': {'isLogged': false}
      }),
      endDrawer: default_Drawer(
        parms: {},
      ),
    );
  }
}
