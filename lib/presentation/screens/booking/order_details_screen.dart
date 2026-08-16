import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  static const _primary = Color(0xFF0EA5A4);

  static const _secondary = Color(0xFF2563EB);
  static const _accent = Color(0xFF7C3AED);
  static const _success = Color(0xFF16A34A);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: _surface,
        elevation: 1,
        scrolledUnderElevation: 1,
        shadowColor: const Color(0x140F172A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primary),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'Order details',
          style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.3),
        ),
      ),
      body: Stack(
        children: [
          // Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 110),
              child: Column(
                children: [
                  _buildStatusCard(),
                  const SizedBox(height: 16),
                  _buildTimelineCard(),
                  const SizedBox(height: 16),
                  _buildAddressBlock(),
                  const SizedBox(height: 16),
                  _buildPaymentSummary(),
                  const SizedBox(height: 16),
                  _buildDecorativeImage(),
                ],
              ),
            ),
          ),

          // Sticky Bottom Bar
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomBar(),
          ),
        ],
      ),
    );
  }

  // --- Status Card ---
  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _surfaceAlt,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: const Text('DELIVERED', style: TextStyle(color: _primary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    ),
                    const SizedBox(height: 8),
                    const Text('Order #ORIO1042', style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('19 Jul 2026', style: TextStyle(color: _textSecondary, fontSize: 14)),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 16, color: _secondary),
                label: const Text('Invoice', style: TextStyle(color: _secondary, fontSize: 13, fontWeight: FontWeight.w600)),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _surfaceAlt.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _primary.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.local_laundry_service, color: _primary, size: 24),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wash & Fold · Priority', style: TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('6 items · 4.5 kg', style: TextStyle(color: _textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Timeline Card ---
  Widget _buildTimelineCard() {
    final steps = [
      _TimelineStep(label: 'Order placed', time: '10:30 AM', isLast: false, isCompleted: true),
      _TimelineStep(label: 'Picked up', time: '12:45 PM', isLast: false, isCompleted: true),
      _TimelineStep(label: 'Cleaning', time: '4:20 PM', isLast: false, isCompleted: true),
      _TimelineStep(label: 'Out for delivery', time: '10:15 AM, 19 Jul', isLast: false, isCompleted: true),
      _TimelineStep(label: 'Delivered', time: '1:30 PM, 19 Jul', isLast: true, isCompleted: true, isCurrentStep: true),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ORDER JOURNEY', style: TextStyle(color: _textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 24),
          Column(
            children: steps.map((step) => _buildTimelineStep(step)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(_TimelineStep step) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: dot + connector
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    color: step.isCompleted ? _primary : _divider,
                    shape: BoxShape.circle,
                    boxShadow: step.isCompleted
                        ? [BoxShadow(color: _primary.withValues(alpha: 0.25), blurRadius: 8, spreadRadius: 2)]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
                if (!step.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: _primary,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Right: label + time
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: step.isLast ? 0 : 24, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    step.label,
                    style: TextStyle(
                      color: step.isCurrentStep ? _primary : _textPrimary,
                      fontSize: 15,
                      fontWeight: step.isCurrentStep ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  Text(step.time, style: const TextStyle(color: _textSecondary, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Address Block ---
  Widget _buildAddressBlock() {
    return Container(
      decoration: _cardDecoration(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildAddressRow(
            icon: Icons.home,
            iconColor: _primary,
            label: 'PICKUP ADDRESS',
            labelColor: _primary,
            title: 'Home',
            subtitle: 'Apt 4B, Emerald Heights, Marine Drive, Mumbai - 400002',
          ),
          const Divider(color: _divider, height: 1, indent: 20, endIndent: 20),
          _buildAddressRow(
            icon: Icons.work,
            iconColor: _accent,
            label: 'DELIVERY ADDRESS',
            labelColor: _accent,
            title: 'Office',
            subtitle: 'Tech Hub, 12th Floor, Wing C, BKC, Mumbai - 400051',
          ),
        ],
      ),
    );
  }

  Widget _buildAddressRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required Color labelColor,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: _surfaceAlt, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: labelColor, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: _textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Payment Summary ---
  Widget _buildPaymentSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PAYMENT SUMMARY', style: TextStyle(color: _textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 16),
          _billRow('Item total', '₹948'),
          _billRow('Pickup fee', '₹0'),
          _billRow('Delivery fee', 'FREE', valueColor: _success, bold: true),
          _billRow('Platform fee', '₹5'),
          _billRow('Taxes', '₹47'),
          _billRowWithBadge('Coupon', 'FRESH50', '-₹150', valueColor: _success),
          _billRow('Orio Wallet', '-₹100', valueColor: _primary, bold: true),
          const SizedBox(height: 8),
          const Divider(color: _divider),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Grand total', style: TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
              Text('₹750', style: TextStyle(color: _primary, fontSize: 20, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: _divider, height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.account_balance_wallet, color: _textSecondary, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Paid via Orio Wallet + UPI', style: TextStyle(color: _textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              const Icon(Icons.check_circle, color: _success, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value, {Color? valueColor, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: _textSecondary, fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? _textPrimary,
              fontSize: 14,
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _billRowWithBadge(String label, String badge, String value, {required Color valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(label, style: const TextStyle(color: _textSecondary, fontSize: 14)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(badge, style: const TextStyle(color: _success, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Text(value, style: TextStyle(color: valueColor, fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- Decorative Image ---
  Widget _buildDecorativeImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 128,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDarnelu43U5-1e0_lSymoMz3bho5hqtQtrVXKBHULPUK9pgJhtBPyDeHvbjD-a-S9pmSdjuHVC1k-Xn1yL09hv2tUMWxA8uHi1w3GfsaqXPPHGAA_eGsjuqSuILLmr5-6pNPlCdlnjWCYpHXcgXICGJVhQDewuoIExhLJM71EQpR5WdVigafDzFW6ZfeV67lGo5pPKmnujAT4GxkcZ6G73aoU2hpG1KRju_uxY0iVR8In_mVa-GDHLIuz7XURuIKPjewgu-XRUDyvF',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: _surfaceAlt),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0x660F172A)],
                ),
              ),
            ),
            Positioned(
              bottom: 12, left: 16, right: 16,
              child: const Text(
                'Your clothes were treated with eco-friendly Orio Bio-Wash.',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Sticky Bottom Bar ---
  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        border: const Border(top: BorderSide(color: Color(0x33E2E8E9))),
        boxShadow: const [BoxShadow(color: Color(0x100F172A), blurRadius: 12, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Get support
              Expanded(
                child: SizedBox(
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.contact_support_outlined, size: 20),
                    label: const Text('Get support'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0x330EA5A4), width: 2),
                      foregroundColor: _primary,
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Reorder
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh, size: 20),
                    label: const Text('Reorder'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      foregroundColor: Colors.white,
                      elevation: 6,
                      shadowColor: _primary.withValues(alpha: 0.35),
                      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: _surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: _divider.withValues(alpha: 0.5)),
      boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
    );
  }
}

class _TimelineStep {
  const _TimelineStep({
    required this.label,
    required this.time,
    required this.isLast,
    required this.isCompleted,
    this.isCurrentStep = false,
  });
  final String label;
  final String time;
  final bool isLast;
  final bool isCompleted;
  final bool isCurrentStep;
}
