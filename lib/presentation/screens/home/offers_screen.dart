import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/profile/membership_screen.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // ── MAIN CONTENT ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: topPadding + 64 + 16)),

              // ── HERO BANNER ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildHeroBanner(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── PROMOTIONS LIST ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildPromoCard(
                        icon: Icons.celebration,
                        iconColor: const Color(0xFF0EA5A4),
                        title: 'Festival Discounts — up to 40% off',
                        desc: 'Celebrate the season with sparkling clean clothes. Applicable on all dry cleaning services.',
                        badgeText: 'Eligible',
                        badgeColor: const Color(0xFF16A34A),
                        bottomLeftText: 'Code: FEST40',
                        bottomLeftColor: const Color(0xFF0EA5A4),
                      ),
                      const SizedBox(height: 16),
                      _buildPromoCard(
                        icon: Icons.weekend,
                        iconColor: const Color(0xFF7C3AED),
                        title: 'Weekend Offers — every Sat & Sun',
                        desc: 'Special priority slots and free express delivery for weekend bookings.',
                        badgeText: 'Members only',
                        badgeColor: const Color(0xFF7C3AED),
                        bottomLeftText: 'Auto-applied',
                        bottomLeftColor: const Color(0xFF7C3AED),
                      ),
                      const SizedBox(height: 16),
                      _buildPromoCard(
                        icon: Icons.account_balance_wallet,
                        iconColor: const Color(0xFFF59E0B),
                        title: 'Cashback — 10% back to wallet',
                        desc: 'Get money back on every order above ₹500. No cap on rewards.',
                        badgeText: 'Eligible',
                        badgeColor: const Color(0xFF16A34A),
                        bottomLeftText: 'No Code Needed',
                        bottomLeftColor: const Color(0xFF0EA5A4),
                      ),
                      const SizedBox(height: 16),
                      _buildPromoCard(
                        icon: Icons.local_laundry_service,
                        iconColor: const Color(0xFF0EA5A4),
                        title: 'Combo Offers — wash + iron bundles',
                        desc: 'Save ₹150 on our popular Wash & Iron combo. Perfect for daily wear.',
                        badgeText: 'Eligible',
                        badgeColor: const Color(0xFF16A34A),
                        bottomLeftText: 'Code: COMBO150',
                        bottomLeftColor: const Color(0xFF0EA5A4),
                      ),
                      const SizedBox(height: 16),
                      _buildHotPromoCard(),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── MEMBERSHIP BANNER ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildMembershipBanner(),
                ),
              ),

              // Bottom spacing for nav
              SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 100)),
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

  // ─────────────────────── HEADER ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(4, topPadding, 4, 0),
      height: topPadding + 64,
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Offers & Rewards',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HERO BANNER ───────────────────────

  Widget _buildHeroBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0EA5A4).withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('FLASH SALE LIVE',
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          ),
          const SizedBox(height: 12),
          const Text('Fresh Clothes, Fresh Savings!',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 8),
          Text('Get flat 50% off on your first same-day delivery. Valid for next 2 hours.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13, height: 1.4)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF0EA5A4),
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Claim Now', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── PROMO CARDS ───────────────────────

  Widget _buildPromoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String desc,
    required String badgeText,
    required Color badgeColor,
    required String bottomLeftText,
    required Color bottomLeftColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold, height: 1.2))),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(color: badgeColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                      child: Text(badgeText.toUpperCase(), style: TextStyle(color: badgeColor, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.3)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(bottomLeftText, style: TextStyle(color: bottomLeftColor, fontSize: 12, fontWeight: FontWeight.w600)),
                    Row(
                      children: const [
                        Text('Details', style: TextStyle(color: Color(0xFF2563EB), fontSize: 13, fontWeight: FontWeight.bold)),
                        SizedBox(width: 2),
                        Icon(Icons.chevron_right, color: Color(0xFF2563EB), size: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotPromoCard() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.3), width: 2),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.timer, color: Color(0xFFDC2626), size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: Text('Limited-Time Deals', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold, height: 1.2))),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFFDC2626).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.alarm, color: Color(0xFFDC2626), size: 12),
                              SizedBox(width: 4),
                              Text('00:45:12', style: TextStyle(color: Color(0xFFDC2626), fontSize: 9, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Exclusive flash discount for our top users. Get a free shirt wash today!', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.3)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Claim within 1hr', style: TextStyle(color: Color(0xFFDC2626), fontSize: 12, fontWeight: FontWeight.w600)),
                        Row(
                          children: const [
                            Text('Details', style: TextStyle(color: Color(0xFF2563EB), fontSize: 13, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2),
                            Icon(Icons.chevron_right, color: Color(0xFF2563EB), size: 16),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0, right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFF0EA5A4), // Using primary color for HOT badge as per HTML
              borderRadius: BorderRadius.only(topRight: Radius.circular(14), bottomLeft: Radius.circular(14)),
            ),
            child: const Text('HOT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          ),
        ),
      ],
    );
  }

  // ─────────────────────── MEMBERSHIP ───────────────────────

  Widget _buildMembershipBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF7C3AED).withValues(alpha: 0.2), // dashed-like visual style in HTML
          width: 2,
        ), // Flutter doesn't have native dashed borders, so we use a solid tinted border here
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('VOSHIFY GOLD', style: TextStyle(color: Color(0xFF7C3AED), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                SizedBox(height: 4),
                Text('Unlock 15 more offers', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('Join the premium club for exclusive rewards.', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MembershipScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF7C3AED).withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Upgrade', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

}
