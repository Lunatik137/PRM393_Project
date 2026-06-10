import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/origami_card.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../models/origami_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedDifficulty;

  late final List<String> _categories;
  late final List<String> _difficulties;

  @override
  void initState() {
    super.initState();
    _categories = MockData.origamiModels.map((m) => m.category).toSet().toList()
      ..sort();
    _difficulties = ['Easy', 'Medium', 'Hard', 'Expert'];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<OrigamiModel> get _filteredModels {
    return MockData.origamiModels.where((model) {
      final matchesSearch = model.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesCategory =
          _selectedCategory == null || model.category == _selectedCategory;
      final matchesDifficulty =
          _selectedDifficulty == null ||
          model.difficulty == _selectedDifficulty;
      return matchesSearch && matchesCategory && matchesDifficulty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredModels = _filteredModels;

    return Scaffold(
      appBar: AppHeader(
        title: 'Explore',
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _searchController.clear();
                _selectedCategory = null;
                _selectedDifficulty = null;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SearchBar(
                controller: _searchController,
                hintText: 'Search models...',
                leading: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(AppColors.surface),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                ),
              ),
            ),

            // Category Chips
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : null;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            // Difficulty Chips
            SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                scrollDirection: Axis.horizontal,
                itemCount: _difficulties.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final difficulty = _difficulties[index];
                  final isSelected = _selectedDifficulty == difficulty;
                  return ChoiceChip(
                    label: Text(difficulty),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedDifficulty = selected ? difficulty : null;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Grid
            Expanded(
              child: filteredModels.isEmpty
                  ? const EmptyState(
                      title: 'No models found',
                      message: 'Try adjusting your filters or search query.',
                      icon: Icons.search_off,
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: AppSpacing.md,
                            mainAxisSpacing: AppSpacing.md,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: filteredModels.length,
                      itemBuilder: (context, index) {
                        final model = filteredModels[index];
                        return OrigamiCard(
                          name: model.name,
                          category: model.category,
                          difficulty: model.difficulty,
                          imagePath: model.imagePath,
                          onTap: () => context.pushNamed(
                            RouteNames.foldDetail,
                            pathParameters: {'origamiId': model.id},
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
