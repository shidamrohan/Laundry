import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoSwitch

class AddressSelectionScreen extends StatefulWidget {
  const AddressSelectionScreen({super.key});

  @override
  State<AddressSelectionScreen> createState() => _AddressSelectionScreenState();
}

class _AddressSelectionScreenState extends State<AddressSelectionScreen> {
  bool _sameAsPickup = true;
  bool _isSwapped = false; // Just for visual mock of swap

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          _buildHeader(context, topPadding),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 120), // Space for bottom action bar
              children: [
                _buildRouteSelectionCard(),
                _buildToggleRow(),
                _buildSavedCombinations(),
                _buildRecentlyUsed(),
                _buildMapVisual(),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomActionBar(context),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(BuildContext context, double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 8),
      height: topPadding + 64,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
              splashRadius: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Text('Pickup & delivery', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRouteSelectionCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              children: [
                // Vertical Route UI Indicator
                Column(
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0EA5A4),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF0EA5A4).withOpacity(0.2), width: 4),
                      ),
                    ),
                    _buildDashedLine(),
                    Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.2), width: 4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                // Address Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pickup
                      _buildLocationDetail(
                        label: 'PICKUP',
                        labelColor: const Color(0xFF0EA5A4),
                        title: _isSwapped ? 'Work' : 'Home',
                        subtitle: _isSwapped ? 'Prestige Tech Park, Marathahalli' : '21 Brigade Road, Shanthala Nagar',
                      ),
                      const SizedBox(height: 24),
                      // Delivery
                      _buildLocationDetail(
                        label: 'DELIVERY',
                        labelColor: const Color(0xFF7C3AED),
                        title: _isSwapped ? 'Home' : 'Work',
                        subtitle: _isSwapped ? '21 Brigade Road, Shanthala Nagar' : 'Prestige Tech Park, Marathahalli',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 48), // Space for Swap Button
              ],
            ),
            // Swap Button
            GestureDetector(
              onTap: () => setState(() => _isSwapped = !_isSwapped),
              child: AnimatedRotation(
                turns: _isSwapped ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 48, height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0EA5A4),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
                  ),
                  child: const Icon(Icons.swap_vert, color: Colors.white, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashedLine() {
    return SizedBox(
      height: 64,
      width: 2,
      child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Container(width: 2, height: 4, color: const Color(0xFF0EA5A4)),
          );
        },
      ),
    );
  }

  Widget _buildLocationDetail({required String label, required Color labelColor, required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: labelColor, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {}, // Action to change
          child: const Text('Change', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildToggleRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.sync, color: Color(0xFF64748B), size: 20),
                SizedBox(width: 12),
                Text('Same as pickup', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            CupertinoSwitch(
              value: _sameAsPickup,
              activeColor: const Color(0xFF0EA5A4),
              onChanged: (val) => setState(() => _sameAsPickup = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedCombinations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saved combinations', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {},
                child: const Text('View all', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildCombinationCard('Home', 'Work', 'Home → Work', 'Standard Route', Icons.home, Icons.work, const Color(0xFF0EA5A4), const Color(0xFF7C3AED)),
              const SizedBox(width: 16),
              _buildCombinationCard('Work', 'Favorite', 'Work → Gym', 'Quick Drop-off', Icons.work, Icons.favorite, const Color(0xFF0EA5A4), const Color(0xFF7C3AED)),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildCombinationCard(String fromLabel, String toLabel, String title, String subtitle, IconData fromIcon, IconData toIcon, Color fromColor, Color toColor) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
                child: Icon(fromIcon, color: fromColor, size: 16),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, color: Color(0xFF64748B), size: 16),
              const SizedBox(width: 8),
              Container(
                width: 32, height: 32,
                decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
                child: Icon(toIcon, color: toColor, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF0EA5A4).withOpacity(0.1),
                foregroundColor: const Color(0xFF0EA5A4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                minimumSize: Size.zero,
              ),
              child: const Text('Use', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyUsed() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recently used', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildRecentItem('UB City, Vittal Mallya Rd', 'Ashok Nagar, Bengaluru'),
          const SizedBox(height: 16),
          _buildRecentItem('The Leela Palace', 'Old Airport Road, Kodihalli'),
        ],
      ),
    );
  }

  Widget _buildRecentItem(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9)),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.location_on, color: Color(0xFF64748B), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFE2E8E9)),
        ],
      ),
    );
  }

  Widget _buildMapVisual() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
          image: const DecorationImage(
            image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBnAMV6J5IPYIinUGFGErgwPvLKoyu9oXowtAjWs3Fc0YYl95_GrQYS5wJJXaHgzZyErnv4OAWLn8uNq4hzjWAmxZ-PfQ-BBP270P96OuDDUUROmqPEZghqfGxNaAxnEcGWehyBS2dKQ5pSmFERG9Yh2Zd9lApNXjK-6T8LXB-YoJdRkVnHwyUqFBI1AtBOqmrNafnarcpv9lZ6tkY_bFl-DeC2nEiay3FFKVekBuFYwyiQfmzzes5Nf1iyI8c4WGIYSFS6MtRT0lbr'),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withOpacity(0.2), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
            ),
            Positioned(
              bottom: 12, left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0EA5A4), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('LIVE ROUTE', style: TextStyle(color: Color(0xFF0F172A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {
            // Next step in checkout flow (e.g. Order Summary or Payment)
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0EA5A4),
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: const Color(0xFF0EA5A4).withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Continue to checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(width: 12),
              Icon(Icons.arrow_forward, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
