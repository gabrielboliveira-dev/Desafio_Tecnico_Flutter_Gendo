import '../../domain/entities/repo_entity.dart';

class RepoModel extends RepoEntity {
  RepoModel({
    required super.name,
    required super.description,
    required super.url,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'] ?? 'Sem Nome', 
      description: json['description'] ?? 'Sem Descrição', 
      url: json['html_url'] ?? '',
    );
  }

   factory RepoModel.fromEntity(RepoEntity entity) {
     return RepoModel(
       name: entity.name,
       description: entity.description,
       url: entity.url,
     );
   }
}