import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_browser/controller/github_api.dart';
import 'package:github_browser/model/github_repository.dart';
import 'package:github_browser/model/github_user.dart';

class UsersRepos extends StatelessWidget {
  final GithubUser user;
  Future<List<dynamic>> _response;

  UsersRepos(this.user) {
    this._response = GithubApi.fetchRepoList(user.reposUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('@${user.login}'),
      ),
      body: Column(children: [
        // TODO replace the action bar with a picture-login rectangle (a la linkedin)
        Container(
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFFFF),
                border: Border.all(color: Color(0xff838383), width: 1),
                borderRadius: BorderRadius.circular(90)),
            padding: EdgeInsets.all(3),
            margin: EdgeInsets.only(top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90.0),
              child: Image.network(
                user.avatarUrl,
                height: 100,
                width: 100,
              ),
            )),
        Center(
          child: ElevatedButton(
            child: Text(user.login),
            onPressed: () {
              // Navigate to second route when tapped.
            },
          ),
        ),
        Expanded(child: () {
          return FutureBuilder<List<dynamic>>(
              future: _response,
              builder: (context, dynamic) {
                if (dynamic.hasData) {
                    List<GithubRepository> repos = [];
                      dynamic.data.forEach((element) {repos.add(GithubRepository.fromJson(element));});
                    // new List<GithubRepository>.from(dynamic.data);
                     // TODO go back to the top of the list when textfield is edited
                    return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                        itemCount: repos.length,
                        itemBuilder: (context, index) {
                          print("index $index");
                          // print("total ${repos.data}");
                          return buildRepoCard(repos.elementAt(index));
                        });
                } else if (dynamic.hasError) {
                  return Column(children: [Text("Error. Try again!")]);
                }
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: 90,
                              height: 90,
                              child: CircularProgressIndicator()));
                    });
              });
        }()),
      ]),
    );
  }
  Widget buildRepoCard(GithubRepository repo) {
    return Text(repo.name);
  }
}
