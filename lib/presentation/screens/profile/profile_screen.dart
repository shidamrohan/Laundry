import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedGender;
  String _selectedLanguage = 'English';

  final List<String> _genders = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
  final List<String> _languages = ['English', 'Hindi', 'Tamil', 'Telugu', 'Kannada', 'Marathi'];

  @override
  void dispose() {
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _buildPickerSheet(
        title: 'Select Gender',
        items: _genders,
        selected: _selectedGender,
        onSelect: (val) {
          setState(() => _selectedGender = val);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _buildPickerSheet(
        title: 'Preferred Language',
        items: _languages,
        selected: _selectedLanguage,
        onSelect: (val) {
          setState(() => _selectedLanguage = val);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildPickerSheet({
    required String title,
    required List<String> items,
    required String? selected,
    required ValueChanged<String> onSelect,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8E9),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) {
          final isSelected = item == selected;
          return InkWell(
            onTap: () => onSelect(item),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFF0F172A),
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check, color: Color(0xFF0EA5A4), size: 20),
                ],
              ),
            ),
          );
        }),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // --- STICKY HEADER ---
            Container(
              color: const Color(0xFFF7FAFB).withValues(alpha: 0.92),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                children: [
                  // App bar row
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Progress bar (90%)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        Container(
                          height: 6,
                          width: double.infinity,
                          color: const Color(0xFFE2E8E9),
                        ),
                        Container(
                          height: 6,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0EA5A4),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF0EA5A4).withValues(alpha: 0.4),
                                blurRadius: 8,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- SCROLLABLE CONTENT ---
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(24, 24, 24, bottomPadding + 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HERO TEXT ---
                    const Text(
                      'Complete your profile',
                      style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add a few details to personalize your VOSHIFY experience.',
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // --- AVATAR ---
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
                              ),
                              border: Border.all(color: const Color(0xFFF7FAFB), width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0EA5A4).withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'AK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0EA5A4),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFFF7FAFB), width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 8,
                                    )
                                  ],
                                ),
                                child: const Icon(Icons.photo_camera, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),

                    // --- FORM FIELDS ---
                    // Full Name (pre-filled, read-only)
                    _buildFormField(
                      icon: Icons.person_outline,
                      label: 'FULL NAME *',
                      labelColor: const Color(0xFF0EA5A4),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Aarav Kumar',
                              style: TextStyle(color: Color(0xFF0F172A), fontSize: 16),
                            ),
                          ),
                          const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Email
                    _buildFormField(
                      icon: Icons.mail_outline,
                      label: 'EMAIL ADDRESS',
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'e.g. aarav@voshify.com',
                          hintStyle: TextStyle(color: Color(0xFF334155), fontSize: 16),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Gender
                    GestureDetector(
                      onTap: _showGenderPicker,
                      child: _buildFormField(
                        icon: Icons.wc_outlined,
                        label: 'GENDER',
                        trailing: const Icon(Icons.expand_more, color: Color(0xFF94A3B8), size: 22),
                        child: Text(
                          _selectedGender ?? 'Select gender',
                          style: TextStyle(
                            color: _selectedGender != null ? const Color(0xFF0F172A) : const Color(0xFF334155),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Preferred Language
                    GestureDetector(
                      onTap: _showLanguagePicker,
                      child: _buildFormField(
                        icon: Icons.language_outlined,
                        label: 'PREFERRED LANGUAGE',
                        trailing: const Icon(Icons.expand_more, color: Color(0xFF94A3B8), size: 22),
                        child: Text(
                          _selectedLanguage,
                          style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Preferred Pickup Address
                    _buildFormField(
                      icon: Icons.location_on_outlined,
                      label: 'PREFERRED PICKUP ADDRESS',
                      child: TextField(
                        controller: _addressController,
                        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your address',
                          hintStyle: TextStyle(color: Color(0xFF334155), fontSize: 16),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.my_location, color: Color(0xFF0EA5A4), size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Use current location',
                            style: TextStyle(
                              color: Color(0xFF0EA5A4),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // --- FIXED BOTTOM ACTIONS ---
      bottomSheet: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFFF7FAFB).withValues(alpha: 0),
                const Color(0xFFF7FAFB),
                const Color(0xFFF7FAFB),
              ],
            ),
          ),
          padding: EdgeInsets.fromLTRB(24, 16, 24, bottomPadding > 0 ? bottomPadding + 8 : 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0EA5A4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 8,
                    shadowColor: const Color(0xFF0EA5A4).withValues(alpha: 0.3),
                  ),
                  child: const Text(
                    'Save & Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Skip for now',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required IconData icon,
    required String label,
    required Widget child,
    Color labelColor = const Color(0xFF94A3B8),
    Widget? trailing,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Colors.white,
        border: Border.all(color: const Color(0xFFE2E8E9)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF94A3B8), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                child,
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
