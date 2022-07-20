import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'package:pokeapp/pages/config/post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Home createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  final storage = new FlutterSecureStorage();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic> _BodyContent = <String, dynamic>{
    "feed": [
      {"type": "banner", "content": "No content for now"}
    ]
  };

  @override
  void initState() {
    super.initState();

    postData(body: {'token': storage.read(key: 'uti_token')})
        .then((result) => setState(() {
              _BodyContent = result;
            }));
  }


  void getFeed() async {
    return await postData(body: {'token': storage.read(key: 'uti_token')})
                  .then((result) => setState(() {
                        _BodyContent = result;
                        return;
                      }));
  }
  var isLogin = false;
  String page = "guild";

  @override
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
        body: ListView.builder(
    physics: AlwaysScrollableScrollPhysics(),
    itemBuilder: (context, i){
        WeatherData weatherItem = snapshot.data.weather[i];
        return Container(    
            decoration: BoxDecoration(
                ...
    },
    itemCount: snapshot.data.weather.length,
)
        // 
        // RefreshIndicator(
            // onRefresh: () async {
              // postData(body: {'token': storage.read(key: 'uti_token')})
                  // .then((result) => setState(() {
                        // _BodyContent = result;
                        // return;
                      // }));
            // },
            // child: SingleChildScrollView(
                // physics: const AlwaysScrollableScrollPhysics(),
                // child: Column(
                  // children: List.generate(_BodyContent["feed"].length, (index) {
                    // return Text(
                      // _BodyContent["feed"][index].toString(),
                      // style: const TextStyle(fontSize: 22),
                    // );
                  // }),
                //)
              //)
              //)
              );
  }
}
