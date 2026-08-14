import 'package:flutter/material.dart';
import 'price_list_screen.dart';
import 'service_detail_screen.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  bool _isGridView = true;
  int _activeCategory = 0;
  final Set<int> _favorites = {0}; // Card 1 pre-favorited
  final Set<int> _added = {};

  final List<String> _categories = ['All', 'Wash', 'Dry Clean', 'Iron', 'Steam'];

  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Dry Cleaning',
      'badge': '20% OFF',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDvrBFwfhntrryPttoHoaRg6vS0YYdD5SiRUyJDfW1tPeAaFgdRguupK8ruSDKqoDubll7SRp2aHxlqrepkeyO_mTB2k-pu9oo9hvwA8wH5poyIBdecGz2sSp5pDDo0k3EAeHthNFFcoYljwc7B_8bJdPSTyvUS3Udg1G8y1R2ztnVApgTSIIa72pmq1tmbvOjBDVGJhVhJmY2OAqAGeDesWfNfb17y0hH8QkKnVTpymVSXfyOzDLa0XmVBGItE8lmMZ1F1Mu4Wr_Al',
      'rating': '4.8', 'reviews': '1.2k', 'delivery': '24h', 'price': '₹99',
    },
    {
      'name': 'Wash & Fold',
      'badge': 'POPULAR',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuA8G7Yq5yIx7jajdB-Re7tBQwHcjEbEjGlvEqESK5qkr039jLeGh1OGacTGkRctkTi8iKIKjeh8u88fd7624e5i2tMX0lYFgu0J5g1MiTJgp8pcf3HeUSpFsp8VsIUtT-L2ZsRuMP1jqdKxDt6W0VWpNnVF9DLvCZDR6sQnDNWEIG67K3BzQ-GbGn_ofXXlqyKFyKrzFYeHkcymcyFoWs3-KpdAtz2bGGYpPoVGJ8iJz6-NSFMDhvOsZJ1w1tvp1WQbqLbNQXm3fprn',
      'rating': '4.9', 'reviews': '3.5k', 'delivery': '12h', 'price': '₹49',
    },
    {
      'name': 'Steam Iron',
      'badge': 'EXPRESS',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBK4S58KqizZukPj6EUnityIIWarQ34e0-Ulhlv5OCA3WJsqloyaam_bHhiBs_v71COEwFa2cYO5yE-asA6Q6cFsdvhW-CwHYPd0JoWuwn1E6eEMe4Cqw42LzuH0S7LRTz-rV8YkUG50Ohn2vFR0uNxnfkW_rXQE9c62N2CMtnaaTwOJX99tR5T0Sik3jL2zsF2EXLTPLWYUvqtTyCurqLRP2bc6o0teLdXOegkSmo8HRX3z1G4ZNIm9QX3VDGF90lgM_pLoQ6sOfOg',
      'rating': '4.7', 'reviews': '850', 'delivery': '6h', 'price': '₹20',
    },
    {
      'name': 'Shoe Spa',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCmZaTPWksjoxBH-Ktbot68E0iYEPHb9RN1InO_AoMz3ubMBtKEEkxUTAyi_sdh7CVoyzJ6YR6yq_mVxm9XolbsCuVED6jH25kUzjGqsQmzNcdTjZLB4rGXrHCOrgC5a5nxbf7y5QMJis8vVDHwCfPorMa5zg8hA476LZuzNYem5g2bk8qcXE_mXs0zkJ_ONFHT5SbPNySG61gahhPFCSleTFMbprZAiIid15bFd_KrPVrMNEdRqGgpDhZBhe6dxkz_CA7M9ijHcPc9',
      'rating': '4.9', 'reviews': '420', 'delivery': '48h', 'price': '₹199',
    },
    {
      'name': 'Curtain Care',
      'badge': 'NEW',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBhJ9mErvUXBQiRiw_GVGpXr26j6OgFAIAPrpP008KwufdMZCpBJ-dx_w_ZhTswvMRFTLyjgpb1rDROW1Aa6JDMh5YU_Tw8iNC7_AzFEQei-1VMVZerN48EFxFUEJqhQ4hJWtOzUG99GE_IQY9rN_wS6Gxng2s7kWCY9GQ-nVd93aedGw6PZDQQI280XF286uCUzljxAAziyvUfMx_ofCyStO_NQdPeuVPYwa7tEqOTIy1cbZi6WCuL4tywFkCU7rr87d85_QyOgT6m',
      'rating': '4.6', 'reviews': '120', 'delivery': '72h', 'price': '₹299',
    },
    {
      'name': 'Leather Spa',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuD-AuDnh3annex1uhwJH-oZr5adwc5Sw7sRRMvAH42RNo-M4L2hkXU8Ne7gwN0K72OOzIeZduMBZGdNz6iYOBZ0gUG3hp5cQo_lGYAWOEiXCtcb_zFBjMN3EdnTVqL8JPM59YhSf9gMKTWUiLadDyydTuSXG4m37zJPDXKTryzKtxmusswWD_0JbBs2arUDGO8dtIQrp2_0-w_xJsgonAFqTOs-7eoVhyEdnPsBehO4YAdNSjf8FVLhk1F_H6yGg3MTfJV2xdCTNOQi',
      'rating': '5.0', 'reviews': '280', 'delivery': '48h', 'price': '₹499',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          // ── STICKY HEADER ──
          _buildStickyHeader(topPadding),

          // ── SCROLLABLE CONTENT ──
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, bottomPadding + 24),
                  sliver: _isGridView ? _buildGrid() : _buildList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HEADER ───────────────────────

  Widget _buildStickyHeader(double topPadding) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: title + view toggle
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 4),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_left, color: Color(0xFF0F172A), size: 26),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'All Services',
                      style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  // Grid toggle (active)
                  GestureDetector(
                    onTap: () => setState(() => _isGridView = true),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _isGridView ? const Color(0xFF0EA5A4) : const Color(0xFFEFF6F6),
                        shape: BoxShape.circle,
                        boxShadow: _isGridView
                            ? [BoxShadow(color: const Color(0xFF0EA5A4).withOpacity(0.25), blurRadius: 8)]
                            : null,
                      ),
                      child: Icon(Icons.grid_view,
                          color: _isGridView ? Colors.white : const Color(0xFF64748B), size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // List toggle
                  GestureDetector(
                    onTap: () => setState(() => _isGridView = false),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: !_isGridView ? const Color(0xFF0EA5A4) : const Color(0xFFEFF6F6),
                        shape: BoxShape.circle,
                        boxShadow: !_isGridView
                            ? [BoxShadow(color: const Color(0xFF0EA5A4).withOpacity(0.25), blurRadius: 8)]
                            : null,
                      ),
                      child: Icon(Icons.view_list,
                          color: !_isGridView ? Colors.white : const Color(0xFF64748B), size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),

            // Row 2: Filters + Sort
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Filters button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6F6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8E9)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.tune, color: Color(0xFF64748B), size: 18),
                        const SizedBox(width: 6),
                        const Text('Filters',
                            style: TextStyle(
                                color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0EA5A4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('2',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  // Sort button
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: const [
                        Text('Sort: ',
                            style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                        Text('Popular',
                            style: TextStyle(
                                color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.w700)),
                        SizedBox(width: 2),
                        Icon(Icons.expand_more, color: Color(0xFF0EA5A4), size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Row 3: Category chips
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final isActive = _activeCategory == i;
                  return GestureDetector(
                    onTap: () => setState(() => _activeCategory = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFFEFF6F6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _categories[i],
                        style: TextStyle(
                          color: isActive ? Colors.white : const Color(0xFF64748B),
                          fontSize: 14,
                          fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── GRID ───────────────────────

  SliverGrid _buildGrid() {
    final itemCount = _services.length + 2; // +2 skeleton cards
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          if (i >= _services.length) return _buildSkeletonCard(opacity: i == _services.length ? 0.6 : 0.4);
          return _buildServiceGridCard(i);
        },
        childCount: itemCount,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.60,
      ),
    );
  }

  SliverList _buildList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildServiceListCard(i),
        ),
        childCount: _services.length,
      ),
    );
  }

  // ─────────────────────── CARDS ───────────────────────

  Widget _buildServiceGridCard(int i) {
    final s = _services[i];
    final isFav = _favorites.contains(i);
    final isAdded = _added.contains(i);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ServiceDetailScreen()),
      ),
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8E9).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    s['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFEFF6F6)),
                  ),
                  // Badge
                  if (s['badge'] != null)
                    Positioned(
                      top: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0EA5A4).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(s['badge'] as String,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                      ),
                    ),
                  // Favorite
                  Positioned(
                    top: 6, right: 6,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        isFav ? _favorites.remove(i) : _favorites.add(i);
                      }),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? const Color(0xFFDC2626) : const Color(0xFF64748B),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Info
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['name'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.bold, height: 1.2)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.star, color: Color(0xFFF59E0B), size: 14),
                        const SizedBox(width: 3),
                        Text(s['rating'] as String,
                            style: const TextStyle(
                                color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.w600)),
                        Text(' (${s['reviews']})',
                            style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                      ]),
                      Row(children: [
                        const Icon(Icons.schedule, color: Color(0xFF64748B), size: 14),
                        const SizedBox(width: 2),
                        Text(s['delivery'] as String,
                            style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text('From ${s['price']}',
                      style: const TextStyle(
                          color: Color(0xFF0EA5A4), fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const PriceListScreen()),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5A4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.zero,
                              elevation: 0,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text('Book Now',
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() => _added.add(i));
                          Future.delayed(const Duration(milliseconds: 1500), () {
                            if (mounted) setState(() => _added.remove(i));
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: isAdded ? const Color(0xFF16A34A) : const Color(0xFFEFF6F6),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isAdded
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFF0EA5A4).withOpacity(0.2),
                            ),
                          ),
                          child: Icon(
                            isAdded ? Icons.check : Icons.add,
                            color: isAdded ? Colors.white : const Color(0xFF0EA5A4),
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildServiceListCard(int i) {
    final s = _services[i];
    final isFav = _favorites.contains(i);
    final isAdded = _added.contains(i);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ServiceDetailScreen()),
      ),
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          )
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          // Image
          SizedBox(
            width: 110,
            height: 110,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(s['image'] as String, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFEFF6F6))),
                if (s['badge'] != null)
                  Positioned(
                    top: 6, left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0EA5A4).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(s['badge'] as String,
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                    ),
                  ),
              ],
            ),
          ),
          // Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(s['name'] as String,
                            style: const TextStyle(
                                color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => isFav ? _favorites.remove(i) : _favorites.add(i)),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? const Color(0xFFDC2626) : const Color(0xFF64748B),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.star, color: Color(0xFFF59E0B), size: 13),
                    const SizedBox(width: 3),
                    Text(s['rating'] as String,
                        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.w600)),
                    Text(' (${s['reviews']})',
                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                    const SizedBox(width: 10),
                    const Icon(Icons.schedule, color: Color(0xFF64748B), size: 13),
                    const SizedBox(width: 2),
                    Text(s['delivery'] as String,
                        style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                  ]),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('From ${s['price']}',
                          style: const TextStyle(
                              color: Color(0xFF0EA5A4), fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(children: [
                        SizedBox(
                          height: 32,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5A4),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              elevation: 0,
                            ),
                            child: const Text('Book Now',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {
                            setState(() => _added.add(i));
                            Future.delayed(const Duration(milliseconds: 1500), () {
                              if (mounted) setState(() => _added.remove(i));
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isAdded ? const Color(0xFF16A34A) : const Color(0xFFEFF6F6),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isAdded
                                    ? const Color(0xFF16A34A)
                                    : const Color(0xFF0EA5A4).withOpacity(0.2),
                              ),
                            ),
                            child: Icon(isAdded ? Icons.check : Icons.add,
                                color: isAdded ? Colors.white : const Color(0xFF0EA5A4), size: 16),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildSkeletonCard({double opacity = 0.6}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8E9).withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                child: _ShimmerBox(),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ShimmerBox(height: 14, width: 100),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ShimmerBox(height: 11, width: 70),
                        _ShimmerBox(height: 11, width: 40),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _ShimmerBox(height: 14, width: 60),
                    const Spacer(),
                    Row(children: [
                      Expanded(child: _ShimmerBox(height: 34, borderRadius: 20)),
                      const SizedBox(width: 8),
                      _ShimmerBox(height: 34, width: 34, borderRadius: 17),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── SHIMMER WIDGET ──

class _ShimmerBox extends StatefulWidget {
  final double? height;
  final double? width;
  final double borderRadius;

  const _ShimmerBox({this.height, this.width, this.borderRadius = 6});

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
    _anim = Tween<double>(begin: -1.5, end: 2.5).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [Color(0xFFEFF6F6), Color(0xFFE2E8E9), Color(0xFFEFF6F6)],
              stops: [
                (_anim.value - 0.5).clamp(0.0, 1.0),
                _anim.value.clamp(0.0, 1.0),
                (_anim.value + 0.5).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
