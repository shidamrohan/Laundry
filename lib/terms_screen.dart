import 'package:flutter/material.dart';
import 'profile_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _termsAgreed = false;
  bool _marketingAgreed = false;

  final List<Map<String, dynamic>> _policies = [
    {'icon': Icons.description_outlined, 'label': 'Terms of Service'},
    {'icon': Icons.shield_outlined, 'label': 'Privacy Policy'},
    {'icon': Icons.payments_outlined, 'label': 'Refund Policy'},
    {'icon': Icons.cookie_outlined, 'label': 'Data Usage & Cookies'},
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Stack(
        children: [
          // --- ATMOSPHERIC GLOW ---
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5A4).withOpacity(0.08),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0EA5A4).withOpacity(0.1),
                    blurRadius: 100,
                    spreadRadius: 60,
                  )
                ],
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // --- TOP APP BAR ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: const Icon(Icons.chevron_left, color: Color(0xFF0EA5A4), size: 28),
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0EA5A4),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0EA5A4).withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: const Icon(Icons.local_laundry_service, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                // --- SCROLLABLE CONTENT ---
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- HERO ---
                        const Text(
                          'Before you continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Please review and accept our policies to start using Orio.',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 36),

                        // --- POLICY CARDS ---
                        ...List.generate(_policies.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildPolicyRow(
                              icon: _policies[index]['icon'] as IconData,
                              label: _policies[index]['label'] as String,
                            ),
                          );
                        }),

                        const SizedBox(height: 36),

                        // --- CONSENT CHECKBOXES ---
                        _buildCheckboxRow(
                          id: 'terms',
                          checked: _termsAgreed,
                          onChanged: (val) => setState(() => _termsAgreed = val ?? false),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 15,
                                height: 1.4,
                              ),
                              children: [
                                const TextSpan(text: 'I agree to the '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Terms of Service',
                                      style: TextStyle(
                                        color: Color(0xFF0EA5A4),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const TextSpan(text: ' and '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Privacy Policy',
                                      style: TextStyle(
                                        color: Color(0xFF0EA5A4),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildCheckboxRow(
                          id: 'marketing',
                          checked: _marketingAgreed,
                          onChanged: (val) => setState(() => _marketingAgreed = val ?? false),
                          child: const Text(
                            "I'd like to receive offers and promotional notifications",
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- FIXED BOTTOM ACTION BAR ---
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0B1220).withOpacity(0),
                    const Color(0xFF0B1220),
                    const Color(0xFF0B1220),
                  ],
                ),
              ),
              padding: EdgeInsets.fromLTRB(24, 16, 24, bottomPadding > 0 ? bottomPadding + 8 : 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _termsAgreed ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        );
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0EA5A4),
                        disabledBackgroundColor: const Color(0xFF0EA5A4).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: _termsAgreed ? 8 : 0,
                        shadowColor: const Color(0xFF0EA5A4).withOpacity(0.3),
                      ),
                      child: Text(
                        'Agree & Continue',
                        style: TextStyle(
                          color: _termsAgreed ? Colors.white : Colors.white54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Version 2.4.1 • Updated Oct 2023',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 13,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyRow({required IconData icon, required String label}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          border: Border.all(color: const Color(0xFF1E293B)),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0EA5A4), size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF94A3B8), size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow({
    required String id,
    required bool checked,
    required ValueChanged<bool?> onChanged,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!checked),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: checked,
              onChanged: onChanged,
              activeColor: const Color(0xFF0EA5A4),
              side: const BorderSide(color: Color(0xFF1E293B), width: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: child,
          )),
        ],
      ),
    );
  }
}
