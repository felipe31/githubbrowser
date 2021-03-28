import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:github_browser/model/github_repository.dart';
import 'package:github_browser/model/github_repository_list.dart';
import 'package:github_browser/model/github_user.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersRepos extends StatelessWidget {
  final GithubUser user;
  Future<GithubReposList> _response;

  UsersRepos(this.user) {
    this._response = GithubReposList.fetchRepos(user.reposUrl);
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
          return FutureBuilder<GithubReposList>(
              future: _response,
              builder: (context, repos) {
                if (repos.hasData && repos.data.githubRepoList.length > 0) {
                  // new List<GithubRepository>.from(dynamic.data);
                  // TODO go back to the top of the list when textfield is edited
                  return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: repos.data.githubRepoList.length,
                      itemBuilder: (context, index) {
                        print("index $index");
                        return buildRepoCard(
                            repos.data.githubRepoList.elementAt(index));
                      });
                } else if (repos.hasError) {
                  return Column(children: [Text("Error. Try again!")]);
                }
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator()));
                    });
              });
        }()),
      ]),
    );
  }

  Widget buildRepoCard(GithubRepository repo) {
    return GestureDetector(
        onTap: () => launch(repo.htmlUrl),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            height: 50,
            child: Row(children: [
              Expanded(
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      repo.name,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 6),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: () {
                        return repo.description == null
                            ? Text("")
                            : Text(
                                repo.description,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              );
                      }(),
                    ),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(right: 10, left: 20),
                // TODO add list of languages
                child: () {
                  return repo.language == null
                      ? Text("")
                      : Text(
                          repo.language,
                          style: TextStyle(color: Colors.black45),
                        );
                }(),
              ),
            ])));
  }
}
