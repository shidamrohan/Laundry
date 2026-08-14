import 'package:flutter/material.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  String _selectedFrequency = 'weekly';
  String _selectedPlan = 'personal';

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
              SliverToBoxAdapter(child: SizedBox(height: topPadding + 64 + 16)),

              // ── INTRO ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Laundry on autopilot.', style: TextStyle(color: Color(0xFF0F172A), fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
                      SizedBox(height: 4),
                      Text('Set your schedule and let Orio handle the rest every single week.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── FREQUENCY SELECTOR ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildFrequencySelector(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── PLAN SELECTION (Horizontal) ──
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildPlanCard(
                        id: 'personal',
                        title: 'Personal',
                        subtitle: '1 bag / week',
                        price: '₹599',
                        icon: Icons.shopping_bag_outlined,
                      ),
                      const SizedBox(width: 16),
                      _buildPlanCard(
                        id: 'family',
                        title: 'Family',
                        subtitle: '3 bags / week',
                        price: '₹1,499',
                        icon: Icons.local_mall_outlined,
                        isPopular: true,
                      ),
                      const SizedBox(width: 16),
                      _buildPlanCard(
                        id: 'corporate',
                        title: 'Corporate',
                        subtitle: 'Custom volume',
                        price: 'Custom Pricing',
                        priceLabel: 'Billed monthly',
                        icon: Icons.corporate_fare_outlined,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── PLAN SUMMARY ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildPlanSummary(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── MANAGEMENT ACTIONS ──
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildActionBtn(Icons.pause_circle_outline, 'Pause'),
                      const SizedBox(width: 8),
                      _buildActionBtn(Icons.play_circle_outline, 'Resume'),
                      const SizedBox(width: 8),
                      _buildActionBtn(Icons.settings_suggest_outlined, 'Modify plan'),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── TIMELINE ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildTimeline(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── PROMO CARD ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildPromoCard(),
                ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 120)), // Space for footer
            ],
          ),

          // ── HEADER ──
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),

          // ── FOOTER CTA ──
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildFooterCTA(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      padding: EdgeInsets.fromLTRB(4, topPadding, 4, 0),
      height: topPadding + 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 24),
                splashRadius: 22,
              ),
              const SizedBox(width: 4),
              const Text(
                'Subscriptions',
                style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Color(0xFF0F172A), size: 24),
            splashRadius: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencySelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(child: _buildFreqTab('Weekly', 'weekly')),
          Expanded(child: _buildFreqTab('Biweekly', 'biweekly')),
          Expanded(child: _buildFreqTab('Monthly', 'monthly')),
        ],
      ),
    );
  }

  Widget _buildFreqTab(String label, String value) {
    final isActive = _selectedFrequency == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedFrequency = value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive ? const [BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1))] : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String id,
    required String title,
    required String subtitle,
    required String price,
    String? priceLabel,
    required IconData icon,
    bool isPopular = false,
  }) {
    final isActive = _selectedPlan == id;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = id),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
            width: isActive ? 2 : 1,
          ),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (isPopular)
              Positioned(
                top: -30, left: 0, right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(20)),
                    child: const Text('POPULAR', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  ),
                ),
              ),
            if (isActive)
              Positioned(
                top: -8, right: -8,
                child: const Icon(Icons.check_circle, color: Color(0xFF0EA5A4), size: 24),
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: const Color(0xFF0EA5A4), size: 24),
                ),
                const SizedBox(height: 16),
                Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(price, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.w800)),
                    if (priceLabel == null)
                      const Text('/mo', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                  ],
                ),
                if (priceLabel != null)
                  Text(priceLabel, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    id == 'corporate' ? 'Contact us' : 'Choose',
                    style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFF0F172A),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Active Selection Details', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8E9)),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Column(
            children: [
              _buildInfoRow(Icons.calendar_today, 'PICKUP SCHEDULE', 'Every Mon & Thu, 9–11 AM'),
              const SizedBox(height: 16),
              _buildInfoRow(Icons.schedule, 'DELIVERY WINDOW', 'Within 24 hours of pickup'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(color: Color(0xFFE2E8E9), height: 1),
              ),
              _buildCostRow('Base Plan Price', '₹570.48', false),
              const SizedBox(height: 8),
              _buildCostRow('GST (5%)', '₹28.52', false),
              const SizedBox(height: 12),
              _buildCostRow('Monthly Total', '₹599.00', true),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: const Color(0xFF16A34A).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.eco, color: Color(0xFF16A34A), size: 16),
                    SizedBox(width: 8),
                    Text('Estimated savings ₹300/mo', style: TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: const Color(0xFF64748B), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCostRow(String label, String amount, bool isTotal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: isTotal ? const Color(0xFF0F172A) : const Color(0xFF64748B), fontSize: isTotal ? 16 : 13, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500)),
        Text(amount, style: TextStyle(color: const Color(0xFF0F172A), fontSize: isTotal ? 16 : 13, fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500)),
      ],
    );
  }

  Widget _buildActionBtn(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upcoming deliveries', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTimelineItem('Oct 24, Thursday', 'Expected delivery by 6:00 PM', true, isLast: false),
        _buildTimelineItem('Oct 27, Monday', 'Scheduled Pickup', false, isLast: false),
        _buildTimelineItem('Oct 30, Thursday', 'Scheduled Pickup', false, isLast: true),
      ],
    );
  }

  Widget _buildTimelineItem(String date, String desc, bool isDone, {required bool isLast}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(
                  color: isDone ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 2)],
                ),
                child: isDone ? const Icon(Icons.check, color: Colors.white, size: 12) : Center(child: Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF94A3B8), shape: BoxShape.circle))),
              ),
              if (!isLast)
                Expanded(child: Container(width: 2, color: const Color(0xFFE2E8E9))),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(desc, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            right: -30, bottom: -40,
            child: Transform.rotate(
              angle: 0.2,
              child: const Icon(Icons.card_giftcard, color: Color(0x1AFFFFFF), size: 120),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Refer & Get Free Bag', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Invite friends to Orio and get 1 extra bag credit for every successful referral.', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13, height: 1.4)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0EA5A4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Share Code', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterCTA() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0A000000), blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0EA5A4),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Start subscription', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
