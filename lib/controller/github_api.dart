import 'dart:convert';

import 'package:github_browser/model/github_user.dart';
import 'package:http/http.dart' as http;

class GithubApi {
  static Future<Map<String, dynamic>> fetchUserList(String name) async {
    if (name.isEmpty) throw null;
    http.Response response = await http
        .get(Uri.https('api.github.com', '/search/users', {"q": "$name"}));
    print(Uri.https('api.github.com', '/search/users', {"q": "$name"}));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200)
      return jsonDecode(response.body);
    else if (response.statusCode == 403)
      throw 403;
    else if (response.statusCode == 404)
      throw 404;
    else {
      throw Exception('Failed to load github account! Check the username!');
    }
  }

  static Future<List<dynamic>> fetchRepoList(String url) async {
    if (url.isEmpty) throw null;
    http.Response response = await http
        .get(Uri.parse(url));
    print(Uri.parse(url));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200)
      return jsonDecode(response.body);
    else if (response.statusCode == 403)
      throw 403;
    else if (response.statusCode == 404)
      throw 404;
    else {
      throw Exception('Failed to load github account! Check the username!');
    }
  }
}