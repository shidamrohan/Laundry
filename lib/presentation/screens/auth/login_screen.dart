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
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          children: [
            // --- TOP NAVIGATION ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 24,
                  ),
                  splashRadius: 24,
                ),
              ),
            ),
            
            // --- MAIN CONTENT CONTAINER ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Branding
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0EA5A4).withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.waves, color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Enter your number',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "We'll send you a verification code by SMS.",
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Phone Input Section
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isPhoneFocused ? const Color(0xFF0EA5A4) : const Color(0xFF1E293B),
                          width: _isPhoneFocused ? 2 : 1,
                        ),
                        boxShadow: _isPhoneFocused
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF0EA5A4).withOpacity(0.2),
                                  blurRadius: 0,
                                  spreadRadius: 2,
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
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: const [
                                  Text('🇮🇳', style: TextStyle(fontSize: 18)),
                                  SizedBox(width: 8),
                                  Text(
                                    '+91',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.expand_more, color: Color(0xFF94A3B8), size: 18),
                                ],
                              ),
                            ),
                          ),
                          // Divider
                          Container(
                            width: 1,
                            height: 24,
                            color: const Color(0xFF1E293B),
                          ),
                          // Text Input
                          Expanded(
                            child: TextField(
                              focusNode: _phoneFocusNode,
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '98765 43210',
                                hintStyle: TextStyle(
                                  color: Colors.white30,
                                  fontSize: 16,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 8,
                          shadowColor: const Color(0xFF0EA5A4).withOpacity(0.2),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                    
                    // Divider
                    const SizedBox(height: 40),
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Color(0xFF1E293B))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Color(0xFF1E293B))),
                      ],
                    ),
                    const SizedBox(height: 40),
                    
                    // --- SOCIAL BUTTONS ---
                    // Google
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1E293B)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                              height: 24,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata, color: Colors.white, size: 32),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Continue with Google',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Apple
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.apple, color: Colors.black, size: 28),
                            SizedBox(width: 8),
                            Text(
                              'Continue with Apple',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // --- FOOTER ---
            Padding(
              padding: EdgeInsets.fromLTRB(32, 16, 32, MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 24),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 13,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(text: 'By continuing you agree to our\n'),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(color: Color(0xFF0EA5A4)),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Color(0xFF0EA5A4)),
                    ),
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
