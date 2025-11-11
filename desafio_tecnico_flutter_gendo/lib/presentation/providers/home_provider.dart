import 'package:flutter/material.dart';
import '../../domain/entities/repo_entity.dart';
import '../../domain/repositories/github_repository.dart';

enum ViewState { initial, loading, success, error }

class HomeProvider extends ChangeNotifier {
  
  final GithubRepository githubRepository;

  HomeProvider({required this.githubRepository});

  ViewState _state = ViewState.initial;
  String _errorMessage = '';
  List<RepoEntity> _repos = [];
  List<RepoEntity> _starredRepos = [];

  ViewState get state => _state;
  String get errorMessage => _errorMessage;
  List<RepoEntity> get repos => _repos;
  List<RepoEntity> get starredRepos => _starredRepos;

  Future<void> fetchUserRepos(String username) async {
    if (username.isEmpty) {
      _state = ViewState.error;
      _errorMessage = 'Por favor, insira um nome de utilizador.';
      notifyListeners();
      return;
    }

    _state = ViewState.loading;
    notifyListeners();

    try {
      final results = await Future.wait([
        githubRepository.getRepos(username),
        githubRepository.getStarredRepos(username),
      ]);

      _repos = results[0];
      _starredRepos = results[1];
      _state = ViewState.success;
      
    } catch (e) {
      _state = ViewState.error;
      _errorMessage = 'Erro ao buscar dados: ${e.toString()}';
    }

    notifyListeners();
  }
}