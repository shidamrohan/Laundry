import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoSwitch

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String _selectedTag = 'Home';
  bool _isDefault = true;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          _buildHeader(context, topPadding),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 120), // Space for bottom action bar
              children: [
                _buildMapSection(),
                _buildAddressChips(),
                _buildFormSection(),
                _buildReceiverSection(),
                _buildPhotosSection(),
                _buildSettingsSection(),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomActionBar(context),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(BuildContext context, double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, topPadding + 8, 16, 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            splashRadius: 24,
          ),
          const Expanded(
            child: Text('Edit Address', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFDC2626),
              backgroundColor: const Color(0xFFDC2626).withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            icon: const Icon(Icons.delete, size: 18),
            label: const Text('Delete', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        height: 224,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Map Image
            Positioned.fill(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAL3H4q18ggvX5oZbuQhIZHNSZy25WJlD55_7d_jR3ySEOrGv-zAsvCN1Bqf3dzqvw7Nruc08Wsn_i6dFFnNF75C4EQCXnQxTgwv2maigqirrGYxAHrTzQk0us4L-w7t4IGkrkfpVD4Ak66vtxDXSHSXHc1sXyocEqyvuDMo3zw-vmjJzywsXxXwfjsVWI_niHNhIeFrhcKirMIO8FczBJrElgnmbhwl4ETBJO0U7LFUOFROwWCuf3wCRcztpP3MNKy8ejB8DURrRow',
                fit: BoxFit.cover,
              ),
            ),
            // Center Pin
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -4,
                      child: Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 2)]),
                      ),
                    ),
                    const Icon(Icons.location_on, color: Color(0xFF0EA5A4), size: 48),
                  ],
                ),
              ),
            ),
            // Bottom Controls
            Positioned(
              bottom: 16, left: 0, right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0EA5A4),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    icon: const Icon(Icons.edit_location_alt, size: 16),
                    label: const Text('Change on map', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 16, right: 16,
              child: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8E9)),
                  boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: const Icon(Icons.my_location, color: Color(0xFF0EA5A4), size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          _buildChip('Home', '🏠'),
          const SizedBox(width: 12),
          _buildChip('Work', '🏢'),
          const SizedBox(width: 12),
          _buildChip('Favorite', '❤️'),
          const SizedBox(width: 12),
          _buildChip('Other', '📍'),
          const SizedBox(width: 12),
          _buildCustomChip(),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String emoji) {
    final isSelected = _selectedTag == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTag = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
          boxShadow: isSelected ? const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.3)), // solid border for now
      ),
      child: const Text('+ Custom', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: _buildFormField('Flat / House no.', '402', Icons.meeting_room)),
                const SizedBox(width: 16),
                Expanded(child: _buildFormField('Floor', '4', Icons.layers)),
              ],
            ),
            const SizedBox(height: 20),
            _buildFormField('Building / Apartment name', 'Brigade Residency', Icons.apartment),
            const SizedBox(height: 20),
            _buildFormField('Landmark', 'Near Mango Tree Cafe', Icons.near_me),
            const SizedBox(height: 20),
            _buildFormField('Area / Street', 'Brigade Road, Shanthala Nagar', Icons.streetview),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildFormField('City', 'Bengaluru', Icons.location_city)),
                const SizedBox(width: 16),
                Expanded(child: _buildFormField('Pincode', '560025', Icons.pin_drop)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormField(String label, String value, IconData icon) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6F6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.transparent),
          ),
          child: TextFormField(
            initialValue: value,
            style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 20),
              prefixIconConstraints: const BoxConstraints(minWidth: 36),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 12,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiverSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.person, color: Color(0xFF0EA5A4), size: 22),
              SizedBox(width: 8),
              Text('Receiver details', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8E9)),
              boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: Column(
              children: [
                _buildFormField('Receiver name', 'Aarav Kumar', Icons.person_outline),
                const SizedBox(height: 20),
                _buildFormField('Phone', '+91 98765 43210', Icons.phone_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.photo_camera, color: Color(0xFF0EA5A4), size: 22),
              SizedBox(width: 8),
              Text('Address Photos', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE2E8E9)),
                    boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                    image: const DecorationImage(
                      image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAd8ASrSj_8lK3EEHJM9oOcM-Bk5D2CcTO3IkgvihZha-rXpzXFLLr2zQJbnkgJsEz3q5Dj4KAzRizeZYqI4GMHECfs_xBJYUiCH3xyounFuA5V6LsXDhJs1mafQF3qU455oMAfT0kdelpg3kYk5s8gWT7vmJNh0bXlipMgM69J5s3GG4qRqIAUxYi-mHp27pXs2NqAD_YS36i8ThTbLC0H6bVS1yrgE1fGmYIJl4VJfcFtowFmimXXXv4ML-bJyVrcPlO1d-aF4n_W'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      Container(color: Colors.black.withValues(alpha: 0.2)),
                      Positioned(
                        top: 8, left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(6)),
                          child: const Text('Building', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Positioned(
                        bottom: 8, left: 0, right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)),
                            child: const Text('Replace', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6F6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.4)), // Solid instead of dashed for simplicity
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_a_photo, color: Color(0xFF0EA5A4)),
                      SizedBox(height: 4),
                      Text('Add door photo', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
      child: Container(
        padding: const EdgeInsets.all(20),
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
              decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.verified_user, color: Color(0xFF0EA5A4), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Set as default address', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                  Text('Orders will use this address automatically', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                ],
              ),
            ),
            CupertinoSwitch(
              value: _isDefault,
              activeTrackColor: const Color(0xFF0EA5A4),
              onChanged: (val) => setState(() => _isDefault = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEFF6F6),
                    foregroundColor: const Color(0xFF64748B),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.close, size: 20),
                      Text('Cancel', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0EA5A4),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check_circle, size: 20),
                      Text('Save changes', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
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
