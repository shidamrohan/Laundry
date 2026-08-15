import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({super.key});

  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Transaction Details',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Color(0xFF0EA5A4)),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE2E8E9)),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            children: [
              _buildHeroStatus(),
              const SizedBox(height: 4),
              _buildDetailsCard(),
              const SizedBox(height: 16),
              _buildSupportCard(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 32),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  // ─────────────────────── HERO STATUS ───────────────────────

  Widget _buildHeroStatus() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          // Pulsing success circle
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0x1A16A34A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 48),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Paid for laundry order',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            '−₹844.00',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 40,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF16A34A),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'SUCCESS',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Jul 19, 2026 · 2:42 PM',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────── DETAILS CARD ───────────────────────

  Widget _buildDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildDetailRow('Transaction ID',
                    child: Text('TXN9F2K10', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'monospace', letterSpacing: 0.5))),
                const SizedBox(height: 20),
                _buildDetailRow('Order number',
                    child: Text('#ORIO1042', style: const TextStyle(color: Color(0xFF2563EB), fontSize: 14, fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                _buildDetailRow('Service',
                    child: Text('Wash & Fold · Priority', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600))),
                const SizedBox(height: 20),
                _buildDetailRow('Payment method',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.account_balance_wallet, color: Color(0xFF0EA5A4), size: 20),
                        SizedBox(width: 8),
                        Text('Orio Wallet', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
                      ],
                    )),

                const SizedBox(height: 24),
                const Divider(color: Color(0xFFE2E8E9), height: 1),
                const SizedBox(height: 24),

                _buildDetailRow('Wallet balance before',
                    child: Text('₹2,094', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w500))),
                const SizedBox(height: 20),
                _buildDetailRow('Wallet balance after',
                    child: Text('₹1,250', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w500))),
                const SizedBox(height: 20),
                _buildDetailRow('GST (18%)',
                    child: Text('₹47', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w500))),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6F6),
              border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Refund: Not applicable',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, {required Widget child}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(width: 16),
        Flexible(child: child),
      ],
    );
  }

  // ─────────────────────── SUPPORT CARD ───────────────────────

  Widget _buildSupportCard() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0x1A0EA5A4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent, color: Color(0xFF0EA5A4), size: 22),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Text(
                'Need help with this transaction?',
                style: TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 22),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── ACTION BUTTONS ───────────────────────

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Download receipt
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6F6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8E9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.download, color: Color(0xFF0F172A), size: 20),
                SizedBox(width: 8),
                Text('Download receipt', style: TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Share
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.share, color: Color(0xFF64748B), size: 20),
                SizedBox(width: 8),
                Text('Share', style: TextStyle(color: Color(0xFF64748B), fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),
        const Divider(color: Color(0xFFE2E8E9), height: 1),
        const SizedBox(height: 16),

        // Report issue link
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Report an issue',
            style: TextStyle(
              color: Color(0xFF0EA5A4),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF0EA5A4),
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────── BOTTOM NAV ───────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
        Icon(isActive ? filledIcon : outlinedIcon,
            color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
              color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            )),
      ],
    );
  }
}
