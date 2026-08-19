import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/schedule_delivery_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDateIndex = 1; // 0 = Today, 1 = Tomorrow, 2 = Custom
  int _selectedSlotIndex = -1; // -1 = None

  final List<Map<String, dynamic>> _slots = [
    {
      'title': 'Morning',
      'time': '8–11 AM',
      'status': '3 slots left',
      'statusColor': const Color(0xFF16A34A),
      'enabled': true,
    },
    {
      'title': 'Afternoon',
      'time': '12–3 PM',
      'status': 'Almost full',
      'statusColor': const Color(0xFFF59E0B),
      'enabled': true,
    },
    {
      'title': 'Evening',
      'time': '4–7 PM',
      'status': '2 slots left',
      'statusColor': const Color(0xFF16A34A),
      'enabled': true,
    },
    {
      'title': 'Night',
      'time': '7–9 PM',
      'status': 'Full',
      'statusColor': const Color(0xFF64748B),
      'enabled': false,
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
                _buildProgressBar(),
                _buildQuickDateSelection(),
                _buildHorizontalCalendar(),
                _buildSlotSelection(),
                _buildExpressOption(),
              ],
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
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

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Text('Schedule Pickup', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
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

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Step 4 of 6', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w600)),
              Text('66%', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(3)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.66,
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(3)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickDateSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          _buildDateChip('Today', 0),
          const SizedBox(width: 12),
          _buildDateChip('Tomorrow', 1),
          const SizedBox(width: 12),
          _buildDateChip('Pick a date', 2, icon: Icons.calendar_month),
        ],
      ),
    );
  }

  Widget _buildDateChip(String label, int index, {IconData? icon}) {
    final isSelected = _selectedDateIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedDateIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
          boxShadow: isSelected ? const [BoxShadow(color: Color(0x330EA5A4), blurRadius: 8, offset: Offset(0, 4))] : null,
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: isSelected ? Colors.white : const Color(0xFF64748B), size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCalendarDay('Sun', '12', isPast: true),
            _buildCalendarDay('Mon', '13', isSelected: true),
            _buildCalendarDay('Tue', '14'),
            _buildCalendarDay('Wed', '15', isHoliday: true),
            _buildCalendarDay('Thu', '16'),
            _buildCalendarDay('Fri', '17'),
            _buildCalendarDay('Sat', '18'),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarDay(String day, String date, {bool isSelected = false, bool isPast = false, bool isHoliday = false}) {
    return Opacity(
      opacity: isPast ? 0.5 : 1.0,
      child: Column(
        children: [
          Text(day, style: TextStyle(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0EA5A4) : (isPast ? const Color(0x0D0EA5A4) : Colors.transparent),
              borderRadius: BorderRadius.circular(10),
              border: isPast && !isSelected ? Border.all(color: const Color(0xFF0EA5A4)) : null,
              boxShadow: isSelected ? const [BoxShadow(color: Color(0x400EA5A4), blurRadius: 8, offset: Offset(0, 4))] : null,
            ),
            child: Center(
              child: Text(date, style: TextStyle(color: isSelected ? Colors.white : (isPast ? const Color(0xFF0EA5A4) : const Color(0xFF0F172A)), fontSize: 14, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 8),
          if (isHoliday)
            Row(
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFDC2626), shape: BoxShape.circle)),
              ],
            )
          else
            Container(width: 4, height: 4, decoration: BoxDecoration(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9), shape: BoxShape.circle)),
        ],
      ),
    );
  }

  Widget _buildSlotSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Choose a time slot', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
            ),
            itemCount: _slots.length,
            itemBuilder: (context, index) {
              final slot = _slots[index];
              final isSelected = _selectedSlotIndex == index;
              final enabled = slot['enabled'] as bool;

              return GestureDetector(
                onTap: enabled ? () => setState(() => _selectedSlotIndex = index) : null,
                child: Opacity(
                  opacity: enabled ? 1.0 : 0.6,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFEFF6F6) : (enabled ? Colors.white : const Color(0x4DE2E8E9)),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF0EA5A4) : (enabled ? const Color(0xFFE2E8E9) : const Color(0x80E2E8E9)),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected ? const [BoxShadow(color: Color(0x0D0EA5A4), blurRadius: 0, spreadRadius: 4)] : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(slot['title'], style: TextStyle(color: enabled ? const Color(0xFF0F172A) : const Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.bold)),
                            if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF0EA5A4), size: 20),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(slot['time'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                        const Spacer(),
                        Row(
                          children: [
                            if (enabled) ...[
                              Container(width: 6, height: 6, decoration: BoxDecoration(color: slot['statusColor'], shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                            ],
                            Text(slot['status'], style: TextStyle(color: slot['statusColor'], fontSize: 11, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpressOption() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.transparent),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [const Color(0xFF0EA5A4).withValues(alpha: 0.1), const Color(0xFF7C3AED).withValues(alpha: 0.1)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF0EA5A4), Color(0xFF7C3AED)], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.bolt, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Express pickup', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                      SizedBox(height: 2),
                      Text('Within 90 minutes', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0x1A7C3AED),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0x337C3AED)),
                  ),
                  child: const Text('+₹99', style: TextStyle(color: Color(0xFF7C3AED), fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    final hasSelection = _selectedSlotIndex != -1;
    final dateStr = _selectedDateIndex == 0 ? 'Today' : _selectedDateIndex == 1 ? 'Tomorrow' : 'Custom Date';
    final timeStr = hasSelection ? _slots[_selectedSlotIndex]['time'] : 'Select a time';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -4))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('SELECTED SLOT', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(dateStr, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w900)),
                    const SizedBox(width: 6),
                    const Icon(Icons.circle, color: Color(0xFFE2E8E9), size: 4),
                    const SizedBox(width: 6),
                    Text(timeStr, style: TextStyle(color: hasSelection ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: hasSelection ? () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleDeliveryScreen()));
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0EA5A4),
                disabledBackgroundColor: const Color(0xFFE2E8E9),
                foregroundColor: Colors.white,
                elevation: hasSelection ? 8 : 0,
                shadowColor: const Color(0x400EA5A4),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                children: const [
                  Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
