import 'package:flutter/material.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  bool _isGridView = true;
  int _activeCategory = 0;
  final Set<int> _favorites = {};

  final List<String> _categories = ['All', 'Wash', 'Dry Clean', 'Iron'];

  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Dry Cleaning',
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLvtAMNhCqH_0_mSCF7ZvkZu3yOB3ZJGVeTJp5pyRf_XHlNnzwh7RnFbTgqa-_pFdd8HA4XUKn9xQgC4qfKuxr1PzvKXkpEEsD4CA3yixvhuo0-22tRSx6ZVLt-1KDu-Qoi54elIFhg2fXhLB-ZAavJ8SJuscE1ZZFm4stWQHW_fPZLSKWTcI7Ju094iT6QoR7hQerU0JJk53VEKmEYTDbPqdPh06PQYGlNglSiUejQcJLVElZ-tt5ASF18',
      'rating': '4.8',
      'reviews': '1.2k',
      'delivery': '24h Delivery',
      'price': '₹99',
      'discount': '20% OFF',
    },
    {
      'name': 'Wash & Fold',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAHJXrfjTzd1kwok-uQqWiyshOUVe9Rks3MMU7x1GsRrxq5079Dw7732_8Ue2V2LIVfhlDQnNF5gyeuSJsfd0_zobJIi0FL9_98rT2TYOFPVNN8hqLm5GOxcf7_60R5PolEQeVXbrnO8eSzOMOzaA27dsW0E0gy8tR2YMSZpK_1Dcx_hkF6czwy-jL5jTR4D-BEMHaZP4J0XfJSGrYWAKR3B58KcIX4nSF8nGFFZ3OeMjgl3SCkygWoX5IzU01kbWEMzVmeKO7FP3wo',
      'rating': '4.9',
      'reviews': '850',
      'delivery': '12h Delivery',
      'price': '₹49',
      'discount': '20% OFF',
    },
    {
      'name': 'Steam Ironing',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBA-Tc_etVJrZ4HC9I_ClNd_5nra-SBtxll7zvsx6kA01YD5aL339UhRxBBkSMBkRKtNhbXO2R-CFrr8RjMpz9geWFCOhX7_T8A3IT5VmfyOH993_eK1VUA74ACPbHsmxpVFbiyDqM6lP5J-hGpk6PshEkM5KT9hAvAf6ndPg1h0jARb0iRqjQ9gHf-uZtdeG8DYEv3WbSdsFGkZvUqebXR_mqMhiwerftMXZhQrcCitB2Wn6TX5o-G7TzSkkzuCCx0L8QgKxIt-2Eg',
      'rating': '4.7',
      'reviews': '2.1k',
      'delivery': '6h Delivery',
      'price': '₹19',
      'discount': '20% OFF',
    },
    {
      'name': 'Shoe Spa',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDM4MEosBoX1aUTfYCwfLM9dcUlk5fvd_AAyRGOxUvU4eBx0ikH_pAOFqAak5bmFUBGLkf-HSQhKu8-Z9h6G3_0qvPRQuv6HQPM4T_2uHRRFido6MEeOxOpTr_kMHAZz0Il4hPDxn-bH4VtTMcIZs9eT14AnLf_rJk6Z881bPhqGQOaQUCTy0UnJNmlwrbYY1Hh_r8ynHH4skf8kVOSP0CZs6SnIsy8_WQVbtrhi1RKyW16CkUnCDtQm-lav2LtMPfvnB3T07XrGbm6',
      'rating': '4.8',
      'reviews': '340',
      'delivery': '48h Delivery',
      'price': '₹149',
      'discount': '20% OFF',
    },
    {
      'name': 'Leather Care',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBrQFGNG8YGvDFgeqSF_HSRtijI7L_K64FZ2_hHsZr9awot3m22vtok_wZPCtVwVlLk6UJ4hSzbjBm_YA27iLZyyu1dziK5q6ySFHagGZr8MSILM4Ql5VfGcEX8TDj9MmOtdXkdVroyxEUHvnEQR1rW4x1-5YOQ7SjhHl7WRd-2bnKZ4yvzhqRUt-B7s6Aqz0VrjR4jW3a-2uv2O53Tupf8OCLRguD8IMZEMBhoD0pzmBAM5Q5YlwSQ9G48wAa-_cdnB3I_PYWOHkF8',
      'rating': '4.6',
      'reviews': '120',
      'delivery': '72h Delivery',
      'price': '₹299',
      'discount': '20% OFF',
    },
    {
      'name': 'Upholstery',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDvg7EG9VZGVwK1WCfJmgipShplaoPxS5MdfnclfCHMFWVJ5tdCrRZsjOQFIVz3gO-92g3GDYlmJjiFT2zbMzNtDP1X6szrXIOnmuV62ghoDw2CpcFAsXAHxTaIzHxlbDwnWLAvZ3yfm_NNE_L80LxQN4Ugg9iFZzZZMbBVeXJOYo40Doez5CBL_IHiyrocUuPZ0yQL1u_HEAiuxy95RGBi4uwzfibeT9jwBkkVA9HbdvwV9v1duL6IJX3ZJXclQ1hD9_Dz4lFE5XQB',
      'rating': '4.5',
      'reviews': '95',
      'delivery': '48h Delivery',
      'price': '₹199',
      'discount': '20% OFF',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Column(
        children: [
          // ── FIXED HEADER ──
          Container(
            color: const Color(0xFF0B1220).withOpacity(0.92),
            padding: EdgeInsets.fromLTRB(8, topPadding + 4, 8, 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
                  splashRadius: 20,
                ),
                const Expanded(
                  child: Text(
                    'All Services',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Grid toggle
                IconButton(
                  onPressed: () => setState(() => _isGridView = true),
                  icon: Icon(
                    Icons.grid_view,
                    color: _isGridView ? const Color(0xFF0EA5A4) : const Color(0xFF94A3B8),
                    size: 22,
                  ),
                  splashRadius: 20,
                ),
                IconButton(
                  onPressed: () => setState(() => _isGridView = false),
                  icon: Icon(
                    Icons.view_list,
                    color: !_isGridView ? const Color(0xFF0EA5A4) : const Color(0xFF94A3B8),
                    size: 22,
                  ),
                  splashRadius: 20,
                ),
              ],
            ),
          ),

          // ── STICKY FILTER ROW ──
          Container(
            color: const Color(0xFF0B1220),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              children: [
                const Divider(color: Color(0xFF1E293B), height: 1),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      // Filters chip
                      _buildFilterChip(
                        label: 'Filters',
                        icon: Icons.tune,
                        badge: '2',
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      // Sort chip
                      _buildFilterChip(
                        label: 'Sort: Popular',
                        trailingIcon: Icons.expand_more,
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      // Divider
                      Container(width: 1, height: 24, color: const Color(0xFF1E293B)),
                      const SizedBox(width: 8),
                      // Category chips
                      ...List.generate(_categories.length, (i) {
                        final isActive = _activeCategory == i;
                        return GestureDetector(
                          onTap: () => setState(() => _activeCategory = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                            decoration: BoxDecoration(
                              color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF0F172A),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF1E293B),
                              ),
                              boxShadow: isActive
                                  ? [BoxShadow(color: const Color(0xFF0EA5A4).withOpacity(0.25), blurRadius: 8)]
                                  : null,
                            ),
                            child: Text(
                              _categories[i],
                              style: TextStyle(
                                color: isActive ? Colors.white : const Color(0xFF94A3B8),
                                fontSize: 13,
                                fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── SCROLLABLE GRID / LIST ──
          Expanded(
            child: _isGridView ? _buildGrid(bottomPadding) : _buildList(bottomPadding),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    IconData? icon,
    IconData? trailingIcon,
    String? badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1E293B)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: Colors.white),
              const SizedBox(width: 6),
            ],
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF0EA5A4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(badge,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
            if (trailingIcon != null) ...[
              const SizedBox(width: 4),
              Icon(trailingIcon, size: 16, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(double bottomPadding) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPadding + 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemCount: _services.length + 1, // +1 for skeleton
      itemBuilder: (context, i) {
        if (i == _services.length) return _buildSkeletonCard();
        return _buildServiceCard(i);
      },
    );
  }

  Widget _buildList(double bottomPadding) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPadding + 24),
      itemCount: _services.length,
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildListCard(i),
      ),
    );
  }

  Widget _buildServiceCard(int i) {
    final s = _services[i];
    final isFav = _favorites.contains(i);

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E293B)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    s['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF1E293B),
                      child: const Icon(Icons.image_not_supported_outlined,
                          color: Color(0xFF334155)),
                    ),
                  ),
                  // Discount badge
                  Positioned(
                    top: 8, left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0EA5A4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        s['discount'] as String,
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 6, right: 6,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        isFav ? _favorites.remove(i) : _favorites.add(i);
                      }),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s['name'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFBBF24), size: 13),
                        const SizedBox(width: 3),
                        Text('${s['rating']} (${s['reviews']})',
                            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.schedule, color: Color(0xFF94A3B8), size: 13),
                        const SizedBox(width: 3),
                        Text(s['delivery'] as String,
                            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                      ],
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'From ',
                            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                          ),
                          TextSpan(
                            text: s['price'] as String,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 32,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0EA5A4),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.zero,
                                elevation: 0,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('Book Now',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF0EA5A4)),
                          ),
                          child: const Icon(Icons.add, color: Color(0xFF0EA5A4), size: 18),
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

  Widget _buildListCard(int i) {
    final s = _services[i];
    final isFav = _favorites.contains(i);

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E293B)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            // Image
            SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(s['image'] as String, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Container(color: const Color(0xFF1E293B))),
                  Positioned(
                    top: 6, left: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0EA5A4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(s['discount'] as String,
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
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
                                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            isFav ? _favorites.remove(i) : _favorites.add(i);
                          }),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : const Color(0xFF94A3B8),
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.star, color: Color(0xFFFBBF24), size: 13),
                      const SizedBox(width: 3),
                      Text('${s['rating']} (${s['reviews']})',
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                      const SizedBox(width: 10),
                      const Icon(Icons.schedule, color: Color(0xFF94A3B8), size: 13),
                      const SizedBox(width: 3),
                      Text(s['delivery'] as String,
                          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                    ]),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: 'From ',
                                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                            TextSpan(
                              text: s['price'] as String,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5A4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              elevation: 0,
                            ),
                            child: const Text('Book Now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
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

  Widget _buildSkeletonCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: _shimmerBox(),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(height: 14, width: 100),
                const SizedBox(height: 6),
                _shimmerBox(height: 11, width: 70),
                const SizedBox(height: 6),
                _shimmerBox(height: 11, width: 70),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _shimmerBox(height: 30, borderRadius: 20)),
                    const SizedBox(width: 6),
                    _shimmerBox(height: 30, width: 30, borderRadius: 15),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({double? height, double? width, double borderRadius = 6}) {
    return _ShimmerWidget(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class _ShimmerWidget extends StatefulWidget {
  final Widget child;
  const _ShimmerWidget({required this.child});

  @override
  State<_ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<_ShimmerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [Color(0xFF1E293B), Color(0xFF334155), Color(0xFF1E293B)],
            stops: [
              (_animation.value - 0.5).clamp(0.0, 1.0),
              _animation.value.clamp(0.0, 1.0),
              (_animation.value + 0.5).clamp(0.0, 1.0),
            ],
          ).createShader(rect),
          blendMode: BlendMode.srcATop,
          child: widget.child,
        );
      },
    );
  }
}
