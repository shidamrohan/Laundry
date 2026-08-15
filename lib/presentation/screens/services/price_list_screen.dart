import 'package:flutter/material.dart';

class PriceListScreen extends StatefulWidget {
  const PriceListScreen({super.key});

  @override
  State<PriceListScreen> createState() => _PriceListScreenState();
}

class _PriceListScreenState extends State<PriceListScreen> {
  int _activeCategory = 0;
  bool _isExpress = false;
  final Set<String> _expanded = {'men'}; // Men expanded by default

  final List<String> _categories = [
    'Wash & Fold',
    'Dry Clean',
    'Iron',
    'Premium',
    'Shoes',
  ];

  final List<Map<String, dynamic>> _sections = [
    {
      'id': 'men',
      'label': 'Men',
      'icon': Icons.male,
      'items': [
        {'name': 'Shirt', 'standard': '₹49', 'express': '₹99'},
        {'name': 'Trouser', 'standard': '₹69', 'express': '₹129'},
        {'name': 'Kurta', 'standard': '₹79', 'express': '₹149'},
        {'name': 'Suit (2pc)', 'standard': '₹249', 'express': '₹449'},
        {'name': 'Blazer', 'standard': '₹149', 'express': '₹299'},
      ],
      'viewAllLabel': "View All Men's Items",
    },
    {
      'id': 'women',
      'label': 'Women',
      'icon': Icons.female,
      'items': [
        {'name': 'Kurti', 'standard': '₹59', 'express': '₹109'},
        {'name': 'Saree', 'standard': '₹149', 'express': '₹279'},
        {'name': 'Salwar Set', 'standard': '₹129', 'express': '₹229'},
        {'name': 'Dress', 'standard': '₹99', 'express': '₹179'},
        {'name': 'Lehenga', 'standard': '₹349', 'express': '₹599'},
      ],
      'viewAllLabel': "View All Women's Items",
    },
    {
      'id': 'kids',
      'label': 'Kids',
      'icon': Icons.child_care,
      'items': [
        {'name': 'T-Shirt', 'standard': '₹29', 'express': '₹59'},
        {'name': 'Shorts', 'standard': '₹29', 'express': '₹59'},
        {'name': 'School Uniform', 'standard': '₹49', 'express': '₹89'},
        {'name': 'Dress', 'standard': '₹49', 'express': '₹89'},
      ],
      'viewAllLabel': "View All Kids' Items",
    },
    {
      'id': 'household',
      'label': 'Household',
      'icon': Icons.home_outlined,
      'items': [
        {'name': 'Single Bedsheet', 'standard': '₹79', 'express': '₹149'},
        {'name': 'Double Bedsheet', 'standard': '₹99', 'express': '₹179'},
        {'name': 'Blanket', 'standard': '₹199', 'express': '₹349'},
        {'name': 'Curtain (per panel)', 'standard': '₹149', 'express': '₹279'},
        {'name': 'Sofa Cover', 'standard': '₹249', 'express': '₹449'},
      ],
      'viewAllLabel': "View All Household Items",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // ── MAIN SCROLL CONTENT ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: topPadding + 64)),

              // ── CATEGORY CHIPS ──
              SliverToBoxAdapter(child: _buildCategoryChips()),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              // ── TOGGLE + INFO ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildToggleRow(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // GST info
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline, color: Color(0xFF94A3B8), size: 14),
                      SizedBox(width: 6),
                      Text(
                        'All prices include 18% GST. No hidden charges.',
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // ── ACCORDION SECTIONS ──
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _buildAccordion(_sections[i]),
                    ),
                    childCount: _sections.length,
                  ),
                ),
              ),

              // ── PROMO BANNER ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: _buildPromoBanner(),
                ),
              ),

              // Bottom spacing for sticky bar
              SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 90)),
            ],
          ),

          // ── FIXED HEADER ──
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),

          // ── STICKY DELIVERY BAR ──
          Positioned(
            bottom: bottomPadding + 12,
            left: 16,
            right: 16,
            child: _buildDeliveryBar(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HEADER ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(4, topPadding, 4, 0),
      height: topPadding + 64,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 24),
            splashRadius: 22,
          ),
          const Expanded(
            child: Text(
              'Price list',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Color(0xFF0F172A), size: 24),
            splashRadius: 22,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDsqyCHqgu0hK9ts1dm5RDvUnJCKhpON9dogxy6GZdTsWMZ4z4Mv3oM3YHoqNrZfJxw40GXeJ9SlCEilhDjpRuKIbczEkU9_6958epZDxfs0D2mhiFFw-hkM0oZz5p04ycctErfoG6HyWGoAw5rnVtjwwxiDI_sL5aJHpOGsymHsNJIrl-g595zYwSOzKLrz3gAxU_okLsMRN_ciwsrbANmCtqebPgJctfsg2dH7v6RaZwXrpetO5_c35lWb8skST4oOUWuXjrka6Sf',
              ),
              onBackgroundImageError: (_, __) {},
              child: const Icon(Icons.person, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── CHIPS ───────────────────────

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, i) {
          final isActive = _activeCategory == i;
          return GestureDetector(
            onTap: () => setState(() => _activeCategory = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF0EA5A4) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
                ),
                boxShadow: isActive
                    ? [BoxShadow(color: const Color(0xFF0EA5A4).withOpacity(0.2), blurRadius: 8)]
                    : null,
              ),
              child: Text(
                _categories[i],
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFF64748B),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─────────────────────── TOGGLE ───────────────────────

  Widget _buildToggleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Standard / Express toggle
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6F6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8E9)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildToggleBtn('Standard', !_isExpress, () => setState(() => _isExpress = false)),
              _buildToggleBtn('Express', _isExpress, () => setState(() => _isExpress = true)),
            ],
          ),
        ),

        // Members badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6F6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.stars, color: Color(0xFF0EA5A4), size: 14),
              SizedBox(width: 5),
              Text(
                'Members save 20%',
                style: TextStyle(
                  color: Color(0xFF0EA5A4),
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleBtn(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: isActive
              ? [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4)]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ─────────────────────── ACCORDION ───────────────────────

  Widget _buildAccordion(Map<String, dynamic> section) {
    final id = section['id'] as String;
    final isExpanded = _expanded.contains(id);
    final items = section['items'] as List<Map<String, dynamic>>;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8E9)),
        boxShadow: [
          BoxShadow(color: const Color(0xFF0F172A).withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: () => setState(() {
              isExpanded ? _expanded.remove(id) : _expanded.add(id);
            }),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(section['icon'] as IconData, color: const Color(0xFF0EA5A4), size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      section['label'] as String,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(Icons.expand_more, color: Color(0xFF64748B), size: 22),
                  ),
                ],
              ),
            ),
          ),

          // Animated body
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Column(
              children: [
                const Divider(height: 1, color: Color(0xFFE2E8E9)),
                // Table header
                Container(
                  color: const Color(0xFFEFF6F6).withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text('ITEM',
                            style: TextStyle(
                                color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('STANDARD',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
                      ),
                      SizedBox(
                        width: 70,
                        child: Text('EXPRESS',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.0)),
                      ),
                    ],
                  ),
                ),
                // Rows
                ...List.generate(items.length, (i) {
                  final item = items[i];
                  final isAlt = i.isOdd;
                  return Container(
                    color: isAlt ? const Color(0xFFEFF6F6).withOpacity(0.2) : Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(item['name'] as String,
                              style: const TextStyle(
                                  color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(item['standard'] as String,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: _isExpress ? const Color(0xFF94A3B8) : const Color(0xFF0F172A),
                                fontSize: 14,
                                fontWeight: _isExpress ? FontWeight.w500 : FontWeight.w700,
                              )),
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(item['express'] as String,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: _isExpress ? const Color(0xFF0EA5A4) : const Color(0xFF94A3B8),
                                fontSize: 14,
                                fontWeight: _isExpress ? FontWeight.w700 : FontWeight.w500,
                              )),
                        ),
                      ],
                    ),
                  );
                }),
                // Divider between rows
                ...List.generate(items.length - 1, (i) {
                  return const Divider(height: 0, indent: 16, endIndent: 16, color: Color(0xFFE2E8E9));
                }),

                // View All button
                Container(
                  color: const Color(0xFF0EA5A4).withOpacity(0.05),
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const SizedBox(),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          section['viewAllLabel'] as String,
                          style: const TextStyle(
                              color: Color(0xFF0EA5A4), fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward, color: Color(0xFF0EA5A4), size: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 280),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }

  // ─────────────────────── PROMO BANNER ───────────────────────

  Widget _buildPromoBanner() {
    return Container(
      height: 148,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0EA5A4).withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          )
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // BG icon
          Positioned(
            right: -8,
            top: -8,
            child: Icon(
              Icons.dry_cleaning,
              size: 120,
              color: Colors.white.withOpacity(0.12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'First Order 50% Off',
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.3),
                ),
                const SizedBox(height: 6),
                Text(
                  'Experience fresh laundry with our special welcome offer.',
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0EA5A4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                  ),
                  child: const Text('Claim Offer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── STICKY DELIVERY BAR ───────────────────────

  Widget _buildDeliveryBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.schedule, color: Color(0xFF0EA5A4), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EST. DELIVERY',
                  style: TextStyle(color: Color(0x99FFFFFF), fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.2),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
                    children: [
                      TextSpan(text: 'Standard: '),
                      TextSpan(text: '24h', style: TextStyle(color: Colors.white)),
                      TextSpan(text: ' · Express: '),
                      TextSpan(text: '6h', style: TextStyle(color: Color(0xFF0EA5A4))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5A4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              elevation: 0,
            ),
            child: const Text('Book Now',
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
