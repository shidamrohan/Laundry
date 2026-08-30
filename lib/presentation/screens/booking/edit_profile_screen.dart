import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Profile', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF64748B)),
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE2E8E9)),
        ),
      ),
      body: Stack(
        children: [
          // Background decoration
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Stack(
                children: [
                  Positioned(
                    top: -50, right: -50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0x260EA5A4), // rgba(14,165,164,0.15) proxy
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50, left: -50,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0x1A2563EB), // rgba(37,99,235,0.1) proxy
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Content
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 120),
              child: Column(
                children: [
                  // Hero Section: Avatar
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 112, height: 112,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Color(0x260F172A), blurRadius: 16, offset: Offset(0, 4))],
                            ),
                            alignment: Alignment.center,
                            child: const Text('AK', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: -1.0)),
                          ),
                          Positioned(
                            bottom: 0, right: 0,
                            child: Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0EA5A4),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 4),
                                boxShadow: const [BoxShadow(color: Color(0x26000000), blurRadius: 6, offset: Offset(0, 2))],
                              ),
                              child: const Icon(Icons.photo_camera, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Profile completeness: 85%', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Form Container
                  _buildFloatingLabelField(
                    icon: Icons.person,
                    label: 'Full name',
                    value: 'Aarav Kumar',
                    trailing: const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 20),
                  ),
                  const SizedBox(height: 24),

                  _buildFloatingLabelField(
                    icon: Icons.call,
                    label: 'Phone number',
                    value: '+91 98765 43210',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0x1A16A34A), borderRadius: BorderRadius.circular(10)),
                          child: const Text('VERIFIED', style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                          child: const Text('Change', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildFloatingLabelField(
                    icon: Icons.mail,
                    label: 'Email',
                    value: 'aarav@email.com',
                    helperText: "We'll use this for receipts and updates.",
                  ),
                  const SizedBox(height: 24),

                  _buildFloatingLabelField(
                    icon: Icons.calendar_today,
                    label: 'Date of birth',
                    value: '12 Aug 1996',
                  ),
                  const SizedBox(height: 24),

                  _buildFloatingLabelField(
                    icon: Icons.celebration,
                    label: 'Anniversary (Optional)',
                    value: '',
                    trailing: const Text('Add date', style: TextStyle(color: Color(0x6664748B), fontSize: 14, fontStyle: FontStyle.italic)),
                  ),
                  const SizedBox(height: 24),

                  // Gender Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Gender', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: ['Male', 'Female', 'Other'].map((gender) {
                            final isSelected = _selectedGender == gender;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedGender = gender),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF0EA5A4) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: isSelected ? [const BoxShadow(color: Color(0x1A0EA5A4), blurRadius: 4, offset: Offset(0, 2))] : [],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    gender,
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action Area
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xCCFFFFFF), // surface/80
                border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
              ),
              child: SafeArea(
                top: false,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [BoxShadow(color: Color(0x330EA5A4), blurRadius: 16, offset: Offset(0, 4))],
                  ),
                  child: ElevatedButton(
                    onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Save changes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingLabelField({
    required IconData icon,
    required String label,
    required String value,
    Widget? trailing,
    String? helperText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent, width: 2), // Focus simulation would toggle this to primary
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF64748B)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (value.isNotEmpty)
                      Text(label, style: const TextStyle(color: Color(0x9964748B), fontSize: 10, fontWeight: FontWeight.w500)),
                    Text(
                      value.isNotEmpty ? value : label,
                      style: TextStyle(
                        color: value.isNotEmpty ? const Color(0xFF0F172A) : const Color(0x9964748B),
                        fontSize: value.isNotEmpty ? 15 : 14,
                        fontWeight: value.isNotEmpty ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 8),
                trailing,
              ],
            ],
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 44),
            child: Text(helperText, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
          ),
        ],
      ],
    );
  }
}
