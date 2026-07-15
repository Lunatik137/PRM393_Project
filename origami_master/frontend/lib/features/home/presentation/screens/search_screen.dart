import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/api/search_api.dart';
import '../../data/dto/search_response_dto.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  bool _isLoading = false;
  SearchResponseDto? _searchResults;
  List<String> _searchHistory = [];
  Timer? _debounceTimer;

  static const String _historyKey = 'search_history';

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = prefs.getStringList(_historyKey) ?? [];
    });
  }

  Future<void> _saveHistory(String query) async {
    if (query.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey) ?? [];
    
    // Remove if exists to move to top
    history.remove(query);
    history.insert(0, query);
    
    // Keep only last 10
    if (history.length > 10) {
      history.removeLast();
    }
    
    await prefs.setStringList(_historyKey, history);
    setState(() {
      _searchHistory = history;
    });
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    setState(() {
      _searchHistory = [];
    });
  }
  
  void _removeHistoryItem(String item) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey) ?? [];
    history.remove(item);
    await prefs.setStringList(_historyKey, history);
    setState(() {
      _searchHistory = history;
    });
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    final query = _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _searchResults = null;
        _isLoading = false;
      });
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;
    
    setState(() => _isLoading = true);
    try {
      final api = getIt<SearchApi>();
      final results = await api.search(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _submitSearch(String query) {
    if (query.trim().isEmpty) return;
    
    _searchController.text = query;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: query.length),
    );
    _focusNode.unfocus();
    _saveHistory(query);
    _performSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: const BackButton(color: AppColors.textPrimary),
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onSubmitted: _submitSearch,
            decoration: InputDecoration(
              hintText: 'Search users, posts, or #hashtags',
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide.none,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        _searchController.clear();
                        _focusNode.requestFocus();
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_searchController.text.isEmpty) {
      return _buildHistory();
    }
    
    if (_isLoading && _searchResults == null) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_searchResults != null) {
      return _buildResults();
    }
    
    return const SizedBox.shrink();
  }

  Widget _buildHistory() {
    if (_searchHistory.isEmpty) {
      return const Center(
        child: Text('No recent searches', style: AppTextStyles.body),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Recent', style: AppTextStyles.sectionTitle),
            TextButton(
              onPressed: _clearHistory,
              child: const Text('Clear All'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ..._searchHistory.map((item) => ListTile(
          leading: const Icon(Icons.history, color: AppColors.textSecondary),
          title: Text(item, style: AppTextStyles.body),
          trailing: IconButton(
            icon: const Icon(Icons.close, size: 16, color: AppColors.textSecondary),
            onPressed: () => _removeHistoryItem(item),
          ),
          onTap: () => _submitSearch(item),
        )),
      ],
    );
  }

  Widget _buildResults() {
    final users = _searchResults?.users ?? [];
    final posts = _searchResults?.posts ?? [];
    final hashtags = _searchResults?.hashtags ?? [];
    
    if (users.isEmpty && posts.isEmpty && hashtags.isEmpty) {
      return const Center(
        child: Text('No results found', style: AppTextStyles.body),
      );
    }
    
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      children: [
        if (users.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text('Users', style: AppTextStyles.sectionTitle),
          ),
          ...users.map((user) => ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.surfaceMuted,
              backgroundImage: user.avatarUrl != null ? CachedNetworkImageProvider(user.avatarUrl!) : null,
              child: user.avatarUrl == null ? const Icon(Icons.person, color: AppColors.textDisabled) : null,
            ),
            title: Text(user.username, style: AppTextStyles.labelLarge),
            subtitle: Text('${user.followersCount} followers', style: AppTextStyles.caption),
            onTap: () {
               _saveHistory(_searchController.text);
               context.pushNamed(RouteNames.userProfile, pathParameters: {'userId': user.id});
            },
          )),
          const Divider(),
        ],
        
        if (hashtags.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text('Hashtags', style: AppTextStyles.sectionTitle),
          ),
          ...hashtags.map((tag) => ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.surfaceMuted,
              child: Icon(Icons.tag, color: AppColors.textPrimary),
            ),
            title: Text(tag.name, style: AppTextStyles.labelLarge),
            subtitle: Text('${tag.postCount} ${tag.postCount == 1 ? 'post' : 'posts'}', style: AppTextStyles.caption),
            onTap: () => _submitSearch(tag.name),
          )),
          const Divider(),
        ],
        
        if (posts.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text('Posts', style: AppTextStyles.sectionTitle),
          ),
          ...posts.map((post) => ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(8),
              ),
              child: post.imageUrl != null 
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: post.imageUrl!, 
                        fit: BoxFit.cover
                      ),
                    )
                  : const Icon(Icons.image, color: AppColors.textDisabled),
            ),
            title: Text(post.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.labelLarge),
            subtitle: Text('by ${post.creatorName}', style: AppTextStyles.caption),
            onTap: () {
               _saveHistory(_searchController.text);
               context.pushNamed(RouteNames.postDetail, pathParameters: {'postId': post.id});
            },
          )),
        ],
      ],
    );
  }
}
