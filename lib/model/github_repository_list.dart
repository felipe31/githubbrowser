import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_browser/controller/github_api.dart';
import 'package:github_browser/model/github_repository.dart';
import 'package:github_browser/model/github_user.dart';

class GithubReposList {
  List<GithubRepository> _githubRepoList;

  List<GithubRepository> get githubRepoList => _githubRepoList;

  GithubReposList(this._githubRepoList);

  static Future<GithubReposList> fetchRepos(String url,
      {bool debug = false}) async {
    if (url.isEmpty) throw null;
    if (debug) {
      return GithubReposList([GithubRepository(isRepoNotFound: true), GithubRepository(isRepoNotFound: true)]);
    }
    try {
      final futureList = GithubApi.fetchRepoList(url);
      return futureList.then((List<dynamic> jsonList) {
        print("->>>>>> ${jsonList.length}");
        if(jsonList.length == 0) {
          print("Repos not found");
          return GithubReposList([GithubRepository(isRepoNotFound: true)]);
        }
        List<GithubRepository> repos = <GithubRepository>[];
        jsonList.forEach((element) {
          repos.add(GithubRepository.fromJson(element));
        });
        return  GithubReposList(repos);
      }).catchError(
        (err) {
          print('Caught $err');
          return GithubReposList([GithubRepository(isRepoNotFound: true)]);
        },
      );
    } catch (e) {
      if (e == 403 && e == 404) {
        return GithubReposList([GithubRepository(isRepoNotFound: true)]);
      }
    }
    return GithubReposList([GithubRepository(isRepoNotFound: true)]);
  }
}
