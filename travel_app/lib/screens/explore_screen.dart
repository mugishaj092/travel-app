import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../models/destination.dart';
import '../data/travel_data.dart';
import '../widgets/category_chip.dart';
import '../widgets/destination_list_tile.dart';
import '../widgets/destination_card.dart';
import 'detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  final Set<String> favorites;
  final Function(String) onFavoriteToggle;

  const ExploreScreen({super.key, required this.favorites, required this.onFavoriteToggle});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedCategory = '1';
  String _sortBy = 'Popular';
  bool _isGridView = false;

  final List<String> _sortOptions = ['Popular', 'Price: Low', 'Price: High', 'Rating'];

  List<Destination> get _filtered {
    List<Destination> list;
    if (_selectedCategory == '1') {
      list = List.from(destinations);
    } else {
      final cat = categories.firstWhere((c) => c.id == _selectedCategory);
      list = destinations.where((d) => d.category == cat.name).toList();
    }
    switch (_sortBy) {
      case 'Price: Low':
        list.sort((a, b) => a.price.compareTo(b.price));
      case 'Price: High':
        list.sort((a, b) => b.price.compareTo(a.price));
      case 'Rating':
        list.sort((a, b) => b.rating.compareTo(a.rating));
      default:
        list.sort((a, b) => b.reviews.compareTo(a.reviews));
    }
    return list;
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
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          SliverToBoxAdapter(child: _buildCategories()),
          SliverToBoxAdapter(child: _buildFilterBar(filtered.length)),
          if (_isGridView)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final d = filtered[i];
                    return DestinationCard(
                      destination: d,
                      isFavorite: widget.favorites.contains(d.id),
                      onFavoriteToggle: () => widget.onFavoriteToggle(d.id),
                      onTap: () => _goToDetail(d),
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) {
                    final d = filtered[i];
                    return DestinationListTile(
                      destination: d,
                      isFavorite: widget.favorites.contains(d.id),
                      onFavoriteToggle: () => widget.onFavoriteToggle(d.id),
                      onTap: () => _goToDetail(d),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF9C8FFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Find your perfect destination',
              style: TextStyle(fontSize: 15, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search any destination...',
                  hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.white70),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      child: SizedBox(
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
      ),
    );
  }

  Widget _buildFilterBar(int count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Row(
        children: [
          Text(
            '$count places found',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortBy,
                isDense: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: AppTheme.primary),
                style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary, fontWeight: FontWeight.w600),
                items: _sortOptions
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) { if (v != null) setState(() => _sortBy = v); },
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => setState(() => _isGridView = !_isGridView),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
              ),
              child: Icon(
                _isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded,
                color: AppTheme.primary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
