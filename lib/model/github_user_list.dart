import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_browser/controller/github_api.dart';
import 'package:github_browser/model/github_user.dart';

class GithubUserList {
  List<GithubUser> _githubUserList;
  final int totalCount;

  List<GithubUser> get githubUserList => _githubUserList;
  int get length => totalCount;

  GithubUserList(this._githubUserList, this.totalCount);

  static Future<GithubUserList> fetchUsers(String name,
      {bool debug = false}) async {
    if (name.isEmpty) throw null;
    if (debug) {
      return GithubUserList([GithubUser(isTemplateUser: true), GithubUser(isTemplateUser: true)], 2);
    }
    GithubUser usr = GithubUser(isTemplateUser: true);

    try {
      final json = GithubApi.fetchUserList(name);

      return json.then((Map<String, dynamic> json) {
        print("->>>>>> ${json["total_count"]}");
        if(json["total_count"] == 0) {
          print("user not found");
          return GithubUserList([GithubUser(isUserNotFound: true)], 1);
        }
        List<dynamic> list = json["items"];
        List<GithubUser> users = <GithubUser>[];
        int count = 0;
        list.forEach((element) {
          count++;
          users.add(GithubUser.fromJson(element));
        });
        return  GithubUserList(users, count);
      }).catchError(
        (err) {
          print('Caught $err');
          return GithubUserList([GithubUser(isUserNotFound: true)], 1);
        },
      );

    } catch (e) {
      if (e == 403) {
        return GithubUserList([GithubUser(isTemplateUser: true)], 1);
      } else if (e == 404) {
        return GithubUserList([GithubUser(isUserNotFound: true)], 1);
      }
    }

    return GithubUserList([GithubUser(isTemplateUser: true)], 1);
  }
}
