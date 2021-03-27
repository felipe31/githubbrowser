class GithubRepository   {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final bool private;
  final owner;
  final String htmlUrl;
  final String description;
  final bool fork;
  final String url;
  final String forksUrl;
  final String keysUrl;
  final String collaboratorsUrl;
  final String teamsUrl;
  final String hooksUrl;
  final String issueEventsUrl;
  final String eventsUrl;
  final String assigneesUrl;
  final String branchesUrl;
  final String tagsUrl;
  final String blobsUrl;
  final String gitTagsUrl;
  final String gitRefsUrl;
  final String treesUrl;
  final String statusesUrl;
  final String languagesUrl;
  final String stargazersUrl;
  final String contributorsUrl;
  final String subscribersUrl;
  final String subscriptionUrl;
  final String commitsUrl;
  final String gitCommitsUrl;
  final String commentsUrl;
  final String issueCommentUrl;
  final String contentsUrl;
  final String compareUrl;
  final String mergesUrl;
  final String archiveUrl;
  final String downloadsUrl;
  final String issuesUrl;
  final String pullsUrl;
  final String milestonesUrl;
  final String notificationsUrl;
  final String labelsUrl;
  final String releasesUrl;
  final String deploymentsUrl;
  final String createdAt;
  final String updatedAt;
  final String pushedAt;
  final String gitUrl;
  final String sshUrl;
  final String cloneUrl;
  final String svnUrl;
  final String homepage;
  final int size;
  final int stargazersCount;
  final int watchersCount;
  final String language;
  final bool hasIssues;
  final bool hasProjects;
  final bool hasDownloads;
  final bool hasWiki;
  final bool hasPages;
  final int forksCount;
  final String mirrorUrl;
  final bool archived;
  final bool disabled;
  final int openIssuesCount;
  final license;
  final int forks;
  final int openIssues;
  final int watchers;
  final String defaultBranch;
  final bool isRepoNotFound;

  GithubRepository({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.private,
    this.owner,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.forksUrl,
    this.keysUrl,
    this.collaboratorsUrl,
    this.teamsUrl,
    this.hooksUrl,
    this.issueEventsUrl,
    this.eventsUrl,
    this.assigneesUrl,
    this.branchesUrl,
    this.tagsUrl,
    this.blobsUrl,
    this.gitTagsUrl,
    this.gitRefsUrl,
    this.treesUrl,
    this.statusesUrl,
    this.languagesUrl,
    this.stargazersUrl,
    this.contributorsUrl,
    this.subscribersUrl,
    this.subscriptionUrl,
    this.commitsUrl,
    this.gitCommitsUrl,
    this.commentsUrl,
    this.issueCommentUrl,
    this.contentsUrl,
    this.compareUrl,
    this.mergesUrl,
    this.archiveUrl,
    this.downloadsUrl,
    this.issuesUrl,
    this.pullsUrl,
    this.milestonesUrl,
    this.notificationsUrl,
    this.labelsUrl,
    this.releasesUrl,
    this.deploymentsUrl,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.svnUrl,
    this.homepage,
    this.size,
    this.stargazersCount,
    this.watchersCount,
    this.language,
    this.hasIssues,
    this.hasProjects,
    this.hasDownloads,
    this.hasWiki,
    this.hasPages,
    this.forksCount,
    this.mirrorUrl,
    this.archived,
    this.disabled,
    this.openIssuesCount,
    this.license,
    this.forks,
    this.openIssues,
    this.watchers,
    this.defaultBranch,
    this.isRepoNotFound = false
  });

  factory GithubRepository.fromJson(Map<String, dynamic> json) {
    return GithubRepository(
        id: json['id'],
        nodeId: json['nodeId'],
        name: json['name'],
        fullName: json['fullName'],
        private: json['private'],
        owner: json['owner'],
        htmlUrl: json['htmlUrl'],
        description: json['description'],
        fork: json['fork'],
        url: json['url'],
        forksUrl: json['forksUrl'],
        keysUrl: json['keysUrl'],
        collaboratorsUrl: json['collaboratorsUrl'],
        teamsUrl: json['teamsUrl'],
        hooksUrl: json['hooksUrl'],
        issueEventsUrl: json['issueEventsUrl'],
        eventsUrl: json['eventsUrl'],
        assigneesUrl: json['assigneesUrl'],
        branchesUrl: json['branchesUrl'],
        tagsUrl: json['tagsUrl'],
        blobsUrl: json['blobsUrl'],
        gitTagsUrl: json['gitTagsUrl'],
        gitRefsUrl: json['gitRefsUrl'],
        treesUrl: json['treesUrl'],
        statusesUrl: json['statusesUrl'],
        languagesUrl: json['languagesUrl'],
        stargazersUrl: json['stargazersUrl'],
        contributorsUrl: json['contributorsUrl'],
        subscribersUrl: json['subscribersUrl'],
        subscriptionUrl: json['subscriptionUrl'],
        commitsUrl: json['commitsUrl'],
        gitCommitsUrl: json['gitCommitsUrl'],
        commentsUrl: json['commentsUrl'],
        issueCommentUrl: json['issueCommentUrl'],
        contentsUrl: json['contentsUrl'],
        compareUrl: json['compareUrl'],
        mergesUrl: json['mergesUrl'],
        archiveUrl: json['archiveUrl'],
        downloadsUrl: json['downloadsUrl'],
        issuesUrl: json['issuesUrl'],
        pullsUrl: json['pullsUrl'],
        milestonesUrl: json['milestonesUrl'],
        notificationsUrl: json['notificationsUrl'],
        labelsUrl: json['labelsUrl'],
        releasesUrl: json['releasesUrl'],
        deploymentsUrl: json['deploymentsUrl'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        pushedAt: json['pushedAt'],
        gitUrl: json['gitUrl'],
        sshUrl: json['sshUrl'],
        cloneUrl: json['cloneUrl'],
        svnUrl: json['svnUrl'],
        homepage: json['homepage'],
        size: json['size'],
        stargazersCount: json['stargazersCount'],
        watchersCount: json['watchersCount'],
        language: json['language'],
        hasIssues: json['hasIssues'],
        hasProjects: json['hasProjects'],
        hasDownloads: json['hasDownloads'],
        hasWiki: json['hasWiki'],
        hasPages: json['hasPages'],
        forksCount: json['forksCount'],
        mirrorUrl: json['mirrorUrl'],
        archived: json['archived'],
        disabled: json['disabled'],
        openIssuesCount: json['openIssuesCount'],
        license: json['license'],
        forks: json['forks'],
        openIssues: json['openIssues'],
        watchers: json['watchers'],
        defaultBranch: json['defaultBranch']
    );
  }
}