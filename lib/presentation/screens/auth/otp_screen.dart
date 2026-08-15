import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/location/location_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _spinnerController;
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _spinnerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    
    // Auto focus the hidden textfield
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_otpFocusNode);
    });
  }

  @override
  void dispose() {
    _spinnerController.dispose();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Stack(
        children: [
          // --- DECORATIVE ELEMENTS ---
          Positioned(
            bottom: -96,
            left: -96,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5A4).withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0EA5A4).withOpacity(0.15),
                    blurRadius: 80,
                    spreadRadius: 40,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: -48,
            right: -48,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB).withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.15),
                    blurRadius: 60,
                    spreadRadius: 30,
                  )
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- BACK BUTTON ---
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                alignment: Alignment.centerLeft,
                                child: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // --- APP ICON MARK ---
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0EA5A4).withOpacity(0.2),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.waves, color: Colors.white, size: 28),
                            ),
                            const SizedBox(height: 24),
                            
                            // --- HEADLINES ---
                            const Text(
                              'Verify your number',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 15,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(text: 'Enter the 6-digit code sent to '),
                                  TextSpan(
                                    text: widget.phoneNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: Color(0xFF0EA5A4),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 40),
                            
                            // --- OTP INPUT SECTION ---
                            Stack(
                              children: [
                                // Hidden TextField to capture inputs seamlessly
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Opacity(
                                    opacity: 0.0,
                                    child: TextField(
                                      controller: _otpController,
                                      focusNode: _otpFocusNode,
                                      keyboardType: TextInputType.number,
                                      maxLength: 6,
                                      onChanged: (value) {
                                        setState(() {}); // Trigger rebuild to update UI cells
                                        if (value.length == 6) {
                                          _otpFocusNode.unfocus();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                // Visible Custom OTP Cells
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(_otpFocusNode);
                                  },
                                  child: Container(
                                    color: Colors.transparent, // Ensure taps pass through the row
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: List.generate(6, (index) {
                                        String? charValue;
                                        if (index < _otpController.text.length) {
                                          charValue = _otpController.text[index];
                                        }
                                        // The cell is active if it's the next one to be typed into
                                        bool isActive = _otpFocusNode.hasFocus && index == _otpController.text.length;
                                        
                                        return _buildOtpCell(value: charValue, isActive: isActive);
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // --- STATUS CHIP ---
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E293B).withOpacity(0.5),
                                  border: Border.all(color: const Color(0xFF1E293B).withOpacity(0.8)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RotationTransition(
                                      turns: _spinnerController,
                                      child: const Icon(Icons.sync, color: Color(0xFF0EA5A4), size: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _otpController.text.length == 6 ? 'Verifying OTP...' : 'Auto-detecting OTP…',
                                      style: const TextStyle(
                                        color: Color(0xFF94A3B8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            const Expanded(child: SizedBox(height: 32)), // Pushes footer safely to the bottom
                            
                            // --- FOOTER / ACTION AREA ---
                            Center(
                              child: Column(
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        color: Color(0xFF94A3B8),
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(text: 'Resend code in '),
                                        TextSpan(
                                          text: '00:28',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'monospace',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Resend code',
                                    style: TextStyle(
                                      color: Color(0x660EA5A4),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 32),
                            
                            // Primary CTA
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _otpController.text.length == 6 ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LocationScreen(),
                                    ),
                                  );
                                } : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0EA5A4),
                                  disabledBackgroundColor: const Color(0xFF0EA5A4).withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  elevation: _otpController.text.length == 6 ? 8 : 0,
                                  shadowColor: const Color(0xFF0EA5A4).withOpacity(0.2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Verify',
                                      style: TextStyle(
                                        color: _otpController.text.length == 6 ? Colors.white : Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(Icons.arrow_forward, color: _otpController.text.length == 6 ? Colors.white : Colors.white70, size: 20),
                                  ],
                                ),
                              ),
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpCell({String? value, bool isActive = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 52,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        border: Border.all(
          color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF1E293B),
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF0EA5A4).withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 0,
                )
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: value != null && value.isNotEmpty
          ? Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : isActive
              ? const BlinkingCaret()
              : null,
    );
  }
}

// Custom widget to recreate the blinking caret animation from the design
class BlinkingCaret extends StatefulWidget {
  const BlinkingCaret({super.key});

  @override
  State<BlinkingCaret> createState() => _BlinkingCaretState();
}

class _BlinkingCaretState extends State<BlinkingCaret> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 2,
        height: 24,
        color: const Color(0xFF0EA5A4),
      ),
    );
  }
}
