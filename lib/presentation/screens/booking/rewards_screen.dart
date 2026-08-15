import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _selectedCategory = 0;
  final List<bool> _expanded = [false, false, false];

  final List<String> _categories = [
    'Cashback',
    'Referral',
    'Promo credits',
    'Membership',
    'Laundry Coins',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7FAFB),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Rewards',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: -0.3)),
        centerTitle: true,
        actions: const [SizedBox(width: 48)],
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
            children: [
              _buildHeroCard(),
              const SizedBox(height: 28),
              _buildCategoryChips(),
              const SizedBox(height: 28),
              _buildRewardCard(
                index: 0,
                icon: Icons.account_balance_wallet,
                iconBg: const Color(0xFFEFF6F6),
                iconColor: const Color(0xFF0EA5A4),
                title: 'Cashback ₹200',
                badgeLabel: 'Expires 30 Jul',
                badgeBg: const Color(0xFFEFF6EF),
                badgeColor: const Color(0xFF2563EB),
                badgeBgColor: const Color(0xFFEFF6FF),
                actionLabel: 'Redeem',
                actionColor: const Color(0xFF0EA5A4),
                progressValue: 0.65,
                progressColor: const Color(0xFF0EA5A4),
                progressLabel: 'Progress to Bonus',
                progressRight: '₹300 more to unlock ₹100 bonus',
                howToUse: 'Redeem this cashback on your next order above ₹500. Not valid on dry cleaning services.',
                expandColor: const Color(0xFF0EA5A4),
              ),
              const SizedBox(height: 16),
              _buildRewardCard(
                index: 1,
                icon: Icons.person_add,
                iconBg: const Color(0xFFF5F3FF),
                iconColor: const Color(0xFF7C3AED),
                title: 'Invite & Earn ₹50',
                badgeLabel: 'No Expiry',
                badgeBg: const Color(0xFFF5F3FF),
                badgeColor: const Color(0xFF7C3AED),
                badgeBgColor: const Color(0xFFF5F3FF),
                actionLabel: 'Share',
                actionColor: const Color(0xFF7C3AED),
                progressValue: 0.40,
                progressColor: const Color(0xFF7C3AED),
                progressLabel: 'Friends Invited',
                progressRight: '2/5 Friends',
                howToUse: 'Earn ₹50 for every friend who completes their first order above ₹300 using your unique referral code.',
                expandColor: const Color(0xFF7C3AED),
              ),
              const SizedBox(height: 16),
              _buildRewardCard(
                index: 2,
                icon: Icons.local_laundry_service,
                iconBg: const Color(0xFFEFF6FF),
                iconColor: const Color(0xFF2563EB),
                title: 'Free Steam Press',
                badgeLabel: 'Expires 15 Aug',
                badgeBg: const Color(0xFFEFF6FF),
                badgeColor: const Color(0xFF2563EB),
                badgeBgColor: const Color(0xFFEFF6FF),
                actionLabel: 'Use Now',
                actionColor: const Color(0xFF2563EB),
                progressValue: null,
                progressColor: Colors.transparent,
                progressLabel: '',
                progressRight: '',
                howToUse: 'Valid on steam pressing service for up to 5 garments. Applicable on orders above ₹200.',
                expandColor: const Color(0xFF2563EB),
              ),
              const SizedBox(height: 36),
              _buildRewardHistory(),
              const SizedBox(height: 36),
              _buildPromoBanner(),
              const SizedBox(height: 12),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  // ─────────────────────── HERO CARD ───────────────────────

  Widget _buildHeroCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF0EA5A4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: 0.35), blurRadius: 24, offset: const Offset(0, 8))],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative blobs
          Positioned(
            top: -30, right: -30,
            child: Container(
              width: 140, height: 140,
              decoration: const BoxDecoration(color: Color(0x1AFFFFFF), shape: BoxShape.circle),
            ),
          ),
          Positioned(
            bottom: -30, left: -30,
            child: Container(
              width: 140, height: 140,
              decoration: const BoxDecoration(color: Color(0x1AFFFFFF), shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total Balance', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 14, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('320', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: -1)),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Coins', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1)),
                                  SizedBox(height: 2),
                                  Text('≈ ₹320 value', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 11, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Expiry badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 2))],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.timer, color: Color(0xFF0F172A), size: 14),
                          SizedBox(width: 4),
                          Text('150 pts expiring soon', style: TextStyle(color: Color(0xFF0F172A), fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: const BoxDecoration(color: Color(0x33FFFFFF), shape: BoxShape.circle),
                      child: const Icon(Icons.military_tech, color: Color(0xFFFBBF24), size: 22),
                    ),
                    const SizedBox(width: 10),
                    const Text('Silver Tier Member', style: TextStyle(color: Color(0xE6FFFFFF), fontSize: 14, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text('View Benefits', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
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

  // ─────────────────────── CATEGORY CHIPS ───────────────────────

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isSelected = i == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
                boxShadow: isSelected
                    ? [const BoxShadow(color: Color(0x330EA5A4), blurRadius: 8, offset: Offset(0, 2))]
                    : [],
              ),
              child: Text(
                _categories[i],
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
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

  // ─────────────────────── REWARD CARD ───────────────────────

  Widget _buildRewardCard({
    required int index,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String badgeLabel,
    required Color badgeBg,
    required Color badgeColor,
    required Color badgeBgColor,
    required String actionLabel,
    required Color actionColor,
    required double? progressValue,
    required Color progressColor,
    required String progressLabel,
    required String progressRight,
    required String howToUse,
    required Color expandColor,
  }) {
    final isExpanded = _expanded[index];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        border: Border.all(color: Colors.white),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(color: badgeBgColor, borderRadius: BorderRadius.circular(6)),
                            child: Text(badgeLabel.toUpperCase(), style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: actionColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [BoxShadow(color: actionColor.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))],
                        ),
                        child: Text(actionLabel, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (progressValue != null) ...[
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(progressLabel, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600)),
                Text(progressRight, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: const Color(0xFFEFF6F6),
                color: progressColor,
                minHeight: 8,
              ),
            ),
          ],

          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE2E8E9), height: 1),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => _expanded[index] = !isExpanded),
                child: Row(
                  children: [
                    Text('How to use', style: TextStyle(color: expandColor, fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.expand_more, color: expandColor, size: 18),
                    ),
                  ],
                ),
              ),
              const Text('T&C apply', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontStyle: FontStyle.italic)),
            ],
          ),

          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(howToUse, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.6)),
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── REWARD HISTORY ───────────────────────

  Widget _buildRewardHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Reward History', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {},
              child: const Text('See All', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8E9)),
            boxShadow: const [BoxShadow(color: Color(0x060F172A), blurRadius: 4, offset: Offset(0, 2))],
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _buildHistoryRow(
                icon: Icons.add_circle,
                iconBg: const Color(0xFFECFDF5),
                iconColor: const Color(0xFF16A34A),
                title: 'Referral Bonus',
                subtitle: '24 Oct 2023 • Paid to Wallet',
                amount: '+50',
                amountColor: const Color(0xFF16A34A),
                hasDivider: true,
              ),
              _buildHistoryRow(
                icon: Icons.shopping_bag,
                iconBg: const Color(0xFFEFF6F6),
                iconColor: const Color(0xFF0EA5A4),
                title: 'Order #1042 Cashback',
                subtitle: '22 Oct 2023 • Promo Credits',
                amount: '+120',
                amountColor: const Color(0xFF16A34A),
                hasDivider: true,
              ),
              _buildHistoryRow(
                icon: Icons.remove_circle,
                iconBg: const Color(0xFFF8FAFC),
                iconColor: const Color(0xFF64748B),
                title: 'Points Redeemed',
                subtitle: '18 Oct 2023 • Order #1039',
                amount: '-120',
                amountColor: const Color(0xFF0F172A),
                hasDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
    required bool hasDivider,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: hasDivider
                ? const Border(bottom: BorderSide(color: Color(0x80E2E8E9)))
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Text(amount, style: TextStyle(color: amountColor, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────── PROMO BANNER ───────────────────────

  Widget _buildPromoBanner() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Fabric texture overlay (right side)
            Positioned(
              right: 0, top: 0, bottom: 0,
              child: Container(
                width: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x00FFFFFF), Color(0x33FFFFFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upgrade to Platinum', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Earn 2x coins on every wash and get free pickup always.', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 13, height: 1.5)),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0EA5A4),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text('Join Now', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── BOTTOM NAV ───────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 16, offset: Offset(0, -4))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home', false),
            _buildNavItem(Icons.local_laundry_service_outlined, Icons.local_laundry_service, 'Orders', false),
            _buildNavItem(Icons.military_tech_outlined, Icons.military_tech, 'Rewards', true),
            _buildNavItem(Icons.person_outline, Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData outlinedIcon, IconData filledIcon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(isActive ? filledIcon : outlinedIcon,
            color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
              color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
