import 'package:flutter/material.dart';
import 'package:laundry/presentation/widgets/app_widgets.dart';
import 'package:laundry/core/services/location_service.dart';
import 'package:laundry/presentation/screens/main_layout_screen.dart';


class AddAddressScreen extends StatefulWidget {
  final bool isFromOnboarding;

  const AddAddressScreen({
    super.key, 
    this.isFromOnboarding = false,
  });

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedTag = 'Home';
  bool _isFetchingLocation = false;

  // Controllers for all fields
  final _flatController      = TextEditingController();
  final _floorController     = TextEditingController();
  final _buildingController  = TextEditingController();
  final _landmarkController  = TextEditingController();
  final _streetController    = TextEditingController();
  final _cityController      = TextEditingController();
  final _pincodeController   = TextEditingController();
  final _nameController      = TextEditingController(text: 'Aarav Kumar');
  final _phoneController     = TextEditingController();
  final _altPhoneController  = TextEditingController();
  final _instructionsController = TextEditingController();

  @override
  void dispose() {
    _flatController.dispose();
    _floorController.dispose();
    _buildingController.dispose();
    _landmarkController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _altPhoneController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _fetchLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      final position = await LocationService.getCurrentPosition();
      if (position != null) {
        final address = await LocationService.getAddressFromCoordinates(
            position.latitude, position.longitude);
        if (mounted && address != null) {
          // Auto-fill the street field with the fetched address
          setState(() {
            _streetController.text = address;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location filled: $address'),
              backgroundColor: AppColors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not fetch location: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isFetchingLocation = false);
    }
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) return;

    // Build human-readable address string
    final parts = [
      if (_flatController.text.isNotEmpty) _flatController.text,
      if (_floorController.text.isNotEmpty) 'Floor ${_floorController.text}',
      if (_buildingController.text.isNotEmpty) _buildingController.text,
      if (_landmarkController.text.isNotEmpty) _landmarkController.text,
      if (_streetController.text.isNotEmpty) _streetController.text,
      if (_cityController.text.isNotEmpty) _cityController.text,
      if (_pincodeController.text.isNotEmpty) _pincodeController.text,
    ];
    final fullAddress = parts.join(', ');

    if (widget.isFromOnboarding) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainLayoutScreen()),
        (route) => false,
      );
    } else {
      Navigator.pop(context, {
        'tag': _selectedTag,
        'name': _nameController.text.trim(),
        'phone': '+91 ${_phoneController.text.trim()}',
        'address': fullAddress,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            // 1. Full Bleed Map Background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.45,
              child: _buildFullBleedMap(),
            ),

            // 2. Floating Header over Map
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildFloatingHeader(context),
            ),

            // 3. Bottom Sheet Form
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomSheetForm(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomCTA(context),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildFloatingHeader(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: topPadding, left: 8, right: 16),
      height: topPadding + 56,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
              splashRadius: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullBleedMap() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBvImjyOyrwww1Ryezd6RZ_e_o8sSUEZIIG3LaoLLWGkV_iojDJmX4F_QGVKWweGv9crW9JWSqYH5VpsbW1pBnQbXzMsCO2qfQvBQOEdRKX6LvQzw1cgNOAfncinfRCg-tvhw3Qrk0l6xXDQ9vhDIdhmboOb0TSYC_-oOzQMaRcDgSpI5PNPE0uJRIFUc9tpCu7OO0oXjYncQ10x9pHeC9rWthcN71PJ91mQ6XDZGlLC7IVAu-gD9qGoNC2BD6Pk4oTqSPNqpT9j23G',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.1),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        // Center Pin
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32), // Offset pin to visually center it above the sheet
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Order will be delivered here', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                const Icon(Icons.location_on, color: Color(0xFFE23744), size: 48), // Zomato Red pin
              ],
            ),
          ),
        ),
        // GPS button
        Positioned(
          bottom: 32,
          right: 16,
          child: GestureDetector(
            onTap: _fetchLocation,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, 4))],
              ),
              child: _isFetchingLocation
                  ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFE23744)))
                  : const Icon(Icons.my_location, color: Color(0xFFE23744), size: 24),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheetForm() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Drag handle pill
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8E9),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              physics: const BouncingScrollPhysics(),
              children: [
                const Text('Enter complete address', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.w800)),
                const SizedBox(height: 24),
                
                // Address Info (mocked picked address)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined, color: Color(0xFFE23744), size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Brigade Road', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Shanthala Nagar, Ashok Nagar, Bengaluru, Karnataka 560001, India', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                _buildSaveAddressAs(),
                const SizedBox(height: 32),

                _buildAddressFields(),
                const SizedBox(height: 32),

                _buildReceiverDetails(),
                const SizedBox(height: 32),

                _buildDeliveryInstructions(),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveAddressAs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Save address as *', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildTagChip('Home', Icons.home_outlined),
            _buildTagChip('Work', Icons.work_outline),
            _buildTagChip('Hotel', Icons.apartment_outlined),
            _buildTagChip('Other', Icons.location_on_outlined),
          ],
        ),
      ],
    );
  }

  Widget _buildTagChip(String label, IconData icon) {
    final isSelected = _selectedTag == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTag = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE23744).withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? const Color(0xFFE23744) : const Color(0xFFE2E8E9)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFE23744) : const Color(0xFF64748B), size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    color: isSelected ? const Color(0xFFE23744) : const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Complete Address *', 'House No. / Flat / Floor / Building', controller: _flatController, required: true),
        const SizedBox(height: 24),
        _buildTextField('Nearby Landmark (Optional)', 'e.g. Near Apollo Hospital', controller: _landmarkController),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildTextField('City *', 'e.g. Bengaluru', controller: _cityController, required: true)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Pincode *', 'e.g. 560001',
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                required: true)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool required = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
      validator: required
          ? (val) {
              if (val == null || val.trim().isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
        floatingLabelStyle: const TextStyle(color: Color(0xFFE23744), fontSize: 14, fontWeight: FontWeight.bold),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE2E8E9))),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE23744), width: 2)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        errorStyle: const TextStyle(fontSize: 10),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }

  Widget _buildReceiverDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Receiver details', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTextField('Receiver name *', 'e.g. Aarav Kumar', controller: _nameController, required: true),
        const SizedBox(height: 24),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          validator: (val) {
            if (val == null || val.trim().isEmpty) return 'Phone number is required';
            if (val.trim().length < 10) return 'Enter a valid 10-digit phone number';
            return null;
          },
          style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            labelText: 'Phone number *',
            hintText: 'e.g. 9876543210',
            labelStyle: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500),
            floatingLabelStyle: TextStyle(color: Color(0xFFE23744), fontSize: 14, fontWeight: FontWeight.bold),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE2E8E9))),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFE23744), width: 2)),
            contentPadding: EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Delivery instructions (Optional)', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          controller: _instructionsController,
          maxLines: 2,
          style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: 'e.g. Ring the bell, leave at door',
            hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8E9))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE23744), width: 2)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: _saveAddress,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE23744), // Zomato Red CTA
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Save Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
