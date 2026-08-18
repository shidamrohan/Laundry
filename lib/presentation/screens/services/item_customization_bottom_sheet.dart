import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoSwitch

class ItemCustomizationBottomSheet extends StatefulWidget {
  const ItemCustomizationBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ItemCustomizationBottomSheet(),
    );
  }

  @override
  State<ItemCustomizationBottomSheet> createState() => _ItemCustomizationBottomSheetState();
}

class _ItemCustomizationBottomSheetState extends State<ItemCustomizationBottomSheet> {
  int _quantity = 2;
  String _selectedFabric = 'Cotton';
  String _selectedStain = 'Light';

  final Map<String, bool> _treatments = {
    'Iron required': true,
    'Perfume finish': false,
    'Fabric softener': true,
    'Hypoallergenic wash': false,
    'Steam sanitization': false,
    'Eco-friendly wash': true,
    'Delicate mode': false,
  };

  bool _isPremiumCare = false;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          _buildHeader(),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
              children: [
                _buildFabricSection(),
                const SizedBox(height: 32),
                _buildStainSection(),
                const SizedBox(height: 32),
                _buildTreatmentSection(),
                const SizedBox(height: 32),
                _buildPremiumCareCard(),
                const SizedBox(height: 32),
                _buildSpecialNotesSection(),
                const SizedBox(height: 80), // Extra space for footer
              ],
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildDragHandle() {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Container(
        width: 40,
        height: 6,
        decoration: BoxDecoration(
          color: const Color(0xFFE2E8E9),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x80E2E8E9))),
      ),
      child: Row(
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6F6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8E9)),
              image: const DecorationImage(
                image: NetworkImage('https://lh3.googleusercontent.com/aida/AP1WRLuAZHx67I8s-ApIAeKA0fUDm_-C8l9GEY_tNZ5u8KAYsj3pmBNEYLy9lwCBLc30j0nE1w4sUq-pb7L5yylwQtxUrXW6zjCMWisCxmE02IK4Rz8vM9ge83KKDMMXVvI0ASPmPJIwI-e9_utFaI1VSowFM1ukNnCdSldwQspOyLJb6YvKzicNMxLoCvNoKhu-Z0VfYpUc22o7Xm2HeMgFVDOcaUF4Fg8jER0dq0nJm2un41ovpzGhYOR39i1w'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Shirt', style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                        SizedBox(height: 2),
                        Text('₹49', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6F6),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0x66E2E8E9)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildQtyBtn(Icons.remove, () {
                            if (_quantity > 1) setState(() => _quantity--);
                          }),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('$_quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                          _buildQtyBtn(Icons.add, () {
                            setState(() => _quantity++);
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32, height: 32,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 4, offset: Offset(0, 2))]),
        child: Icon(icon, size: 16, color: const Color(0xFF0F172A)),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600)),
          if (isRequired) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
              child: const Text('Required', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFabricSection() {
    final fabrics = ['Cotton', 'Linen', 'Silk', 'Wool', 'Synthetic'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Fabric type', isRequired: true),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: fabrics.map((f) {
            final isSelected = f == _selectedFabric;
            return GestureDetector(
              onTap: () => setState(() => _selectedFabric = f),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFEFF6F6) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : Colors.transparent, width: 2),
                ),
                child: Text(
                  f,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStainSection() {
    final levels = ['None', 'Light', 'Heavy'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Stain level'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: levels.map((lvl) {
              final isSelected = lvl == _selectedStain;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedStain = lvl),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected ? const [BoxShadow(color: Color(0x1A000000), blurRadius: 4)] : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      lvl,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
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

  Widget _buildTreatmentSection() {
    final icons = {
      'Iron required': Icons.iron,
      'Perfume finish': Icons.yard_outlined, // sprinkler approx
      'Fabric softener': Icons.water_drop_outlined,
      'Hypoallergenic wash': Icons.spa_outlined,
      'Steam sanitization': Icons.air_outlined,
      'Eco-friendly wash': Icons.eco_outlined,
      'Delicate mode': Icons.auto_awesome_outlined,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Treatment options'),
        const SizedBox(height: 16),
        Column(
          children: _treatments.keys.map((title) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)),
                            child: Icon(icons[title] ?? Icons.check, color: const Color(0xFF64748B)),
                          ),
                          const SizedBox(width: 12),
                          Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      CupertinoSwitch(
                        value: _treatments[title]!,
                        activeTrackColor: const Color(0xFF0EA5A4),
                        onChanged: (val) => setState(() => _treatments[title] = val),
                      ),
                    ],
                  ),
                ),
                if (title != _treatments.keys.last)
                  const Divider(color: Color(0x4DE2E8E9), height: 1),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPremiumCareCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x1A7C3AED), Color(0x1A0EA5A4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x337C3AED)),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Color(0x337C3AED), blurRadius: 16, offset: Offset(0, 4))],
            ),
            child: const Icon(Icons.workspace_premium, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Premium care', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('Hand-finished & individual protection', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.2)),
              ],
            ),
          ),
          CupertinoSwitch(
            value: _isPremiumCare,
            activeTrackColor: const Color(0xFF7C3AED),
            onChanged: (val) => setState(() => _isPremiumCare = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Special notes'),
        const SizedBox(height: 16),
        TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'e.g. Remove coffee stain, don\'t bleach',
            hintStyle: const TextStyle(color: Color(0x8064748B), fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF0EA5A4))),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0x80E2E8E9))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('TOTAL ITEM PRICE', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                Text('₹79', style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A4),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: const Color(0xFF0EA5A4).withValues(alpha: 0.4),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Save item', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
