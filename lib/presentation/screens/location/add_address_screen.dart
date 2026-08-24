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
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Form(
        key: _formKey,
        child: Column(
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
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(BuildContext context, double topPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, topPadding + 8, 8, 8),
      height: topPadding + 64,
      decoration: const BoxDecoration(
        color: Colors.white,
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
            child: Text('Add new address',
                style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold)),
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
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Map Image placeholder
            Positioned.fill(
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBvImjyOyrwww1Ryezd6RZ_e_o8sSUEZIIG3LaoLLWGkV_iojDJmX4F_QGVKWweGv9crW9JWSqYH5VpsbW1pBnQbXzMsCO2qfQvBQOEdRKX6LvQzw1cgNOAfncinfRCg-tvhw3Qrk0l6xXDQ9vhDIdhmboOb0TSYC_-oOzQMaRcDgSpI5PNPE0uJRIFUc9tpCu7OO0oXjYncQ10x9pHeC9rWthcN71PJ91mQ6XDZGlLC7IVAu-gD9qGoNC2BD6Pk4oTqSPNqpT9j23G',
                fit: BoxFit.cover,
                color: Colors.white.withValues(alpha: 0.2),
                colorBlendMode: BlendMode.lighten,
                errorBuilder: (e1, e2, e3) => const Center(
                  child: Icon(Icons.map, color: Color(0xFF0EA5A4), size: 64),
                ),
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
                          color: Colors.black.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Icon(Icons.location_on, color: Color(0xFF0EA5A4), size: 48),
                  ],
                ),
              ),
            ),
            // GPS button
            Positioned(
              bottom: 16, right: 16,
              child: GestureDetector(
                onTap: _fetchLocation,
                child: Container(
                  width: 48, height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
                  ),
                  child: _isFetchingLocation
                      ? const Padding(padding: EdgeInsets.all(12), child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.my_location, color: Color(0xFF0EA5A4), size: 24),
                ),
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
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveAddressAs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SAVE ADDRESS AS',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: [
            _buildTagChip('Home', Icons.home),
            _buildTagChip('Work', Icons.work),
            _buildTagChip('Favorite', Icons.favorite),
            _buildTagChip('Other', Icons.location_on),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.cardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.white : AppColors.textPrimary, size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Address details',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField('Flat / House no. *', Icons.apartment, controller: _flatController, required: true)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Floor', Icons.layers, controller: _floorController)),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField('Building / Apartment name *', Icons.domain, controller: _buildingController, required: true),
        const SizedBox(height: 16),
        _buildTextField('Landmark (optional)', Icons.tour, controller: _landmarkController),
        const SizedBox(height: 16),
        _buildTextField('Area / Street *', Icons.streetview, controller: _streetController, required: true),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField('City *', Icons.location_city, controller: _cityController, required: true)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Pincode *', Icons.pin_drop,
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                required: true)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, IconData icon, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool required = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
        validator: required
            ? (val) {
                if (val == null || val.trim().isEmpty) {
                  return '${label.replaceAll(' *', '')} is required';
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500),
          floatingLabelStyle: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold),
          prefixIcon: Icon(icon, color: AppColors.textSecondary),
          border: InputBorder.none,
          errorStyle: const TextStyle(fontSize: 10),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildReceiverDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Receiver details',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTextField('Receiver name *', Icons.person, controller: _nameController, required: true),
        const SizedBox(height: 16),
        // Phone field
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: (val) {
              if (val == null || val.trim().isEmpty) return 'Phone number is required';
              if (val.trim().length < 10) return 'Enter a valid 10-digit phone number';
              return null;
            },
            style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              labelText: 'Phone number *',
              labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500),
              floatingLabelStyle: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('+91', style: TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Icon(Icons.call, color: Color(0xFF64748B), size: 20),
                  ],
                ),
              ),
              border: InputBorder.none,
              errorStyle: const TextStyle(fontSize: 10),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField('Alternate phone (optional)', Icons.contact_phone,
            controller: _altPhoneController, keyboardType: TextInputType.phone),
      ],
    );
  }

  Widget _buildDeliveryInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Delivery instructions',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _instructionsController,
            maxLines: 3,
            style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              hintText: 'Door bell / security gate / pickup instructions',
              hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 14),
              prefixIcon: Padding(
                padding: EdgeInsets.only(bottom: 48),
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

  Widget _buildBottomCTA(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, -2))],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: _saveAddress,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 4,
            minimumSize: const Size(double.infinity, 56),
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
