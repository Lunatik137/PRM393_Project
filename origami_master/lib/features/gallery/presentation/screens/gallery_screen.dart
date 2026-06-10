import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/creation_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/creation_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../models/user_creation.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  List<UserCreation> _allCreations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCreations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCreations() async {
    final creations = await CreationService.instance.getCreations();
    if (mounted) {
      setState(() {
        _allCreations = creations;
        _isLoading = false;
      });
    }
  }

  List<UserCreation> get _filteredCreations {
    return _allCreations.where((creation) {
      final matchesSearch = creation.foldName.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      bool matchesFilter = true;
      if (_selectedFilter == 'Public') {
        matchesFilter = creation.isPublic;
      } else if (_selectedFilter == 'Private') {
        matchesFilter = !creation.isPublic;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'My Gallery'),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: SearchBar(
                controller: _searchController,
                hintText: 'Search by fold name...',
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

            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                scrollDirection: Axis.horizontal,
                children: ['All', 'Public', 'Private'].map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedFilter = filter;
                          });
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: AppSpacing.md),

            // Grid
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    final filtered = _filteredCreations;

    if (filtered.isEmpty) {
      return const EmptyState(
        title: 'No creations found',
        message:
            'Your gallery is looking a bit empty. Start learning and create your first masterpiece!',
        icon: Icons.photo_library_outlined,
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.85,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final creation = filtered[index];
        return CreationCard(
          foldName: creation.foldName,
          imagePath: creation.imagePath,
          isPublic: creation.isPublic,
          completedAt: creation.completedAt,
          onTap: () => context.pushNamed(
            RouteNames.creationDetail,
            pathParameters: {'creationId': creation.id},
          ),
        );
      },
    );
  }
}
