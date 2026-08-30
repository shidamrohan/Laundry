import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/add_garments_screen.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  int _selectedCategoryIndex = 0;
  int? _selectedServiceIndex = 0; // Wash & Fold selected by default

  final List<String> _categories = ['All', 'Wash', 'Dry Clean', 'Iron', 'Specialty'];

  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Wash & Fold',
      'icon': Icons.local_laundry_service,
      'time': 'est. 24h',
      'price': 'From ₹49',
      'badge': 'Popular',
      'badgeColor': const Color(0xFF0EA5A4),
    },
    {
      'title': 'Wash & Iron',
      'icon': Icons.iron,
      'time': 'est. 24h',
      'price': 'From ₹79',
    },
    {
      'title': 'Dry Cleaning',
      'icon': Icons.dry_cleaning,
      'time': 'est. 48h',
      'price': 'From ₹129',
      'badge': 'Best Value',
      'badgeColor': const Color(0xFF7C3AED),
    },
    {
      'title': 'Iron Only',
      'icon': Icons.style,
      'time': 'est. 12h',
      'price': 'From ₹19',
    },
    {
      'title': 'Shoe Cleaning',
      'icon': Icons.restaurant, // Fallback icon
      'time': 'est. 3 days',
      'price': 'From ₹249',
    },
    {
      'title': 'Bag Cleaning',
      'icon': Icons.shopping_bag,
      'time': 'est. 3 days',
      'price': 'From ₹399',
    },
    {
      'title': 'Curtain Cleaning',
      'icon': Icons.curtains,
      'time': 'est. 4 days',
      'price': 'From ₹199',
    },
    {
      'title': 'Blanket Cleaning',
      'icon': Icons.bed,
      'time': 'est. 2 days',
      'price': 'From ₹299',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          _buildHeader(topPadding),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 120), // Space for footer
              children: [
                _buildProgressBar(),
                _buildSearchBar(),
                _buildCategoryChips(),
                _buildServiceGrid(),
                _buildExpertCareHint(),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomFooter(),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
            padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
                splashRadius: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 12),
              const Text('Choose a service', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          IconButton(
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
            icon: const Icon(Icons.grid_view, color: Color(0xFF0F172A)),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('STEP 1 OF 6', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              Text('15% Complete', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(10)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.15,
              child: Container(decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search services',
            hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: _categories.asMap().entries.map((entry) {
          final idx = entry.key;
          final title = entry.value;
          final isSelected = _selectedCategoryIndex == idx;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategoryIndex = idx),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
                  boxShadow: isSelected ? const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))] : null,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildServiceGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final s = _services[index];
          final isSelected = _selectedServiceIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedServiceIndex = index),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFEFF6F6) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFF0EA5A4) : Colors.transparent,
                  width: 2,
                ),
                boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : const Color(0xFFEFF6F6),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(s['icon'], color: const Color(0xFF0EA5A4), size: 24),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        s['title'],
                        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold, height: 1.2),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.schedule, color: Color(0xFF64748B), size: 14),
                          const SizedBox(width: 4),
                          Text(s['time'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(s['price'], style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.w900)),
                    ],
                  ),
                  if (s['badge'] != null)
                    Positioned(
                      top: 0, left: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: s['badgeColor'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(s['badge'], style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                      ),
                    ),
                  if (isSelected)
                    const Positioned(
                      top: 0, right: 0,
                      child: Icon(Icons.check_circle, color: Color(0xFF0EA5A4), size: 24),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpertCareHint() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 32),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8E9)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('EXPERT CARE', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  SizedBox(height: 4),
                  Text('Your fabrics deserve a premium touch.', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold, height: 1.2)),
                  SizedBox(height: 8),
                  Text('Every garment is inspected individually for stains and fabric integrity before processing.', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Container(
              width: 96, height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDwm6ydweNYjMERZ-v_iVTZljgJxjRHgZfHYf_FNeaX1pzOsC3EQ7VoZ5VBrpZgveW8vmRRD0gn1EMtt2SujZwzw7GA1smejp5nhKI-QyaHeYIWgtFRdfGkyOquLdsIHZbaYc3yDUcdNfVZ_cW97GSgKcxYDP0NzvArQJJudXhMyi7Vhxdlk-lclMJnKjF2OU2f12ksJHj3u-7vUZsvZxx8fz0Z1uKlIo-UhZ6pRZZBWfMR-3RFDT4rQmUZ5qn4OXyvMRCh3KnGJlC4'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
                    child: const Icon(Icons.receipt_long, color: Color(0xFF0EA5A4), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Step 1', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(
                          '${_selectedServiceIndex != null ? 1 : 0} service selected',
                          style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: _selectedServiceIndex != null ? () {
                  final serviceName = _services[_selectedServiceIndex!]['title'];
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AddGarmentsScreen(serviceName: serviceName)));
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A4),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: const Color(0xFF0EA5A4).withValues(alpha: 0.4),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  disabledBackgroundColor: const Color(0xFFE2E8E9),
                  disabledForegroundColor: const Color(0xFF64748B),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
