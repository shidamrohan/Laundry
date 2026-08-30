import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';

class ExportTransactionsBottomSheet extends StatefulWidget {
  const ExportTransactionsBottomSheet({super.key});

  @override
  State<ExportTransactionsBottomSheet> createState() => _ExportTransactionsBottomSheetState();
}

class _ExportTransactionsBottomSheetState extends State<ExportTransactionsBottomSheet> {
  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  String _selectedFormat = 'PDF';
  String _selectedDateRange = 'Last 30 days';
  String _selectedDelivery = 'device';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          _buildHeader(context),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormatSection(),
                  const SizedBox(height: 32),
                  _buildDateRangeSection(),
                  const SizedBox(height: 32),
                  _buildDeliverToSection(),
                  const SizedBox(height: 32),
                  const Center(
                    child: Text(
                      'Includes all wallet credits, debits, refunds and rewards.',
                      style: TextStyle(color: _textSecondary, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildCTAs(context),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 12),
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: _divider,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Export transactions',
            style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: _textSecondary),
            style: IconButton.styleFrom(
              backgroundColor: Colors.transparent,
              hoverColor: _surfaceAlt,
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  // --- Format Section ---
  Widget _buildFormatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('FORMAT', style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildFormatCard('PDF', Icons.description)),
            const SizedBox(width: 12),
            Expanded(child: _buildFormatCard('CSV', Icons.table_chart_outlined)),
            const SizedBox(width: 12),
            Expanded(child: _buildFormatCard('Excel', Icons.grid_on_outlined)),
          ],
        ),
      ],
    );
  }

  Widget _buildFormatCard(String format, IconData icon) {
    final isSelected = _selectedFormat == format;
    return GestureDetector(
      onTap: () => setState(() => _selectedFormat = format),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? _surfaceAlt : _surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? _primary : _divider, width: isSelected ? 2 : 1),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? _primary : _textSecondary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              format,
              style: TextStyle(
                color: isSelected ? _primary : _textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Date Range Section ---
  Widget _buildDateRangeSection() {
    final ranges = ['Last 30 days', 'Last 90 days', 'This year'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DATE RANGE', style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: [
            ...ranges.map((range) => _buildDateChip(range)),
            _buildCustomDateChip(),
          ],
        ),
      ],
    );
  }

  Widget _buildDateChip(String label) {
    final isSelected = _selectedDateRange == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedDateRange = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _primary : _surfaceAlt,
          borderRadius: BorderRadius.circular(99),
          boxShadow: isSelected ? const [BoxShadow(color: Color(0x1A0EA5A4), blurRadius: 8, offset: Offset(0, 2))] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : _textPrimary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomDateChip() {
    final isSelected = _selectedDateRange == 'Custom range';
    return GestureDetector(
      onTap: () => setState(() => _selectedDateRange = 'Custom range'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? _primary : _surfaceAlt,
          borderRadius: BorderRadius.circular(99),
          boxShadow: isSelected ? const [BoxShadow(color: Color(0x1A0EA5A4), blurRadius: 8, offset: Offset(0, 2))] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, size: 18, color: isSelected ? Colors.white : _textPrimary),
            const SizedBox(width: 8),
            Text(
              'Custom range',
              style: TextStyle(
                color: isSelected ? Colors.white : _textPrimary,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Deliver To Section ---
  Widget _buildDeliverToSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DELIVER TO', style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 16),
        _buildDeliveryOption(
          id: 'device',
          title: 'Download to device',
          subtitle: null,
          trailing: null,
        ),
        const SizedBox(height: 16),
        _buildDeliveryOption(
          id: 'email',
          title: 'Email to aarav@email.com',
          subtitle: 'Edit email address',
          trailing: null,
        ),
      ],
    );
  }

  Widget _buildDeliveryOption({
    required String id,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    final isSelected = _selectedDelivery == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedDelivery = id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? _surfaceAlt.withValues(alpha: 0.5) : _surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? _primary : _divider),
        ),
        child: Row(
          children: [
            // Radio button custom UI
            Container(
              width: 20, height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? _primary : _divider, width: 2),
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Container(width: 10, height: 10, decoration: const BoxDecoration(color: _primary, shape: BoxShape.circle))
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); }, // e.g. open email edit dialog
                      child: Text(subtitle, style: const TextStyle(color: _primary, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }

  // --- CTAs ---
  Widget _buildCTAs(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // Handle export
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: _primary.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
            ),
            child: const Text('Export', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: _textSecondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
            ),
            child: const Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
