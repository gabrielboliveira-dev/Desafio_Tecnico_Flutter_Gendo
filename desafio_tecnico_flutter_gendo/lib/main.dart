import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'data/datasources/github_api_datasource.dart';
import 'data/repositories/github_repository_impl.dart';
import 'domain/repositories/github_repository.dart';
import 'presentation/pages/home_pages.dart';
import 'presentation/providers/home_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => http.Client(),
        ),

        Provider<GithubApiDataSource>(
          create: (context) => GithubApiDataSourceImpl(
            client: context.read<http.Client>(),
          ),
        ),

        Provider<GithubRepository>(
          create: (context) => GithubRepositoryImpl(
            dataSource: context.read<GithubApiDataSource>(),
          ),
        ),

        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(
            githubRepository: context.read<GithubRepository>(),
          ),
        ),
      ],
      
      child: MaterialApp(
        title: 'GitHub Repo Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          useMaterial3: true,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}