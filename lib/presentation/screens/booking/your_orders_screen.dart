import 'package:flutter/material.dart';
import 'package:laundry/presentation/widgets/skeleton_loader.dart';

class YourOrdersScreen extends StatefulWidget {
  const YourOrdersScreen({super.key});

  @override
  State<YourOrdersScreen> createState() => _YourOrdersScreenState();
}

class _YourOrdersScreenState extends State<YourOrdersScreen> {
  String _selectedFilter = 'All';
  int _steamIronRating = 5; // pre-filled 5 stars
  bool _isLoading = true;

  final List<String> _filters = ['All', 'Active', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  static const _primary = Color(0xFF0EA5A4);

  static const _secondary = Color(0xFF2563EB);
  static const _success = Color(0xFF16A34A);
  static const _error = Color(0xFFDC2626);
  static const _warning = Color(0xFFF59E0B);
  static const _background = Color(0xFFF7FAFB);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 40),
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildFilterChips(),
                  const SizedBox(height: 20),
                  _isLoading ? _buildOrdersSkeleton() : _buildOrdersList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      color: _surface,
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Your Orders',
              textAlign: TextAlign.center,
              style: TextStyle(color: _primary, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.3),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: _primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider.withValues(alpha: 0.5)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: _textSecondary),
          const SizedBox(width: 12),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your orders',
                hintStyle: TextStyle(color: _textSecondary, fontSize: 15),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(color: _textPrimary, fontSize: 15),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.mic, color: _primary),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? _primary : _surface,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: isSelected ? _primary : _divider),
                boxShadow: isSelected
                    ? [const BoxShadow(color: Color(0x330EA5A4), blurRadius: 8, offset: Offset(0, 4))]
                    : [],
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : _textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrdersSkeleton() {
    return Column(
      children: List.generate(3, (index) => const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SkeletonContainer(width: double.infinity, height: 180, borderRadius: 20),
      )),
    );
  }

    return Column(
      children: [
        if (_selectedFilter == 'All' || _selectedFilter == 'Completed')
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildDeliveredCard(),
          ),
        if (_selectedFilter == 'All' || _selectedFilter == 'Active')
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildActiveCard(),
          ),
        if (_selectedFilter == 'All' || _selectedFilter == 'Completed')
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildRatingCard(),
          ),
        if (_selectedFilter == 'All' || _selectedFilter == 'Cancelled')
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildCancelledCard(),
          ),
      ],
    );
  }

  // --- Card 1: Delivered (Wash & Fold) ---
  Widget _buildDeliveredCard() {
    return _OrderCard(
      icon: Icons.local_laundry_service,
      title: 'Wash & Fold',
      subtitle: 'VOSHIFY Express · Koramangala',
      statusLabel: 'Delivered',
      statusColor: _success,
      statusBgColor: const Color(0x1A16A34A),
      metaItems: [
        _MetaItem(icon: Icons.inventory_2, label: '6 items · 4.5 kg'),
        _MetaItem(icon: Icons.calendar_today, label: '19 Jul 2026'),
      ],
      price: '₹844',
      actions: Row(
        children: [
          _textActionButton('Support'),
          const SizedBox(width: 8),
          _outlinedActionButton('Reorder', isPrimary: true),
          const SizedBox(width: 4),
          _moreButton(),
        ],
      ),
    );
  }

  // --- Card 2: Active (Dry Cleaning) ---
  Widget _buildActiveCard() {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _primary.withValues(alpha: 0.2)),
        boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Gradient top bar
          Container(
            height: 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [_primary, _secondary]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(color: _surfaceAlt, borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: const Icon(Icons.dry_cleaning, color: _primary, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Dry Cleaning', style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                          SizedBox(height: 2),
                          Text('VOSHIFY Premium · Indiranagar', style: TextStyle(color: _textSecondary, fontSize: 14)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: _primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(99)),
                      child: const Text('IN PROGRESS', style: TextStyle(color: _primary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildMetaChip(icon: Icons.inventory_2, label: '3 items · 2.0 kg'),
                    const SizedBox(width: 24),
                    _buildMetaChip(icon: Icons.schedule, label: 'Today'),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: _divider, height: 1),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: Text('₹499', style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold))),
                    _textActionButton('Support'),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: _primary.withValues(alpha: 0.4),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                      ),
                      child: const Text('Track', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                    const SizedBox(width: 4),
                    _moreButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Card 3: Delivered with Rating (Steam Iron) ---
  Widget _buildRatingCard() {
    return _OrderCard(
      icon: Icons.iron,
      title: 'Steam Iron',
      subtitle: 'VOSHIFY Express · HSR Layout',
      statusLabel: 'Delivered',
      statusColor: _success,
      statusBgColor: const Color(0x1A16A34A),
      metaItems: [
        _MetaItem(icon: Icons.inventory_2, label: '10 items · 3.2 kg'),
        _MetaItem(icon: Icons.calendar_today, label: '15 Jul 2026'),
      ],
      price: '₹199',
      extraContent: _buildRatingWidget(),
      actions: Row(
        children: [
          _textActionButton('Support'),
          const SizedBox(width: 8),
          _outlinedActionButton('Reorder', isPrimary: true),
          const SizedBox(width: 4),
          _moreButton(),
        ],
      ),
    );
  }

  Widget _buildRatingWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: _surfaceAlt, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const Expanded(child: Text('Rate this order', style: TextStyle(color: _textPrimary, fontSize: 14, fontWeight: FontWeight.w600))),
          Row(
            children: List.generate(5, (i) {
              return GestureDetector(
                onTap: () => setState(() => _steamIronRating = i + 1),
                child: Icon(
                  i < _steamIronRating ? Icons.star : Icons.star_border,
                  color: _warning,
                  size: 22,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // --- Card 4: Cancelled (Shoe Spa) ---
  Widget _buildCancelledCard() {
    return Opacity(
      opacity: 0.8,
      child: _OrderCard(
        icon: Icons.checkroom,
        title: 'Shoe Spa',
        subtitle: 'VOSHIFY Express · Koramangala',
        statusLabel: 'Cancelled',
        statusColor: _error,
        statusBgColor: const Color(0x1ADC2626),
        metaItems: [
          _MetaItem(icon: Icons.inventory_2, label: '2 pairs'),
          _MetaItem(icon: Icons.calendar_today, label: '10 Jul 2026'),
        ],
        price: '₹399',
        priceStrikethrough: true,
        actions: Row(
          children: [
            _textActionButton('Details'),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: _primary),
                foregroundColor: _primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
              ),
              child: const Text('Retry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  // --- Skeleton Loader ---
  Widget _buildSkeletonCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _divider.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(56, 56, radius: 12),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(12, 96),
                    const SizedBox(height: 8),
                    _shimmerBox(10, 128),
                  ],
                ),
              ),
              _shimmerBox(24, 80, radius: 99),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _shimmerBox(10, 96),
              const SizedBox(width: 24),
              _shimmerBox(10, 80),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: _divider, height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              _shimmerBox(24, 64),
              const Spacer(),
              _shimmerBox(36, 80, radius: 99),
              const SizedBox(width: 8),
              _shimmerBox(36, 96, radius: 99),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox(double height, double width, {double radius = 8}) {
    return _ShimmerWidget(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: _surfaceAlt,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  // --- Helpers ---
  Widget _buildMetaChip({required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _textSecondary, size: 18),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: _textSecondary, fontSize: 14)),
      ],
    );
  }

  Widget _textActionButton(String label) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: _textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
    );
  }

  Widget _outlinedActionButton(String label, {bool isPrimary = false}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: _surfaceAlt,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(label, style: const TextStyle(color: _primary, fontWeight: FontWeight.bold, fontSize: 14)),
      ),
    );
  }

  Widget _moreButton() {
    return IconButton(
      icon: const Icon(Icons.more_vert, color: _textSecondary),
      onPressed: () {},
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
    );
  }
}

// Reusable Order Card
class _OrderCard extends StatelessWidget {
  const _OrderCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.statusColor,
    required this.statusBgColor,
    required this.metaItems,
    required this.price,
    required this.actions,
    this.extraContent,
    this.priceStrikethrough = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String statusLabel;
  final Color statusColor;
  final Color statusBgColor;
  final List<_MetaItem> metaItems;
  final String price;
  final Widget actions;
  final Widget? extraContent;
  final bool priceStrikethrough;

  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _divider.withValues(alpha: 0.3)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: _surfaceAlt, borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Icon(icon, color: _primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(color: _textSecondary, fontSize: 14)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: statusBgColor, borderRadius: BorderRadius.circular(99)),
                child: Text(
                  statusLabel.toUpperCase(),
                  style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: metaItems
                .map((item) => Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(item.icon, color: _textSecondary, size: 18),
                          const SizedBox(width: 6),
                          Text(item.label, style: const TextStyle(color: _textSecondary, fontSize: 14)),
                        ],
                      ),
                    ))
                .toList(),
          ),
          if (extraContent != null) ...[
            const SizedBox(height: 12),
            extraContent!,
          ],
          const SizedBox(height: 16),
          const Divider(color: _divider, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  price,
                  style: TextStyle(
                    color: priceStrikethrough ? _textSecondary : _textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    decoration: priceStrikethrough ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
              actions,
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaItem {
  const _MetaItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

// Shimmer animation widget
class _ShimmerWidget extends StatefulWidget {
  const _ShimmerWidget({required this.child});
  final Widget child;

  @override
  State<_ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<_ShimmerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
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
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [Color(0xFFEFF6F6), Color(0xFFE2E8E9), Color(0xFFEFF6F6)],
              stops: [_animation.value - 0.3, _animation.value, _animation.value + 0.3],
              tileMode: TileMode.clamp,
            ).createShader(rect);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
