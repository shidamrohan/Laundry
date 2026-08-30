import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int _activeFilter = 0;

  final List<String> _filters = ['All', 'Category', 'Price', 'Type'];

  final List<String> _recentSearches = ['Wash & Fold', 'Shoes cleaning', 'Curtains'];

  final List<String> _trending = [
    'Dry Cleaning',
    'Express Wash',
    'Ironing',
    'Blanket Cleaning',
    'Premium Care',
    'Steam Iron',
  ];

  final List<Map<String, dynamic>> _suggestions = [
    {
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLvtAMNhCqH_0_mSCF7ZvkZu3yOB3ZJGVeTJp5pyRf_XHlNnzwh7RnFbTgqa-_pFdd8HA4XUKn9xQgC4qfKuxr1PzvKXkpEEsD4CA3yixvhuo0-22tRSx6ZVLt-1KDu-Qoi54elIFhg2fXhLB-ZAavJ8SJuscE1ZZFm4stWQHW_fPZLSKWTcI7Ju094iT6QoR7hQerU0JJk53VEKmEYTDbPqdPh06PQYGlNglSiUejQcJLVElZ-tt5ASF18',
      'title': 'Premium',
      'highlight': 'Dry Cleaning',
      'subtitle': 'From ₹99 · 24h turnaround',
      'icon': null,
    },
    {
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLvmEpIbGuOP2q2pTZaziFD-8_S2fxHsdFMrAEMGhpu7wlmCWfeO5ZvOmzUSrYmJALjSDmCEH_6x9_-qEXaf__dERD7TziiUJ0uRG7DBdJJaj5fxEiIlLZK_oQT2-R9whuyAOiJG1P62dFTsmwSJR5kr2fxZL-UWP3aK-_VT9nf2228ckz0hC9y6sf1gwvP8q3yCcYutGlGxWe9vFxv1_KTyn630DaJFayytt5fhxWbfADeMdhG8EDF4VdGp',
      'title': 'Eco-Friendly',
      'highlight': 'Dry Cleaning',
      'subtitle': 'From ₹149 · Gentle on fabrics',
      'icon': null,
    },
    {
      'image': null,
      'title': 'Express',
      'highlight': 'Dry Cleaning',
      'subtitle': 'From ₹199 · Ready in 6 hours',
      'icon': Icons.bolt,
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.text = '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          // ── FIXED HEADER ──
          Container(
            color: const Color(0xFFF7FAFB).withValues(alpha: 0.95),
            padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 12),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4), size: 24),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Search Services',
                  style: TextStyle(
                    color: Color(0xFF0EA5A4),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          // ── SCROLLABLE BODY ──
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, bottomPadding + 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── SEARCH FIELD ──
                    _buildSearchField(),
                    const SizedBox(height: 6),
                    const Center(
                      child: Text(
                        'Try saying "Dry clean my silk shirt"',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── FILTER CHIPS ──
                    _buildFilterRow(),
                    const SizedBox(height: 28),

                    // ── RECENT SEARCHES ──
                    _buildSectionLabel('Recent searches'),
                    const SizedBox(height: 12),
                    _buildRecentSearches(),
                    const SizedBox(height: 28),

                    // ── TRENDING ──
                    _buildSectionLabel('Trending services'),
                    const SizedBox(height: 12),
                    _buildTrendingGrid(),
                    const SizedBox(height: 28),

                    // ── SUGGESTIONS ──
                    _buildSectionLabel('Suggestions'),
                    const SizedBox(height: 12),
                    _buildSuggestions(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────── WIDGETS ────────────────────────────

  Widget _buildSearchField() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9)),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.search, color: Color(0xFF64748B), size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15),
              cursorColor: const Color(0xFF0EA5A4),
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for services…',
                hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 15),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          // Clear button
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {});
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.close, color: Color(0xFF64748B), size: 20),
              ),
            ),
          // Divider
          Container(width: 1, height: 24, color: const Color(0xFFE2E8E9)),
          // Mic button
          GestureDetector(
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.mic_outlined, color: Color(0xFF0EA5A4), size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_filters.length, (i) {
          final isActive = _activeFilter == i;
          return GestureDetector(
            onTap: () => setState(() => _activeFilter = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isActive
                    ? [BoxShadow(color: const Color(0xFF0EA5A4).withValues(alpha: 0.25), blurRadius: 8)]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _filters[i],
                    style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFF64748B),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (i != 0) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down,
                        size: 16, color: isActive ? Colors.white : const Color(0xFF64748B)),
                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        color: Color(0xFF64748B),
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_recentSearches.length, (i) {
        return Container(
          padding: const EdgeInsets.fromLTRB(10, 8, 6, 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8E9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.history, color: Color(0xFF64748B), size: 14),
              const SizedBox(width: 6),
              Text(
                _recentSearches[i],
                style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () => setState(() => _recentSearches.removeAt(i)),
                child: const Icon(Icons.close, color: Color(0xFF64748B), size: 14),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTrendingGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3.2,
      ),
      itemCount: _trending.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            _searchController.text = _trending[i];
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _trending[i],
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.trending_up, color: Color(0xFF0EA5A4), size: 18),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuggestions() {
    List<Map<String, dynamic>> filtered = _suggestions.where((s) {
      final query = _searchController.text.toLowerCase();
      final text = '${s['title']} ${s['highlight']}'.toLowerCase();
      return text.contains(query);
    }).toList();

    if (_activeFilter == 1) { // Category
      filtered = filtered.where((s) => s['title'] == 'Premium').toList();
    } else if (_activeFilter == 2) { // Price
      filtered = filtered.where((s) => s['title'] == 'Express').toList();
    } else if (_activeFilter == 3) { // Type
      filtered = filtered.where((s) => s['title'] == 'Eco-Friendly').toList();
    }

    if (filtered.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text('No services found matching your search.', style: TextStyle(color: Color(0xFF64748B))),
        ),
      );
    }

    return Column(
      children: List.generate(filtered.length, (i) {
        final s = filtered[i];
        return GestureDetector(
          onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                // Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: s['image'] != null
                        ? Image.network(
                            s['image'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              color: const Color(0xFFE2E8E9),
                              child: const Icon(Icons.image_not_supported_outlined,
                                  color: Color(0xFF334155)),
                            ),
                          )
                        : Container(
                            color: const Color(0xFF0EA5A4).withValues(alpha: 0.12),
                            child: Icon(s['icon'] as IconData,
                                color: const Color(0xFF0EA5A4), size: 30),
                          ),
                  ),
                ),
                const SizedBox(width: 14),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(text: '${s['title']} '),
                            TextSpan(
                              text: s['highlight'] as String,
                              style: const TextStyle(color: Color(0xFF0EA5A4)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        s['subtitle'] as String,
                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 22),
              ],
            ),
          ),
        );
      }),
    );
  }
}
