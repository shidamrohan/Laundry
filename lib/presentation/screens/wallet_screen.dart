import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoSwitch

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _useWallet = true;
  double _walletAmountToUse = 100;

  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Cashback from ORDER #1042',
      'date': '24 Oct',
      'amount': '+₹50',
      'isCredit': true,
      'icon': Icons.local_offer,
      'color': const Color(0xFF16A34A),
    },
    {
      'title': 'Added via UPI',
      'date': '22 Oct',
      'amount': '+₹200',
      'isCredit': true,
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFF0EA5A4),
    },
    {
      'title': 'Spent on order #1039',
      'date': '20 Oct',
      'amount': '−₹120',
      'isCredit': false,
      'icon': Icons.receipt_long,
      'color': const Color(0xFFDC2626),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // Content
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: topPadding + 64, bottom: 120),
              children: [
                const SizedBox(height: 16),
                _buildHeroCard(),
                const SizedBox(height: 24),
                _buildOrderApplication(),
                const SizedBox(height: 24),
                _buildRewardsCredits(),
                const SizedBox(height: 24),
                _buildTransactionHistory(),
                const SizedBox(height: 32),
              ],
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),
          
          // Sticky Bottom Nav
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x33E2E8E9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
                splashRadius: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              const Text('Orio Wallet', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline, color: Color(0xFF64748B)),
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF0EA5A4), Color(0xFF38BDF8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -40, top: -40,
              child: Container(
                width: 160, height: 160,
                decoration: const BoxDecoration(color: Color(0x1AFFFFFF), shape: BoxShape.circle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Total balance', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 14, fontWeight: FontWeight.w500)),
                          SizedBox(height: 4),
                          Text('₹450', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: -1.0)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildBalancePill('Cash ₹200'),
                      _buildBalancePill('Rewards 120 pts'),
                      _buildBalancePill('Referral ₹80'),
                      _buildBalancePill('Cashback ₹50'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0EA5A4),
                            elevation: 8,
                            shadowColor: const Color(0x1A0F172A),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Add money', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Color(0x66FFFFFF), width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Redeem points', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalancePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0x26FFFFFF), // white/15
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0x1AFFFFFF)), // white/10
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildOrderApplication() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Use in this order', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('Apply ₹100 to current order', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                  ],
                ),
                CupertinoSwitch(
                  value: _useWallet,
                  activeColor: const Color(0xFF0EA5A4),
                  onChanged: (val) => setState(() => _useWallet = val),
                ),
              ],
            ),
            if (_useWallet) ...[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('AMOUNT TO USE', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  Text('₹${_walletAmountToUse.toInt()}', style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 8),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: const Color(0xFF0EA5A4),
                  inactiveTrackColor: const Color(0xFFEFF6F6),
                  thumbColor: const Color(0xFF0EA5A4),
                  overlayColor: const Color(0x330EA5A4),
                  trackHeight: 8,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12, elevation: 4, pressedElevation: 8),
                ),
                child: Slider(
                  value: _walletAmountToUse,
                  min: 0,
                  max: 100, // Max applicable
                  onChanged: (val) => setState(() => _walletAmountToUse = val),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('₹0', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500)),
                  Text('Max applicable ₹100', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsCredits() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('Rewards & credits', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0x66E2E8E9)),
                    boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.card_giftcard, color: Color(0xFF0EA5A4), size: 24),
                      SizedBox(height: 8),
                      Text('Gift balance', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text('₹0', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0x66E2E8E9)),
                    boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.group_add, color: Color(0xFF7C3AED), size: 24),
                      const SizedBox(height: 8),
                      const Text('Referral credits', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: const [
                          Text('₹80', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Text('invite more', style: TextStyle(color: Color(0xFF2563EB), fontSize: 11, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text('Transaction history', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Text('View all', style: TextStyle(color: Color(0xFF2563EB), fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Column(
              children: List.generate(_transactions.length, (index) {
                final transaction = _transactions[index];
                final isLast = index == _transactions.length - 1;
                return Container(
                  decoration: BoxDecoration(
                    border: isLast ? null : const Border(bottom: BorderSide(color: Color(0x4DE2E8E9))),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: isLast ? const BorderRadius.vertical(bottom: Radius.circular(24)) : (index == 0 ? const BorderRadius.vertical(top: Radius.circular(24)) : BorderRadius.zero),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 48, height: 48,
                            decoration: BoxDecoration(color: transaction['color'].withOpacity(0.1), shape: BoxShape.circle),
                            child: Icon(transaction['icon'], color: transaction['color'], size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(transaction['title'], style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 2),
                                Text(transaction['date'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                              ],
                            ),
                          ),
                          Text(transaction['amount'], style: TextStyle(color: transaction['color'], fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

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
            _buildNavItem(Icons.home, 'Home', false),
            _buildNavItem(Icons.local_laundry_service, 'Orders', false),
            _buildNavItem(Icons.account_balance_wallet, 'Wallet', true),
            _buildNavItem(Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
