import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

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
        shadowColor: const Color(0x100F172A),
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
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
              child: Column(
                children: [
                  _buildStatusCard(),
                  const SizedBox(height: 16),
                  _buildServiceCard(),
                  const SizedBox(height: 16),
                  _buildTimelineCard(),
                  const SizedBox(height: 16),
                  _buildAddressGrid(),
                  const SizedBox(height: 16),
                  _buildBillSummary(),
                  const SizedBox(height: 16),
                  _buildHelpBanner(),
                ],
              ),
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
        ],
      ),
    );
  }

  // --- Status Card ---
  Widget _buildStatusCard() {
    return _Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text('DELIVERED', style: TextStyle(color: _primary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ),
                const SizedBox(height: 8),
                const Text('Order #ORIO1042', style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('19 Jul 2026', style: TextStyle(color: _textSecondary, fontSize: 14)),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download, size: 18, color: _secondary),
            label: const Text('Download invoice', style: TextStyle(color: _secondary, fontSize: 13, fontWeight: FontWeight.w600)),
            style: TextButton.styleFrom(padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ),
        ],
      ),
    );
  }

  // --- Service Details Card ---
  Widget _buildServiceCard() {
    return _Card(
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: _surfaceAlt, borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: const Icon(Icons.local_laundry_service, color: _primary, size: 28),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Wash and Fold • Priority', style: TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('6 items • 4.5 kg', style: TextStyle(color: _textSecondary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Timeline Card ---
  Widget _buildTimelineCard() {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ORDER TRACKING', style: TextStyle(color: _textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 24),
          _buildTimelineItems(),
        ],
      ),
    );
  }

  Widget _buildTimelineItems() {
    final steps = [
      (label: 'Order placed', time: '10:30 AM', active: true, isLast: false),
      (label: 'Picked up', time: '12:45 PM', active: true, isLast: false),
      (label: 'Cleaning', time: '4:20 PM', active: true, isLast: false),
      (label: 'Out for delivery', time: '10:15 AM, 19 Jul', active: true, isLast: false),
      (label: 'Delivered', time: '1:30 PM, 19 Jul', active: true, isLast: true),
    ];

    return Column(
      children: steps.asMap().entries.map((entry) {
        final step = entry.value;
        return _buildTimelineRow(
          label: step.label,
          time: step.time,
          isActive: step.active,
          isLast: step.isLast,
          isFinal: step.isLast,
        );
      }).toList(),
    );
  }

  Widget _buildTimelineRow({
    required String label,
    required String time,
    required bool isActive,
    required bool isLast,
    bool isFinal = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + line column
          SizedBox(
            width: 16,
            child: Column(
              children: [
                // Dot
                isFinal
                    ? Container(
                        width: 20, height: 20,
                        decoration: const BoxDecoration(color: _primary, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: const Icon(Icons.check, color: Colors.white, size: 12),
                      )
                    : Container(
                        width: 16, height: 16,
                        decoration: BoxDecoration(
                          color: isActive ? _primary : _divider,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [BoxShadow(color: isActive ? _primary.withValues(alpha: 0.4) : _divider, blurRadius: 0, spreadRadius: 1)],
                        ),
                      ),
                // Connector line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: _divider,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: isFinal ? _primary : _textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(time, style: const TextStyle(color: _textSecondary, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Address Grid ---
  Widget _buildAddressGrid() {
    return Row(
      children: [
        Expanded(
          child: _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('PICKUP ADDRESS', style: TextStyle(color: _textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                SizedBox(height: 8),
                Text('Home', style: TextStyle(color: _textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(
                  'Flat 402, Azure Heights, Sector 45, Gurgaon, Haryana 122003',
                  style: TextStyle(color: _textSecondary, fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('DELIVERY ADDRESS', style: TextStyle(color: _textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                SizedBox(height: 8),
                Text('Home', style: TextStyle(color: _textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text(
                  'Flat 402, Azure Heights, Sector 45, Gurgaon, Haryana 122003',
                  style: TextStyle(color: _textSecondary, fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Bill Summary ---
  Widget _buildBillSummary() {
    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            color: _surfaceAlt.withValues(alpha: 0.3),
            child: const Text('BILL SUMMARY', style: TextStyle(color: _textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          ),
          const Divider(color: _divider, height: 1),
          // Items
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _billRow('Item total', '₹948'),
                _billRow('Pickup fee', '₹0'),
                _billRow('Delivery fee', 'FREE', valueColor: _primary, bold: true),
                _billRow('Platform fee', '₹5'),
                _billRow('Taxes', '₹47'),
                _billRow('Coupon (FRESH50)', '-₹150', valueColor: _accent, bold: true),
                _billRow('Orio Wallet', '-₹100', valueColor: _primary, bold: true),
                const SizedBox(height: 8),
                const Divider(color: _divider),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Grand total', style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('₹700', style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.w800)),
                  ],
                ),
              ],
            ),
          ),
          // Payment method footer
          Container(
            color: _surfaceAlt,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: const [
                Icon(Icons.check_circle, color: _success, size: 18),
                SizedBox(width: 8),
                Text('Paid via Orio Wallet + UPI', style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
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
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // --- Help Banner ---
  Widget _buildHelpBanner() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 96,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _primary.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Need a quick wash?', style: TextStyle(color: _primary, fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('Book your next express service today.', style: TextStyle(color: _textSecondary, fontSize: 12)),
                ],
              ),
            ),
            Container(
              width: 48, height: 48,
              decoration: const BoxDecoration(
                color: _surface,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.rocket_launch, color: _primary, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  // --- Sticky Bottom Bar ---
  Widget _buildBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: _surface,
        boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // Get Support
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.headset_mic, size: 20),
                    label: const Text('Get support'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _surfaceAlt,
                      foregroundColor: _textPrimary,
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Reorder
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.reorder, size: 20),
                    label: const Text('Reorder'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      foregroundColor: Colors.white,
                      elevation: 6,
                      shadowColor: _primary.withValues(alpha: 0.3),
                      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
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
}

// Reusable card wrapper
class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: child,
    );
  }
}
