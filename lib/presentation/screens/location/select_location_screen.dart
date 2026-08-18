import 'package:flutter/material.dart';
import 'package:laundry/core/services/location_service.dart';
import 'package:laundry/presentation/screens/location/search_address_screen.dart';
import 'package:laundry/presentation/screens/location/edit_address_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  int _selectedTab = 0;
  bool _isFetchingLocation = false; // 0 for Pickup, 1 for Delivery

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: topPadding + 64)),
              
              // ── SEARCH BAR ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: _buildSearchBar(),
                ),
              ),

              // ── QUICK ACTIONS ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildQuickActions(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── TOGGLE ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: SizedBox(
                      width: 240,
                      child: _buildToggle(),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── SAVED ADDRESSES ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildSavedAddresses(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── RECENT LOCATIONS ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildRecentLocations(),
                ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 120)), // Space for bottom nav if any
            ],
          ),

          // ── HEADER ──
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(4, topPadding, 4, 0),
      height: topPadding + 64,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4), size: 24),
                splashRadius: 22,
              ),
              const SizedBox(width: 4),
              const Text('Select location', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic, color: Color(0xFF0EA5A4), size: 24),
            splashRadius: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.transparent),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, _, _) => const SearchAddressScreen(),
              transitionsBuilder: (_, animation, _, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 200),
            ),
          );
        },
        decoration: InputDecoration(
          hintText: 'Search for area, street name...',
          hintStyle: TextStyle(color: const Color(0xFF64748B), fontSize: 15),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
          suffixIcon: const Icon(Icons.mic, color: Color(0xFF0EA5A4)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            icon: _isFetchingLocation ? Icons.hourglass_empty : Icons.location_searching,
            iconColor: Colors.white,
            iconBg: const Color(0xFF0EA5A4),
            title: _isFetchingLocation ? 'Fetching...' : 'Use current location',
            titleColor: const Color(0xFF0EA5A4),
            subtitle: 'Enable for precise pickup',
            cardBg: const Color(0xFFEFF6F6),
            borderColor: const Color(0xFF0EA5A4).withValues(alpha: 0.2),
            onTap: _fetchLocation,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            icon: Icons.add_location,
            iconColor: const Color(0xFF0EA5A4),
            iconBg: const Color(0xFFEFF6F6),
            title: 'Add new address',
            titleColor: const Color(0xFF0F172A),
            subtitle: 'Manual entry',
            cardBg: Colors.white,
            borderColor: const Color(0xFFE2E8E9),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditAddressScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required Color titleColor,
    required String subtitle,
    required Color cardBg,
    required Color borderColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: titleColor, fontSize: 15, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
        ],
      ),
    ),
    );
  }

  Future<void> _fetchLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      final position = await LocationService.getCurrentPosition();
      if (position != null) {
        final address = await LocationService.getAddressFromCoordinates(position.latitude, position.longitude);
        if (mounted && address != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location found: $address')),
          );
          // Auto-fill or navigate based on success.
          // For now, let's navigate to EditAddressScreen passing the address.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditAddressScreen()), // Ideally pass address
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isFetchingLocation = false);
      }
    }
  }

  Widget _buildToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFE2E8E9).withValues(alpha: 0.4), borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Expanded(child: _buildToggleTab(0, 'Pickup')),
          Expanded(child: _buildToggleTab(1, 'Delivery')),
        ],
      ),
    );
  }

  Widget _buildToggleTab(int index, String label) {
    final isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0EA5A4) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          boxShadow: isActive ? const [BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2))] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF64748B),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSavedAddresses() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SAVED ADDRESSES', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 8),
        _buildHomeAddressCard(),
        const SizedBox(height: 16),
        _buildWorkAddressCard(),
        const SizedBox(height: 16),
        _buildMomAddressCard(),
      ],
    );
  }

  Widget _buildHomeAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9).withValues(alpha: 0.5)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
                child: const Icon(Icons.home, color: Color(0xFF0EA5A4), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Home', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                          child: const Text('DEFAULT', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('21 Brigade Road, Shanthala Nagar, Bengaluru 560025', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.4)),
                    const SizedBox(height: 4),
                    const Text('Aarav Kumar · +91 98765 43210', style: TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE2E8E9), height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF16A34A).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('Delivery available', style: TextStyle(color: Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: const [
                    Icon(Icons.schedule, color: Color(0xFF0EA5A4), size: 14),
                    SizedBox(width: 4),
                    Text('Pickup in ~30 min', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildIconButton(Icons.edit, onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EditAddressScreen()));
              }),
              _buildIconButton(Icons.share),
              _buildIconButton(Icons.delete, color: const Color(0xFFDC2626)),
              _buildIconButton(Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9).withValues(alpha: 0.5)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
            child: const Icon(Icons.work, color: Color(0xFF64748B), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Work', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Prestige Tech Park, Outer Ring Rd, Marathahalli', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.4)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFF16A34A).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      const Text('Delivery available', style: TextStyle(color: Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMomAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9).withValues(alpha: 0.5)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
            child: const Icon(Icons.location_on, color: Color(0xFF64748B), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Mom\'s place', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Green Glen Layout, Bellandur, Bengaluru', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.4)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.water_drop, color: Color(0xFFF59E0B), size: 16),
                      SizedBox(width: 6),
                      Expanded(child: Text('Heavy rain · pickup may be delayed', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 12, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {Color? color, VoidCallback? onTap}) {
    return IconButton(
      onPressed: onTap ?? () {},
      icon: Icon(icon, color: color ?? const Color(0xFF64748B), size: 20),
      splashRadius: 20,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
    );
  }

  Widget _buildRecentLocations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('RECENT LOCATIONS', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 8),
        _buildRecentLocationItem('Indiranagar Metro', 'Stage 2, Hoysala Nagar', '0.8 km'),
        const SizedBox(height: 4),
        _buildRecentLocationItem('Phoenix Marketcity', 'Whitefield Main Road', '2.4 km'),
      ],
    );
  }

  Widget _buildRecentLocationItem(String title, String subtitle, String distance) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8E9).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.history, color: Color(0xFF94A3B8), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.w500)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
          ),
          Text(distance, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
