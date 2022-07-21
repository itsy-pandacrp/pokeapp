import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokeapp/pages/config/header.dart';
import 'package:pokeapp/pages/config/post.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokeapp/pages/config/objects.dart';
import 'package:http/http.dart' as http;

List<Widget> _Home_content = [];
List _List_Content = [];

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
  Future<List<Feed>> feedFuture = getFeeds();

  static Future<List<Feed>> getFeeds() async {
    var url = Uri.parse('http://10.176.128.167/api/feed/index.php');
    final response = await http.get(url);

    print(response.body);
    final body = json.decode(response.body);
    return body.map<Feed>(Feed.fromJson).toList();
  }

  @override
  void initState() {
    super.initState();
  }

  var isLogin = false;
  String page = "guild";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> litems;

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
        body: FutureBuilder(
            future: feedFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                final feedlist = snapshot.data!;
                return (feedView(feedlist as List<Feed>));
              } else {
                return (Text("No data"));
              }
            }));
  }

  Widget feedView(List<Feed> feedlist) => ListView.builder(
        itemCount: feedlist.length,
        itemBuilder: ((context, index) {
          final feed = feedlist[index];

          return Card(
            child: Text(feed.title),
          );
        }),
      );
}

abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}
