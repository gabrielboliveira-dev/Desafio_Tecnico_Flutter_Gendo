import '../entities/repo_entity.dart';

abstract class GithubRepository {

  Future<List<RepoEntity>> getRepos(String username);

  Future<List<RepoEntity>> getStarredRepos(String username);
}