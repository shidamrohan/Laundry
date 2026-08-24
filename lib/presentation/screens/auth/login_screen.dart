import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/auth/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isPhoneFocused = false;

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(() {
      setState(() {
        _isPhoneFocused = _phoneFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // --- HERO IMAGE ---
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBvImjyOyrwww1Ryezd6RZ_e_o8sSUEZIIG3LaoLLWGkV_iojDJmX4F_QGVKWweGv9crW9JWSqYH5VpsbW1pBnQbXzMsCO2qfQvBQOEdRKX6LvQzw1cgNOAfncinfRCg-tvhw3Qrk0l6xXDQ9vhDIdhmboOb0TSYC_-oOzQMaRcDgSpI5PNPE0uJRIFUc9tpCu7OO0oXjYncQ10x9pHeC9rWthcN71PJ91mQ6XDZGlLC7IVAu-gD9qGoNC2BD6Pk4oTqSPNqpT9j23G'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Gradient overlay for seamless transition
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.0),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),
              // Back Button
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, color: Color(0xFF0F172A), size: 20),
                  ),
                ),
              ),
            ],
          ),

          // --- MAIN CONTENT CONTAINER ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'India\'s #1 Laundry App',
                    style: TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 32,
                        height: 1,
                        color: const Color(0xFFCBD5E1),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'Log in or sign up',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 32,
                        height: 1,
                        color: const Color(0xFFCBD5E1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Phone Input Section
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isPhoneFocused ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
                        width: _isPhoneFocused ? 2 : 1,
                      ),
                      boxShadow: _isPhoneFocused
                          ? [
                              BoxShadow(
                                color: const Color(0xFF0EA5A4).withValues(alpha: 0.1),
                                blurRadius: 8,
                                spreadRadius: 0,
                              )
                            ]
                          : null,
                    ),
                    child: Row(
                      children: [
                        // Country Code picker
                        InkWell(
                          onTap: () {},
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: const [
                                Text('🇮🇳', style: TextStyle(fontSize: 20)),
                                SizedBox(width: 8),
                                Text(
                                  '+91',
                                  style: TextStyle(
                                    color: Color(0xFF0F172A),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.expand_more, color: Color(0xFF64748B), size: 18),
                              ],
                            ),
                          ),
                        ),
                        // Divider
                        Container(
                          width: 1,
                          height: 24,
                          color: const Color(0xFFE2E8E9),
                        ),
                        // Text Input
                        Expanded(
                          child: TextField(
                            focusNode: _phoneFocusNode,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter phone number',
                              hintStyle: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Primary CTA
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OtpScreen(phoneNumber: '+91 98765 43210'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0EA5A4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Divider
                  const SizedBox(height: 32),
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Color(0xFFE2E8E9))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE2E8E9))),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // --- SOCIAL BUTTONS ---
                  Row(
                    children: [
                      Expanded(
                        child: _SocialButton(
                          iconUrl: 'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SocialButton(
                          iconUrl: 'https://cdn-icons-png.flaticon.com/512/0/747.png',
                          onTap: () {},
                          isDarkIcon: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SocialButton(
                          icon: Icons.more_horiz,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),

          // --- FOOTER ---
          Container(
            padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFF1F5F9)),
              ),
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(text: 'By continuing, you agree to our\n'),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: '  •  '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: '  •  '),
                  TextSpan(
                    text: 'Content Policies',
                    style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String? iconUrl;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isDarkIcon;

  const _SocialButton({
    this.iconUrl,
    this.icon,
    required this.onTap,
    this.isDarkIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8E9)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: iconUrl != null
            ? Image.network(
                iconUrl!,
                height: 24,
                color: isDarkIcon ? const Color(0xFF0F172A) : null,
              )
            : Icon(icon, color: const Color(0xFF0F172A), size: 28),
      ),
    );
  }
}
