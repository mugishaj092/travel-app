import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../models/destination.dart';
import '../data/travel_data.dart';
import '../widgets/destination_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/destination_list_tile.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  final Set<String> favorites;
  final Function(String) onFavoriteToggle;

  const HomeScreen({super.key, required this.favorites, required this.onFavoriteToggle});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = '1';

  List<Destination> get _filtered {
    if (_selectedCategory == '1') return destinations;
    final cat = categories.firstWhere((c) => c.id == _selectedCategory);
    return destinations.where((d) => d.category == cat.name).toList();
  }

  void _goToDetail(Destination d) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => DetailScreen(
          destination: d,
          isFavorite: widget.favorites.contains(d.id),
          onFavoriteToggle: () => widget.onFavoriteToggle(d.id),
        ),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildSearchBar()),
          SliverToBoxAdapter(child: _buildCategories()),
          SliverToBoxAdapter(child: _buildFeaturedSection()),
          SliverToBoxAdapter(child: _buildPopularHeader()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  final d = _filtered[i];
                  return DestinationListTile(
                    destination: d,
                    isFavorite: widget.favorites.contains(d.id),
                    onFavoriteToggle: () => widget.onFavoriteToggle(d.id),
                    onTap: () => _goToDetail(d),
                  );
                },
                childCount: _filtered.length,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      floating: true,
      backgroundColor: AppTheme.background,
      expandedHeight: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
                ],
              ),
              child: const Icon(Icons.menu_rounded, color: AppTheme.textPrimary, size: 22),
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Explore', style: TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                Row(
                  children: const [
                    Icon(Icons.location_on_rounded, color: AppTheme.primary, size: 14),
                    SizedBox(width: 2),
                    Text(
                      'Worldwide',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 21,
              backgroundColor: AppTheme.primary.withOpacity(0.15),
              child: const Text('JD', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 16, offset: const Offset(0, 4)),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search destinations...',
                  hintStyle: TextStyle(color: AppTheme.textLight, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textLight),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: AppTheme.primary.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: categories.length,
        itemBuilder: (_, i) {
          final cat = categories[i];
          return CategoryChip(
            label: cat.name,
            icon: cat.icon,
            isSelected: _selectedCategory == cat.id,
            onTap: () => setState(() => _selectedCategory = cat.id),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
              ),
              Text('See all', style: TextStyle(fontSize: 14, color: AppTheme.primary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: destinations.take(5).length,
            itemBuilder: (_, i) {
              final d = destinations[i];
              return DestinationCard(
                destination: d,
                isFavorite: widget.favorites.contains(d.id),
                onFavoriteToggle: () => widget.onFavoriteToggle(d.id),
                onTap: () => _goToDetail(d),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPopularHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Popular',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
          ),
          Text('See all', style: TextStyle(fontSize: 14, color: AppTheme.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
