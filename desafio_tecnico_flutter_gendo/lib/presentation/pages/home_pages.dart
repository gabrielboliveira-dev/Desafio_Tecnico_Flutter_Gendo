import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/repo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TextEditingController _usernameController;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Repo Viewer'),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildSearchArea(context),
          
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, provider, child) {
                
                switch (provider.state) {
                  case ViewState.loading:
                    return Center(child: CircularProgressIndicator());
                    
                  case ViewState.error:
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          provider.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    
                  case ViewState.success:
                    return _buildTabBarView(provider);
                    
                  case ViewState.initial:
                  default:
                    return Center(
                      child: Text('Digite um utilizador do GitHub para começar.'),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Utilizador do GitHub',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) { 
                 _onSearchPressed(context);
              },
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => _onSearchPressed(context),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            child: Text('Buscar'),
          ),
        ],
      ),
    );
  }
  
  void _onSearchPressed(BuildContext context) {
    final provider = context.read<HomeProvider>();
    provider.fetchUserRepos(_usernameController.text);
    
    FocusScope.of(context).unfocus(); 
  }

  Widget _buildTabBarView(HomeProvider provider) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.blueGrey[900],
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueGrey[900],
          tabs: [
            Tab(text: 'REPOSITÓRIOS (${provider.repos.length})'),
            Tab(text: 'FAVORITOS (${provider.starredRepos.length})'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              RepoListWidget(repos: provider.repos),
              
              RepoListWidget(repos: provider.starredRepos),
            ],
          ),
        ),
      ],
    );
  }
}