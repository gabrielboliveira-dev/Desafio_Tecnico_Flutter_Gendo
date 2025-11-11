import 'package:flutter/material.dart';
import '../../domain/entities/repo_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoListWidget extends StatelessWidget {
  final List<RepoEntity> repos;

  const RepoListWidget({super.key, required this.repos});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Não foi possível abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (repos.isEmpty) {
      return Center(
        child: Text(
          'Nenhum repositório encontrado.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return ListView.builder(
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return Card( 
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text(repo.name),
            subtitle: Text(
              repo.description,
              maxLines: 2, 
              overflow: TextOverflow.ellipsis, 
            ),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              if (repo.url.isNotEmpty) {
                _launchURL(repo.url);
              }
            },
          ),
        );
      },
    );
  }
}