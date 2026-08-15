import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoSwitch
import 'package:laundry/presentation/screens/booking/choose_speed_screen.dart';

class ScheduleDeliveryScreen extends StatefulWidget {
  const ScheduleDeliveryScreen({super.key});

  @override
  State<ScheduleDeliveryScreen> createState() => _ScheduleDeliveryScreenState();
}

class _ScheduleDeliveryScreenState extends State<ScheduleDeliveryScreen> {
  int _selectedDateIndex = 2; // 0=Today, 1=Tomorrow, 2=Thu 25
  int _selectedSlotIndex = 2; // 0=Morning, 1=Afternoon, 2=Evening, 3=Night
  bool _scheduleLater = false;

  final List<Map<String, dynamic>> _slots = [
    {
      'title': 'Morning',
      'time': '8–11 AM',
      'status': 'Almost full',
      'statusColor': const Color(0xFFF59E0B),
      'enabled': true,
    },
    {
      'title': 'Afternoon',
      'time': '12–3 PM',
      'status': '3 slots left',
      'statusColor': const Color(0xFF16A34A),
      'enabled': true,
    },
    {
      'title': 'Evening',
      'time': '4–7 PM',
      'status': 'Available',
      'statusColor': const Color(0xFF0EA5A4), // Primary color for available in mockup
      'enabled': true,
    },
    {
      'title': 'Night',
      'time': '7–9 PM',
      'status': '8 slots left',
      'statusColor': const Color(0xFF64748B),
      'enabled': true,
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
                const SizedBox(height: 16),
                _buildSummaryCard(),
                const SizedBox(height: 16),
                _buildTimelineRow(),
                const SizedBox(height: 16),
                _buildDateSection(),
                const SizedBox(height: 24),
                _buildSlotSelection(),
                const SizedBox(height: 16),
                _buildToggleCard(),
                const SizedBox(height: 24),
                _buildUpsellCard(),
                const SizedBox(height: 32), // extra padding for scrolling
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
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Schedule delivery', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5))),
          const SizedBox(width: 40), // Spacer for balance
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 6,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xFFE2E8E9)),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: 0.80, // 80% completion
        child: Container(decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(3))),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
                  child: const Icon(Icons.local_shipping, color: Color(0xFF0EA5A4), size: 18),
                ),
                Container(
                  width: 2, height: 32,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: const BoxDecoration(
                    // Simple representation of dashed line with solid color for simplicity without custom painters
                    color: Color(0xFFE2E8E9), 
                  ),
                ),
                Container(
                  width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF0EA5A4), width: 2),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PICKUP', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  const SizedBox(height: 2),
                  const Text('Tomorrow, 12–3 PM', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  const Text('DELIVERY', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  const SizedBox(height: 2),
                  const Text('Select a slot below...', style: TextStyle(color: Color(0xFF64748B), fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Estimated completion', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              SizedBox(height: 2),
              Text('Ready by Thu, 25 Jul', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6F6),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0x1A0EA5A4)),
            ),
            child: const Text('24h standard', style: TextStyle(color: Color(0xFF0B7F7E), fontSize: 13, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection() {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildDateChip('Today', 0),
              const SizedBox(width: 12),
              _buildDateChip('Tomorrow', 1),
              const SizedBox(width: 12),
              _buildDateChip('Thu 25', 2),
              const SizedBox(width: 12),
              _buildDateChip('Fri 26', 3),
              const SizedBox(width: 12),
              _buildDateChip('Sat 27', 4),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0x80EFF6F6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x80E2E8E9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMiniCalendarDay('M', '22'),
                _buildMiniCalendarDay('T', '23'),
                _buildMiniCalendarDay('W', '24'),
                _buildMiniCalendarDay('T', '25', isSelected: true),
                _buildMiniCalendarDay('F', '26'),
                _buildMiniCalendarDay('S', '27'),
                _buildMiniCalendarDay('S', '28'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateChip(String label, int index) {
    final isSelected = _selectedDateIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedDateIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
          boxShadow: isSelected ? const [BoxShadow(color: Color(0x330EA5A4), blurRadius: 8, offset: Offset(0, 4))] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMiniCalendarDay(String day, String date, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSelected ? 12 : 8, vertical: isSelected ? 12 : 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0EA5A4) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isSelected ? const [BoxShadow(color: Color(0x1A0EA5A4), blurRadius: 16, spreadRadius: 4)] : null,
      ),
      child: Column(
        children: [
          Text(day, style: TextStyle(color: isSelected ? Colors.white : const Color(0x9964748B), fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(date, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF64748B), fontSize: 14, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildSlotSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text('Delivery time slot', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
            ),
            itemCount: _slots.length,
            itemBuilder: (context, index) {
              final slot = _slots[index];
              final isSelected = _selectedSlotIndex == index;

              return GestureDetector(
                onTap: () => setState(() => _selectedSlotIndex = index),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0x80EFF6F6) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9), width: isSelected ? 2 : 1),
                    boxShadow: isSelected ? const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 16, offset: Offset(0, 4))] : const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: Stack(
                    children: [
                      if (isSelected)
                        Positioned(
                          top: -4, right: -4,
                          child: Container(
                            width: 24, height: 24,
                            decoration: const BoxDecoration(color: Color(0xFF0EA5A4), shape: BoxShape.circle),
                            child: const Icon(Icons.check, color: Colors.white, size: 16),
                          ),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(slot['title'], style: TextStyle(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2),
                          Text(slot['time'], style: TextStyle(color: const Color(0xFF0F172A), fontSize: 16, fontWeight: isSelected ? FontWeight.w900 : FontWeight.bold)),
                          const Spacer(),
                          Row(
                            children: [
                              if (!isSelected || slot['status'] != 'Available') ...[
                                Container(width: 6, height: 6, decoration: BoxDecoration(color: slot['statusColor'], shape: BoxShape.circle)),
                                const SizedBox(width: 4),
                              ],
                              Text(slot['status'], style: TextStyle(color: isSelected && slot['status'] == 'Available' ? const Color(0xB30EA5A4) : slot['statusColor'], fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
              child: const Icon(Icons.notifications_active, color: Color(0xFF0EA5A4), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Schedule later', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text("We'll notify you when it's ready", style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                ],
              ),
            ),
            CupertinoSwitch(
              value: _scheduleLater,
              activeColor: const Color(0xFF0EA5A4),
              onChanged: (val) => setState(() => _scheduleLater = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpsellCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x337C3AED), width: 2),
          boxShadow: const [BoxShadow(color: Color(0x1A15232A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -20, right: -20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: const BoxDecoration(
                  color: Color(0xFF7C3AED),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16)),
                ),
                child: const Text('EXPRESS', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(color: const Color(0x1A7C3AED), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.bolt, color: Color(0xFF7C3AED), size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Express delivery — same day', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text('Get your clothes back in under 6 hours', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0x1A7C3AED),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text('+₹149 surcharge', style: TextStyle(color: Color(0xFF7C3AED), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text('Upgrade', style: TextStyle(color: Color(0xFF7C3AED), fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Color(0xFF7C3AED), size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Selected Delivery', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text('Thu · 4–7 PM', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 16, fontWeight: FontWeight.w900)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ChooseSpeedScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0EA5A4),
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: const Color(0x400EA5A4),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
