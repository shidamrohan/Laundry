import 'package:flutter/material.dart';

class FilterTransactionsBottomSheet extends StatefulWidget {
  const FilterTransactionsBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x660F172A), // blur-scrim effect mock
      builder: (_) => const FilterTransactionsWrapper(),
    );
  }

  @override
  State<FilterTransactionsBottomSheet> createState() => _FilterTransactionsBottomSheetState();
}

class _FilterTransactionsBottomSheetState extends State<FilterTransactionsBottomSheet> {
  String _selectedDateRange = 'Last 30 days';
  final Set<String> _selectedTypes = {'Credits', 'Debits'};
  double _amountValue = 3800;
  String _selectedSort = 'Newest';

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      margin: EdgeInsets.only(bottom: bottomInset),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -8))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8E9),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(height: 6),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter transactions',
                  style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDateRange = 'Last 30 days';
                      _selectedTypes.clear();
                      _selectedTypes.addAll(['Credits', 'Debits']);
                      _amountValue = 5000;
                      _selectedSort = 'Newest';
                    });
                  },
                  child: const Text('Reset', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFFE2E8E9), height: 1),

          // Scrollable Content
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateRangeSection(),
                  const SizedBox(height: 32),
                  _buildTypeSection(),
                  const SizedBox(height: 32),
                  _buildAmountRangeSection(),
                  const SizedBox(height: 32),
                  _buildSortSection(),
                  const SizedBox(height: 100), // Space for sticky bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateRangeSection() {
    final ranges = ['Today', 'Yesterday', 'Last 7 days', 'Last 30 days', 'Last 90 days', 'This year'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DATE RANGE', style: TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...ranges.map((range) => _buildChip(
              label: range,
              isSelected: _selectedDateRange == range,
              onTap: () => setState(() => _selectedDateRange = range),
            )),
            // Custom Range Button
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE2E8E9)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.calendar_today, size: 16, color: Color(0xFF0EA5A4)),
                    SizedBox(width: 8),
                    Text('Custom range', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TYPE', style: TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildTypeChip('Credits', const Color(0xFF16A34A)),
            _buildTypeChip('Debits', const Color(0xFFDC2626)),
            _buildTypeChip('Refunds', const Color(0xFF2563EB)),
            _buildTypeChip('Rewards', const Color(0xFFF59E0B)),
            _buildTypeChip('Expired', const Color(0xFF64748B)),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeChip(String label, Color dotColor) {
    final isSelected = _selectedTypes.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTypes.remove(label);
          } else {
            _selectedTypes.add(label);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? dotColor.withValues(alpha: 0.1) : Colors.white,
          border: Border.all(color: isSelected ? dotColor.withValues(alpha: 0.3) : const Color(0xFFE2E8E9), width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8, height: 8,
              decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? dotColor : const Color(0xFF64748B),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('AMOUNT RANGE', style: TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            Text('₹0 – ₹${_amountValue.toInt()}', style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF0EA5A4),
            inactiveTrackColor: const Color(0xFFE2E8E9),
            thumbColor: const Color(0xFF0EA5A4),
            trackHeight: 6,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          ),
          child: Slider(
            value: _amountValue,
            min: 0,
            max: 5000,
            divisions: 50,
            onChanged: (val) => setState(() => _amountValue = val),
          ),
        ),
      ],
    );
  }

  Widget _buildSortSection() {
    final sorts = ['Newest', 'Oldest', 'Amount'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SORT BY', style: TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6F6),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8E9)),
          ),
          child: Row(
            children: sorts.map((sort) {
              final isSelected = _selectedSort == sort;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedSort = sort),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: isSelected ? [const BoxShadow(color: Color(0x0A0F172A), blurRadius: 4, offset: Offset(0, 2))] : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      sort,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildChip({required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
          border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected ? [const BoxShadow(color: Color(0x330EA5A4), blurRadius: 4, offset: Offset(0, 2))] : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Add fixed bottom buttons below flexible content by using Stack inside the main builder
class FilterTransactionsWrapper extends StatelessWidget {
  const FilterTransactionsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const FilterTransactionsBottomSheet(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Clear all', style: TextStyle(color: Color(0xFF64748B), fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0EA5A4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 4,
                      shadowColor: const Color(0x330EA5A4),
                    ),
                    child: const Text('Apply filters (2)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
