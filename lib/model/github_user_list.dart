import 'package:github_browser/controller/github_api.dart';
import 'package:github_browser/model/github_user.dart';

class GithubUserList {
  List<GithubUser> _githubUserList;

  List<GithubUser> get githubUserList => _githubUserList;

  GithubUserList(this._githubUserList);

  static Future<GithubUserList> fetchUsers(String name, {bool debug}) async {
    if (name.isEmpty) throw null;
    if (debug) {
      return GithubUserList([GithubUser(isTemplateUser: true)]);
    }

    return GithubUserList([GithubUser(isTemplateUser: true)]);
  }
}
