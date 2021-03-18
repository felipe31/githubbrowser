import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:github_browser/model/github_user_list.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _username = "";
  Future<GithubUserList> _response;
  var _controller = TextEditingController();

  void __searchGithub() {
    Toast.show("Write username and press enter", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  void _searchGithub(String name) {
    setState(() {
      this._username = name;
      //   // This call to setState tells the Flutter framework that something has
      //   // changed in this State, which causes it to rerun the build method below
      //   // so that the display can reflect the updated values. If we changed
      //   // _counter without calling setState(), then the build method would not be
      //   // called again, and so nothing would appear to happen.
      print("inside searchGithub");
      _response = fetchUser(_username, debug: false);
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _username = "";
    });
  }

  Future<GithubUserList> fetchUser(String name, {bool debug = false}) async {
    if (name.isEmpty) throw null;
    return GithubUserList.fetchUsers(name, debug: debug);
  }

  Widget buildUserCard({avatarUrl, name, login}) {
    return Container(
        height: 100,
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
              // color: Color(0xFF000000),
                border: Border.all(color: Color(0xff838383), width: 1),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Image.network(
              avatarUrl,
              height: 90,
              width: 90,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                Text(
                      () {
                    return login != null ? "@${login}" : "";
                  }(),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          canvasColor: Color(0xFFe1e1e1e1),
          primarySwatch: MaterialColor(
            0xFF313131,
            <int, Color>{
              50: Color(0xFF000000),
              100: Color(0xFF000000),
              200: Color(0xFF000000),
              300: Color(0xFF000000),
              400: Color(0xFF000000),
              500: Color(0xFF000000),
              600: Color(0xFF000000),
              700: Color(0xFF000000),
              800: Color(0xFF000000),
              900: Color(0xFF000000),
            },
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Github search"),
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Github username',
                    suffixIcon: IconButton(
                      onPressed: _clear,
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onSubmitted: _searchGithub,
                  onChanged: _searchGithub,
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  color: Colors.black12,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: () {
                    if (_username.isEmpty) return Text("Insert a user name");
                    return SizedBox(
                        height: 300.0,
                        child: FutureBuilder<GithubUserList>(
                            future: _response,
                            builder: (context, user) {
                              if (user.hasData) {
                                if (user.data.githubUserList.first
                                    .isTemplateUser) {
                                  return ListView.builder(
                                      itemCount: user.data.totalCount,
                                      itemBuilder: (context, index) {
                                        print("index $index");
                                        return buildUserCard(
                                            avatarUrl:
                                            "https://avatars.githubusercontent.com/u/1024025?v=4",
                                            login: "dollynho");
                                      });
                                } else {
                                  // TODO go back to the top of the list when textfield is edited
                                  return ListView.builder(
                                      itemCount: user.data.totalCount,
                                      itemBuilder: (context, index) {
                                        print("index $index");
                                        print("total ${user.data.totalCount}");
                                        return buildUserCard(
                                            avatarUrl:
                                            user.data.githubUserList
                                                .elementAt(index)
                                                .avatarUrl,
                                            login: user.data.githubUserList
                                                .elementAt(index)
                                                .login);
                                        //   ListTile(
                                        //   title: Text(
                                        //       user.data.githubUserList.first.login),
                                        // );
                                      });
                                }
                              } else if (user.hasError) {
                                return Column(
                                    children: [Text("Error. User not found!")]);
                              }
                              return CircularProgressIndicator();
                            })
                    );
                  }()),
            ],
          ),
        ));
  }
}
