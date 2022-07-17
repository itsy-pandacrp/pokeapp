import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'config/header.dart';

class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Home({super.key});
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
