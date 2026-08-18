import 'package:flutter/material.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  String _selectedBilling = 'annual'; // 'monthly', 'quarterly', 'annual'

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // ── MAIN CONTENT ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: topPadding + 64 + 24)),

              // ── HERO CARD ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildHeroCard(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── BILLING TOGGLE ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildBillingToggle(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── PRICING GRID ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildPricingGrid(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── BENEFITS ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildBenefits(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── SAVINGS CARD ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _buildSavingsCard(),
                ),
              ),
              
              // Disclaimer
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Text(
                    'Membership automatically renews. Cancel anytime in settings. Terms and conditions apply.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                  ),
                ),
              ),

              // Spacing for sticky footer
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          // ── HEADER ──
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),

          // ── STICKY FOOTER CTA ──
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildFooterCTA(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HEADER ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, topPadding, 8, 0),
      height: topPadding + 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
                splashRadius: 22,
              ),
              const SizedBox(width: 8),
              const Text(
                'VOSHIFY Plus',
                style: TextStyle(
                  color: Color(0xFF0EA5A4),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline, color: Color(0xFF64748B), size: 24),
            splashRadius: 22,
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HERO CARD ───────────────────────

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF0EA5A4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0EA5A4).withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Bubble effect
          Positioned(
            top: -60, right: -60,
            child: Container(
              width: 150, height: 150,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.workspace_premium, color: Colors.white, size: 28),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('SAVE UP TO ₹2,400/YR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Unlock VOSHIFY Plus', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800, height: 1.1)),
              const SizedBox(height: 12),
              Text('Get exclusive benefits and save more on every order you place with India\'s cleanest laundry service.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 14, height: 1.4)),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────── BILLING TOGGLE ───────────────────────

  Widget _buildBillingToggle() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabBtn('Monthly', 'monthly')),
          Expanded(child: _buildTabBtn('Quarterly', 'quarterly')),
          Expanded(child: _buildTabBtn('Annual', 'annual', hasBadge: true)),
        ],
      ),
    );
  }

  Widget _buildTabBtn(String label, String value, {bool hasBadge = false}) {
    final isActive = _selectedBilling == value;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedBilling = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive ? const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 4, offset: Offset(0, 2))] : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (hasBadge)
              Positioned(
                top: -20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFF7C3AED), borderRadius: BorderRadius.circular(10)),
                  child: const Text('-20% BEST VALUE', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── PRICING GRID ───────────────────────

  Widget _buildPricingGrid() {
    // In Flutter, to make the middle card pop out, we use a Row with different heights/alignments.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Monthly
        Expanded(
          child: _buildPriceCard(
            title: 'Monthly',
            price: '₹149',
            period: '/mo',
            isActive: _selectedBilling == 'monthly',
          ),
        ),
        const SizedBox(width: 8),
        // Annual
        Expanded(
          flex: 5,
          child: _buildPriceCard(
            title: 'Annual',
            price: '₹999',
            period: '/yr',
            subText: '~₹83 per month',
            isFeatured: true,
            isActive: _selectedBilling == 'annual',
          ),
        ),
        const SizedBox(width: 8),
        // Quarterly
        Expanded(
          child: _buildPriceCard(
            title: 'Quarterly',
            price: '₹399',
            period: '/qtr',
            isActive: _selectedBilling == 'quarterly',
          ),
        ),
      ],
    );
  }

  Widget _buildPriceCard({
    required String title,
    required String price,
    required String period,
    String? subText,
    bool isFeatured = false,
    bool isActive = false,
  }) {
    // Standardizing dimensions for the side cards vs featured center card
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.all(isFeatured ? 24 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFeatured ? const Color(0xFF0EA5A4) : (isActive ? const Color(0xFF0EA5A4).withValues(alpha: 0.5) : const Color(0xFFE2E8E9)),
          width: isFeatured ? 2 : 1,
        ),
        boxShadow: isFeatured ? [BoxShadow(color: const Color(0xFF0EA5A4).withValues(alpha: 0.15), blurRadius: 16)] : const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8)],
      ),
      child: Column(
        children: [
          if (isFeatured)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(12)),
              child: const Text('MOST POPULAR', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
            ),
          Text(title.toUpperCase(), style: TextStyle(color: isFeatured ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(price, style: TextStyle(color: const Color(0xFF0F172A), fontSize: isFeatured ? 28 : 20, fontWeight: FontWeight.w800)),
              Text(period, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
            ],
          ),
          if (subText != null) ...[
            const SizedBox(height: 6),
            Text(subText, style: const TextStyle(color: Color(0xFF0B7F7E), fontSize: 10, fontWeight: FontWeight.bold)),
          ]
        ],
      ),
    );
  }

  // ─────────────────────── BENEFITS ───────────────────────

  Widget _buildBenefits() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Premium Benefits', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildBenefitItem('Priority pickup from your doorstep'),
          _buildBenefitItem('Faster express delivery at no extra cost'),
          _buildBenefitItem('4 free express washes every month'),
          _buildBenefitItem('Extra 20% off on all specialized services'),
          _buildBenefitItem('Dedicated support line for Plus members'),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.check_circle, color: Color(0xFF0EA5A4), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  // ─────────────────────── SAVINGS CARD ───────────────────────

  Widget _buildSavingsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Projected Annual Savings', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    text: '₹2,400 ',
                    style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 24, fontWeight: FontWeight.bold),
                    children: [TextSpan(text: 'this year', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.normal))],
                  ),
                ),
                const SizedBox(height: 12),
                Stack(
                  children: [
                    Container(height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(3))),
                    FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Container(height: 6, decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(3))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 4)]),
            child: const Icon(Icons.savings_outlined, color: Color(0xFF0EA5A4), size: 32),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── FOOTER CTA ───────────────────────

  Widget _buildFooterCTA() {
    String ctaPrice = '₹999/yr';
    if (_selectedBilling == 'monthly') ctaPrice = '₹149/mo';
    if (_selectedBilling == 'quarterly') ctaPrice = '₹399/qtr';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [const Color(0xFFF7FAFB), const Color(0xFFF7FAFB).withValues(alpha: 0.0)],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0EA5A4),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0xFF0EA5A4).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 20),
          minimumSize: const Size(double.infinity, 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Join VOSHIFY Plus — $ctaPrice', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}
