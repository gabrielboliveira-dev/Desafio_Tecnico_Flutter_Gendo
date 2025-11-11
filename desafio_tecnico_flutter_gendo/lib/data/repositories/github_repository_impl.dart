import '../../domain/entities/repo_entity.dart';
import '../../domain/repositories/github_repository.dart';
import '../datasources/github_api_datasource.dart';

class GithubRepositoryImpl implements GithubRepository {
  
  final GithubApiDataSource dataSource;

  GithubRepositoryImpl({required this.dataSource});

  @override
  Future<List<RepoEntity>> getRepos(String username) async {
    try {
      final repoModels = await dataSource.getRepos(username);
      
      final List<RepoEntity> repoEntities = repoModels;
      
      return repoEntities;

    } on ServerException catch (e) {
      throw Exception(e.message); 
    }
  }

  @override
  Future<List<RepoEntity>> getStarredRepos(String username) async {
    try {
      final repoModels = await dataSource.getStarredRepos(username);
      final List<RepoEntity> repoEntities = repoModels;
      return repoEntities;
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }
}