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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
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
                        // --- HEADLINES ---
                        const Text(
                          'OTP Verification',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 15,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(text: 'We have sent a verification code to\n'),
                              TextSpan(
                                text: widget.phoneNumber,
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
                        
                        // --- RESEND CODE / STATUS ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Didn\'t receive the code?',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                RotationTransition(
                                  turns: _spinnerController,
                                  child: const Icon(Icons.sync, color: Color(0xFF0EA5A4), size: 14),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Resend in 00:28',
                                  style: TextStyle(
                                    color: Color(0xFF0EA5A4),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        const Expanded(child: SizedBox(height: 32)), // Pushes footer safely to the bottom
                        
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
                              disabledBackgroundColor: const Color(0xFF0EA5A4).withValues(alpha: 0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Verify',
                              style: TextStyle(
                                color: _otpController.text.length == 6 ? Colors.white : Colors.white.withValues(alpha: 0.8),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? MediaQuery.of(context).padding.bottom : 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildOtpCell({String? value, bool isActive = false}) {
    final hasValue = value != null && value.isNotEmpty;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 52,
      height: 56,
      decoration: BoxDecoration(
        color: hasValue || isActive ? Colors.white : const Color(0xFFF8FAFC),
        border: Border.all(
          color: isActive ? const Color(0xFF0EA5A4) : (hasValue ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8E9)),
          width: isActive ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF0EA5A4).withValues(alpha: 0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                )
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: hasValue
          ? Text(
              value,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 24,
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
