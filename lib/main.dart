import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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

class GithubUser {
  final String login;
  final int id;
  final String node_id;
  final String avatar_url;
  final String gravatar_id;
  final String url;
  final String html_url;
  final String followers_url;
  final String following_url;
  final String gists_url;
  final String starred_url;
  final String subscriptions_url;
  final String organizations_url;
  final String repos_url;
  final String events_url;
  final String received_events_url;
  final String type;
  final bool site_admin;
  final String name;
  final String company;
  final String blog;
  final String location;
  final String email;
  final bool hireable;
  final String bio;
  final String twitter_username;
  final int public_repos;
  final int public_gists;
  final int followers;
  final int following;
  final String created_at;
  final String updated_at;

  GithubUser(
      {this.login,
      this.id,
      this.node_id,
      this.avatar_url,
      this.gravatar_id,
      this.url,
      this.html_url,
      this.followers_url,
      this.following_url,
      this.gists_url,
      this.starred_url,
      this.subscriptions_url,
      this.organizations_url,
      this.repos_url,
      this.events_url,
      this.received_events_url,
      this.type,
      this.site_admin,
      this.name,
      this.company,
      this.blog,
      this.location,
      this.email,
      this.hireable,
      this.bio,
      this.twitter_username,
      this.public_repos,
      this.public_gists,
      this.followers,
      this.following,
      this.created_at,
      this.updated_at});

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
        login: json['login'],
        id: json['id'],
        node_id: json['node_id'],
        avatar_url: json['avatar_url'],
        gravatar_id: json['gravatar_id'],
        url: json['url'],
        html_url: json['html_url'],
        followers_url: json['followers_url'],
        following_url: json['following_url'],
        gists_url: json['gists_url'],
        starred_url: json['starred_url'],
        subscriptions_url: json['subscriptions_url'],
        organizations_url: json['organizations_url'],
        repos_url: json['repos_url'],
        events_url: json['events_url'],
        received_events_url: json['received_events_url'],
        type: json['type'],
        site_admin: json['site_admin'],
        name: json['name'],
        company: json['company'],
        blog: json['blog'],
        location: json['location'],
        email: json['email'],
        hireable: json['hireable'],
        bio: json['bio'],
        twitter_username: json['twitter_username'],
        public_repos: json['public_repos'],
        public_gists: json['public_gists'],
        followers: json['followers'],
        following: json['following'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String username;
  Future<GithubUser> response;

  void __searchGithub() {
    Toast.show("Write username and press enter", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  void _searchGithub(String name) {
    setState(() {
      response = fetchUser(name);
      this.username = name;
      //   // This call to setState tells the Flutter framework that something has
      //   // changed in this State, which causes it to rerun the build method below
      //   // so that the display can reflect the updated values. If we changed
      //   // _counter without calling setState(), then the build method would not be
      //   // called again, and so nothing would appear to happen.
    });
  }

  //
  // Widget _getGithubString(String username) {
  //   try {
  //     response = fetchUser();
  //   } catch (e) {}
  //   return
  // }

  Future<GithubUser> fetchUser(String name) async {
    if (name.isEmpty) throw null;
    http.Response response =
        await http.get(Uri.https('api.github.com', '/users/$name'));
    print(response.body);
    if (response.statusCode == 200)
      return GithubUser.fromJson(jsonDecode(response.body));
    else {
      throw Exception('Failed to load github account! Check the username!');
    }
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Github username'),
                  onSubmitted: _searchGithub,
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  color: Colors.black12,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: FutureBuilder<GithubUser>(
                    future: response,
                    builder: (context, user) {
                      if (user.hasData) {
                        return Row(children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child:
                                Image.network(user.data.avatar_url, height: 90),
                          ),
                          Column(
                            children: [
                              Text(user.data.name,
                                  style: TextStyle(fontSize: 20)),
                              Text("@${user.data.login}", style: TextStyle(fontSize: 17, ), textAlign: TextAlign.left),
                            ],
                          ),
                        ]);
                      } else if (user.hasError) {
                        return Column(
                            children: [Text("Error. User not found!")]);
                      }
                      return CircularProgressIndicator();
                    },
                  )),
            ],
          ),
        ));
  }
}
