import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_browser/model/github_repository.dart';
import 'package:github_browser/model/github_repository_list.dart';
import 'package:github_browser/model/github_user.dart';
import 'package:url_launcher/url_launcher.dart';

class UsersRepos extends StatelessWidget {
  final GithubUser user;
  Future<GithubReposList> _response;

  UsersRepos(this.user) {
    this._response = GithubReposList.fetchRepos(user.reposUrl);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
                title: Text(user.login),
                background: Container(
                    decoration: BoxDecoration(
                  // color: const Color(0x00e1e1e1),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: NetworkImage(
                        user.avatarUrl,
                      )),
                ))),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Expanded(child: () {
                  return FutureBuilder<GithubReposList>(
                      future: _response,
                      builder: (context, repos) {
                        if (repos.hasData &&
                            repos.data.githubRepoList.length > 0) {
                          // new List<GithubRepository>.from(dynamic.data);
                          return ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(),
                              itemCount: repos.data.githubRepoList.length,
                              itemBuilder: (context, index) {
                                print("index $index");
                                if (index == 0 ||
                                    index ==
                                        repos.data.githubRepoList.length + 1)
                                  return const SizedBox.shrink();
                                return buildRepoCard(
                                    repos.data.githubRepoList.elementAt(index));
                              });
                        } else if (repos.hasError) {
                          return Column(children: [Text("Error. Try again!")]);
                        }
                        return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRepoCard(GithubRepository repo) {
    return GestureDetector(
        onTap: () => launch(repo.htmlUrl),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            height: 55,
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
