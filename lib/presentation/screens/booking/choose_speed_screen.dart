import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/order_review_screen.dart';

class ChooseSpeedScreen extends StatefulWidget {
  const ChooseSpeedScreen({super.key});

  @override
  State<ChooseSpeedScreen> createState() => _ChooseSpeedScreenState();
}

class _ChooseSpeedScreenState extends State<ChooseSpeedScreen> {
  String _selectedSpeed = 'priority'; // 'standard', 'priority', 'express'

  final Map<String, Map<String, dynamic>> _speedOptions = {
    'standard': {
      'title': 'Standard',
      'time': 'Delivery in 24–48h',
      'price': 'Included / ₹0',
      'priceValue': 0,
      'icon': Icons.schedule,
      'color': const Color(0xFF64748B), // Neutral
      'features': ['Free pickup', 'Quality wash', 'Fold & pack'],
      'isRecommended': false,
    },
    'priority': {
      'title': 'Priority',
      'time': 'Delivery in 12h',
      'price': '+₹99',
      'priceValue': 99,
      'icon': Icons.rocket_launch,
      'color': const Color(0xFF0EA5A4), // Primary
      'features': ['Faster turnaround', 'Priority queue', 'SMS updates'],
      'isRecommended': true,
      'saveNote': 'Save ₹100 vs Express',
    },
    'express': {
      'title': 'Express',
      'time': 'Delivery within 6h',
      'price': '+₹199',
      'priceValue': 199,
      'icon': Icons.bolt,
      'color': const Color(0xFF7C3AED), // Accent
      'features': ['Fastest processing', 'Dedicated handling', 'Live tracking'],
      'isRecommended': false,
    },
  };

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
                _buildIntroText(),
                _buildSpeedOptions(),
                _buildEstimatesNote(),
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
      color: Colors.white.withOpacity(0.9),
      child: Column(
        children: [
          Padding(
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
                const Expanded(child: Text('Choose your speed', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5))),
                Container(
                  width: 96, height: 6,
                  decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(3)),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.75, // 75% completion
                    child: Container(decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(3))),
                  ),
                ),
              ],
            ),
          ),
          // Mobile Slim Progress Bar
          Container(
            height: 2,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFFE2E8E9)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.75,
              child: Container(color: const Color(0xFF0EA5A4)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('How fast do you need it?', style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
          SizedBox(height: 8),
          Text('Choose a turnaround time that fits your schedule.', style: TextStyle(color: Color(0xFF64748B), fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSpeedOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildOptionCard('standard'),
          const SizedBox(height: 16),
          _buildOptionCard('priority'),
          const SizedBox(height: 16),
          _buildOptionCard('express'),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String key) {
    final option = _speedOptions[key]!;
    final isSelected = _selectedSpeed == key;
    final isRecommended = option['isRecommended'] as bool;
    final color = option['color'] as Color;

    return GestureDetector(
      onTap: () => setState(() => _selectedSpeed = key),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? color : Colors.transparent, width: 2),
          boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.1), blurRadius: 24, offset: const Offset(0, 8))] : const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              if (isRecommended)
                Positioned(
                  top: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8)),
                    ),
                    child: const Text('RECOMMENDED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48, height: 48,
                          decoration: BoxDecoration(
                            color: isSelected ? color.withOpacity(0.2) : const Color(0xFFEFF6F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(option['icon'], color: isSelected ? color : const Color(0xFF64748B), size: 28),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(option['title'], style: const TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 2),
                              Text(option['time'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                            ],
                          ),
                        ),
                        Text(option['price'], style: TextStyle(color: isSelected ? color : const Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ...List.generate((option['features'] as List).length, (index) {
                      final feature = option['features'][index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: isSelected ? color : const Color(0xFF0EA5A4), size: 18),
                            const SizedBox(width: 8),
                            Text(feature, style: TextStyle(color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B), fontSize: 14, fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
                          ],
                        ),
                      );
                    }),
                    if (option['saveNote'] != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.savings, color: color, size: 16),
                            const SizedBox(width: 8),
                            Text(option['saveNote'], style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEstimatesNote() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.info_outline, color: Color(0xFF64748B), size: 16),
          SizedBox(width: 8),
          Text('Times are estimates from pickup.', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final selectedOption = _speedOptions[_selectedSpeed]!;
    final priceLabel = selectedOption['priceValue'] == 0 ? '₹0' : '+₹${selectedOption['priceValue']}';
    final selectionText = '${selectedOption['title']} · $priceLabel';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -8))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('SELECTION', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                const SizedBox(height: 2),
                Text(selectionText, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                // Hidden on very small screens, shown otherwise
                if (MediaQuery.of(context).size.width > 350) ...[
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B),
                      backgroundColor: const Color(0xFFEFF6F6),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Skip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                ],
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderReviewScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0EA5A4),
                    foregroundColor: Colors.white,
                    elevation: 8,
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
          ],
        ),
      ),
    );
  }
}
