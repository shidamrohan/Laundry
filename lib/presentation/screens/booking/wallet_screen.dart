import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/wallet_history_screen.dart';
import 'package:laundry/presentation/screens/booking/wallet_settings_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Laundry Cashback',
      'date': 'May 24, 2024',
      'amount': '+ ₹45.00',
      'isCredit': true,
      'icon': Icons.payments,
      'bgColor': const Color(0xFFECFDF5),
      'iconColor': const Color(0xFF16A34A),
    },
    {
      'title': 'Premium Wash & Fold',
      'date': 'May 22, 2024',
      'amount': '- ₹420.00',
      'isCredit': false,
      'icon': Icons.local_laundry_service,
      'bgColor': const Color(0xFFFEF2F2),
      'iconColor': const Color(0xFFDC2626),
    },
    {
      'title': 'Added to Wallet',
      'date': 'May 20, 2024',
      'amount': '+ ₹500.00',
      'isCredit': true,
      'icon': Icons.account_balance,
      'bgColor': const Color(0xFFECFDF5),
      'iconColor': const Color(0xFF16A34A),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // Scrollable body
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: topPadding + 64, bottom: 100),
              children: [
                const SizedBox(height: 20),
                _buildHeroCard(),
                const SizedBox(height: 24),
                _buildQuickActions(),
                const SizedBox(height: 24),
                _buildAlertCard(),
                const SizedBox(height: 24),
                _buildAnalyticsGrid(),
                const SizedBox(height: 24),
                _buildTransactions(),
                const SizedBox(height: 32),
              ],
            ),
          ),

          // Fixed header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),

          // Bottom nav
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HEADER ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
            padding: EdgeInsets.fromLTRB(8, topPadding, 8, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: SizedBox(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            ),
            const Text('Wallet', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.w600)),
            IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletSettingsScreen())),
              icon: const Icon(Icons.help_outline, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── HERO BALANCE CARD ───────────────────────

  Widget _buildHeroCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
        ),
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              right: -20, top: -20,
              child: Container(width: 120, height: 120, decoration: const BoxDecoration(color: Color(0x1AFFFFFF), shape: BoxShape.circle)),
            ),
            Positioned(
              left: -30, bottom: -30,
              child: Container(width: 100, height: 100, decoration: const BoxDecoration(color: Color(0x0DFFFFFF), shape: BoxShape.circle)),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Available balance', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 14, fontWeight: FontWeight.w500)),
                          SizedBox(height: 4),
                          Text('₹1,250.00', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: -1.0)),
                          SizedBox(height: 4),
                          Text('Last updated just now', style: TextStyle(color: Color(0x99FFFFFF), fontSize: 11)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0EA5A4),
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Add money', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildGlassPill(Icons.redeem, 'Cashback ₹200'),
                        const SizedBox(width: 8),
                        _buildGlassPill(Icons.stars, 'Rewards 120 pts'),
                        const SizedBox(width: 8),
                        _buildGlassPill(Icons.group, 'Referral ₹80'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassPill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x26FFFFFF),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0x1AFFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // ─────────────────────── QUICK ACTIONS ───────────────────────

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildActionItem(Icons.send, 'Send')),
          Expanded(child: _buildActionItem(Icons.loyalty, 'Redeem')),
          Expanded(child: _buildActionItem(Icons.swap_horiz, 'Transfer')),
          Expanded(child: _buildDisabledActionItem(Icons.qr_code_scanner, 'Scan QR\n(soon)')),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
          child: Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6F6),
              shape: BoxShape.circle,
              boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Icon(icon, color: const Color(0xFF0EA5A4), size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildDisabledActionItem(IconData icon, String label) {
    return Opacity(
      opacity: 0.5,
      child: Column(
        children: [
          Container(
            width: 56, height: 56,
            decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
            child: Icon(icon, color: const Color(0xFF0EA5A4), size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w600, height: 1.3),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── ALERT CARD ───────────────────────

  Widget _buildAlertCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFDE68A)),
          boxShadow: const [BoxShadow(color: Color(0x060F172A), blurRadius: 4, offset: Offset(0, 1))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFFDE68A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notification_important, color: Color(0xFFF59E0B), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('₹50 rewards expire in 5 days', style: TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                    child: const Text('Use now', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFFDE68A), size: 24),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── ANALYTICS GRID ───────────────────────

  Widget _buildAnalyticsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text('ANALYTICS', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildStatCard('Total cashback earned', '₹640', const Color(0xFF0EA5A4)),
              _buildStatCard('Lifetime savings', '₹2,480', const Color(0xFF0EA5A4)),
              _buildStatCard('Laundry rewards', '120', const Color(0xFF7C3AED)),
              _buildStatCard('This month spent', '₹890', const Color(0xFF0F172A)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x66E2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: valueColor, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ─────────────────────── TRANSACTIONS ───────────────────────

  Widget _buildTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text('RECENT TRANSACTIONS', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletHistoryScreen())),
                child: const Text('See all', style: TextStyle(color: Color(0xFF2563EB), fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Column(
              children: List.generate(_transactions.length, (index) {
                final tx = _transactions[index];
                final isLast = index == _transactions.length - 1;
                return Column(
                  children: [
                    InkWell(
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                      borderRadius: BorderRadius.vertical(
                        top: index == 0 ? const Radius.circular(12) : Radius.zero,
                        bottom: isLast ? const Radius.circular(12) : Radius.zero,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(color: tx['bgColor'], shape: BoxShape.circle),
                              child: Icon(tx['icon'], color: tx['iconColor'], size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tx['title'], style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 2),
                                  Text(tx['date'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                                ],
                              ),
                            ),
                            Text(
                              tx['amount'],
                              style: TextStyle(
                                color: tx['isCredit'] ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (!isLast)
                      const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFE2E8E9)),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── BOTTOM NAV ───────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, -4))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home', false),
            _buildNavItem(Icons.local_laundry_service_outlined, Icons.local_laundry_service, 'Orders', false),
            _buildNavItem(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Wallet', true),
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
        Icon(isActive ? filledIcon : outlinedIcon, color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
