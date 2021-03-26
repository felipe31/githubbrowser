import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_browser/model/github_user.dart';

class UsersRepos extends StatelessWidget {
  final GithubUser user;
  UsersRepos(this.user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(user.login),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}
