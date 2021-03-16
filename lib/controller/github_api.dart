import 'dart:convert';

import 'package:github_browser/model/github_user.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  static Future<GithubUser> fetchUserList(String name) async {
    if (name.isEmpty) throw null;
    http.Response response = await http
        .get(Uri.https('api.github.com', '/search/users', {"q": "$name"}));
    print(Uri.https('api.github.com', '/search/users', {"q": "$name"}));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200)
      return GithubUser.fromJson(jsonDecode(response.body)['items'][0]);
    else if (response.statusCode == 403)
      return GithubUser(isTemplateUser: true);
    else if (response.statusCode == 404)
      return GithubUser(isUserNotFound: true);
    else {
      throw Exception('Failed to load github account! Check the username!');
    }
  }
}
