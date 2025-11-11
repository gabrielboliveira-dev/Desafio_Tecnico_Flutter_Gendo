import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/repo_model.dart';

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

abstract class GithubApiDataSource {
  Future<List<RepoModel>> getRepos(String username);
  Future<List<RepoModel>> getStarredRepos(String username);
}

class GithubApiDataSourceImpl implements GithubApiDataSource {
  final http.Client client;
  final String _baseUrl = "https://api.github.com/users/";

  GithubApiDataSourceImpl({required this.client});

  @override
  Future<List<RepoModel>> getRepos(String username) async {
    final response = await client.get(
      Uri.parse('$_baseUrl$username/repos'),
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((json) => RepoModel.fromJson(json)).toList();
    } else {
      throw ServerException('Falha ao buscar repositórios. Código: ${response.statusCode}');
    }
  }

  @override
  Future<List<RepoModel>> getStarredRepos(String username) async {
    final response = await client.get(
      Uri.parse('$_baseUrl$username/starred'),
      headers: {'Accept': 'application/vnd.github.v3+json'},
    );

    if (response.statusCode == 200) {
      final List jsonList = json.decode(response.body);
      return jsonList.map((json) => RepoModel.fromJson(json)).toList();
    } else {
      throw ServerException('Falha ao buscar favoritos. Código: ${response.statusCode}');
    }
  }
}