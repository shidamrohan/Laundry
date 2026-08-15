import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/profile/terms_screen.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String _selectedTag = 'Home';

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          _buildHeader(context, topPadding),
          Expanded(
            child: Stack(
              children: [
                _buildMapSection(),
                _buildFormSection(),
              ],
            ),
          ),
          _buildBottomCTA(context),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(BuildContext context, double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(8, topPadding + 8, 8, 8),
      height: topPadding + 64,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            splashRadius: 24,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text('Select location', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic, color: Color(0xFF0EA5A4)),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Positioned(
      top: 0, left: 0, right: 0,
      height: 265,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Map Image
            Positioned.fill(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBvImjyOyrwww1Ryezd6RZ_e_o8sSUEZIIG3LaoLLWGkV_iojDJmX4F_QGVKWweGv9crW9JWSqYH5VpsbW1pBnQbXzMsCO2qfQvBQOEdRKX6LvQzw1cgNOAfncinfRCg-tvhw3Qrk0l6xXDQ9vhDIdhmboOb0TSYC_-oOzQMaRcDgSpI5PNPE0uJRIFUc9tpCu7OO0oXjYncQ10x9pHeC9rWthcN71PJ91mQ6XDZGlLC7IVAu-gD9qGoNC2BD6Pk4oTqSPNqpT9j23G',
                fit: BoxFit.cover,
                color: Colors.white.withOpacity(0.2), // Lighten to match the UI
                colorBlendMode: BlendMode.lighten,
              ),
            ),
            // Center Pin
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -4,
                      child: Container(
                        width: 24, height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
                        ),
                      ),
                    ),
                    const Icon(Icons.location_on, color: Color(0xFF0EA5A4), size: 48),
                  ],
                ),
              ),
            ),
            // Change on Map Button
            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.edit_location_alt, size: 16, color: Color(0xFF0F172A)),
                      SizedBox(width: 8),
                      Text('Change on map', style: TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            // Locate Me Button
            Positioned(
              bottom: 16, right: 16,
              child: Container(
                width: 48, height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
                ),
                child: const Icon(Icons.my_location, color: Color(0xFF0EA5A4), size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Positioned(
      top: 245, left: 0, right: 0, bottom: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
          boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -8))],
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
          physics: const BouncingScrollPhysics(),
          children: [
            _buildSaveAddressAs(),
            const SizedBox(height: 32),
            _buildAddressFields(),
            const SizedBox(height: 32),
            _buildReceiverDetails(),
            const SizedBox(height: 32),
            _buildDeliveryInstructions(),
            const SizedBox(height: 32),
            _buildImageUpload(),
            const SizedBox(height: 48), // Bottom CTA spacing
          ],
        ),
      ),
    );
  }

  Widget _buildSaveAddressAs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SAVE ADDRESS AS', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: [
            _buildTagChip('Home', Icons.home),
            _buildTagChip('Work', Icons.work),
            _buildTagChip('Favorite', Icons.favorite),
            _buildTagChip('Other', Icons.location_on),
            _buildTagChip('Custom', Icons.add, isDashed: true),
          ],
        ),
      ],
    );
  }

  Widget _buildTagChip(String label, IconData icon, {bool isDashed = false}) {
    final isSelected = _selectedTag == label;
    return GestureDetector(
      onTap: () {
        if (!isDashed) setState(() => _selectedTag = label);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(30),
          border: isDashed
              ? Border.all(color: const Color(0xFFE2E8E9), style: BorderStyle.solid) // Flutter doesn't natively do dashed borders easily without a package, using solid for now
              : Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.white : const Color(0xFF0F172A), size: 18),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField('Flat / House no.', Icons.apartment)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Floor', Icons.layers)),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField('Building / Apartment name', Icons.domain),
        const SizedBox(height: 16),
        _buildTextField('Landmark (optional)', Icons.tour),
        const SizedBox(height: 16),
        _buildTextField('Area / Street', Icons.streetview),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField('City', Icons.location_city)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Pincode', Icons.pin_drop, keyboardType: TextInputType.number)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, IconData icon, {TextInputType? keyboardType, String? initialValue}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500),
          floatingLabelStyle: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold),
          prefixIcon: Icon(icon, color: const Color(0xFF64748B)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildReceiverDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Receiver details', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTextField('Receiver name', Icons.person, initialValue: 'Aarav Kumar'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildPhoneField('Phone number', Icons.call)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Alternate phone (optional)', Icons.contact_phone, keyboardType: TextInputType.phone)),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneField(String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500),
          floatingLabelStyle: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('+91', style: TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Icon(icon, color: const Color(0xFF64748B), size: 20),
              ],
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDeliveryInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Delivery instructions', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            maxLines: 3,
            style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              hintText: 'Door bell / security gate / pickup instructions',
              hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 14),
              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 48), // Align top
                child: Icon(Icons.sticky_note_2, color: Color(0xFF64748B)),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Help the pilot find you', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildUploadBox('Add building photo', Icons.photo_camera),
              const SizedBox(width: 16),
              _buildUploadBox('Add door photo', Icons.camera_front),
              const SizedBox(width: 16),
              _buildUploadBox('Parking entrance', Icons.local_parking),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox(String label, IconData icon) {
    return Container(
      width: 128, height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9), width: 2), // Representing dashed with solid for simplicity
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 28),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TermsScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0EA5A4),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.save, size: 20),
              SizedBox(width: 8),
              Text('Save address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
