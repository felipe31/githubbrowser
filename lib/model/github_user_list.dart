import 'dart:convert';

import 'package:github_browser/controller/github_api.dart';
import 'package:github_browser/model/github_user.dart';

class GithubUserList {
  List<GithubUser> _githubUserList;

  List<GithubUser> get githubUserList => _githubUserList;

  GithubUserList(this._githubUserList);

  // factory GithubUserList.fromJson(Map<String, dynamic> json) {
  //   List<GithubUser> users = <GithubUser>[];
  //   json.forEach((key, value) {
  //     users.add(GithubUser())
  //   })
  // }

  static Future<GithubUserList> fetchUsers(String name,
      {bool debug = false}) async {
    if (name.isEmpty) throw null;
    if (debug) {
      return GithubUserList([GithubUser(isTemplateUser: true)]);
    }
    GithubUser usr = GithubUser(isTemplateUser: true);

    try {
      final json = GithubApi.fetchUserList(name);

      return json.then((Map<String, dynamic> json) {
        List<dynamic> list = json["items"];
        List<GithubUser> users = <GithubUser>[];
        list.forEach((element) {
          print(element);
          users.add(GithubUser.fromJson(element));
        });
        usr = users.first;
        return  GithubUserList([usr]);
      }).catchError(
        (err) {
          print('Caught $err');
          return GithubUserList([GithubUser(isUserNotFound: true)]);
        },
      );

    } catch (e) {
      if (e == 403) {
        return GithubUserList([GithubUser(isTemplateUser: true)]);
      } else if (e == 404) {
        return GithubUserList([GithubUser(isUserNotFound: true)]);
      }
    }

    return GithubUserList([GithubUser(isTemplateUser: true)]);
  }
}
