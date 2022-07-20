import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Home createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  var isLogin = false;
  String page = "guild";

  @override
  Widget build(BuildContext context) {
    () async {};
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
