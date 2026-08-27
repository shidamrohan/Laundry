import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:laundry/presentation/screens/location/location_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  
  Timer? _timer;
  int _start = 30;
  bool _isResendActive = false;
  bool _isVerifying = false;

  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _startTimer();
    
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    
    // Auto focus the hidden textfield
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_otpFocusNode);
    });
  }

  void _startTimer() {
    setState(() {
      _start = 30;
      _isResendActive = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _isResendActive = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeController.dispose();
    _otpController.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }
  
  void _verifyOtp() {
    if (_otpController.text.length != 6) return;
    
    // Simulate invalid OTP if it's 111111 for demo
    if (_otpController.text == '111111') {
      _shakeController.forward(from: 0.0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid OTP. Please try again.'),
          backgroundColor: Colors.redAccent,
        )
      );
      _otpController.clear();
      setState(() {});
      return;
    }

    setState(() => _isVerifying = true);
    
    // Simulate network delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LocationScreen()),
        );
      }
    });
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
                        // --- ILLUSTRATION OR ICON ---
                        Center(
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0EA5A4).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.mark_email_read_outlined,
                              color: Color(0xFF0EA5A4),
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // --- HEADLINES ---
                        const Center(
                          child: Text(
                            'Verify with OTP',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // --- PHONE NUMBER WITH EDIT BUTTON ---
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sent to ${widget.phoneNumber}',
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Color(0xFF0EA5A4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 48),
                        
                        // --- OTP INPUT SECTION ---
                        AnimatedBuilder(
                          animation: _shakeController,
                          builder: (context, child) {
                            // Simple shake math
                            final sineValue = 
                                (10 * _shakeController.value * 3.14159 * 4).toInt();
                            final offset = (sineValue % 2 == 0) ? 5.0 : -5.0;
                            final xOffset = _shakeController.value > 0 ? offset : 0.0;
                            
                            return Transform.translate(
                              offset: Offset(xOffset, 0),
                              child: child,
                            );
                          },
                          child: Stack(
                            children: [
                              // Hidden TextField to capture inputs seamlessly
                              Positioned(
                                top: 0, left: 0, right: 0,
                                child: Opacity(
                                  opacity: 0.0,
                                  child: TextField(
                                    controller: _otpController,
                                    focusNode: _otpFocusNode,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    maxLength: 6,
                                    onChanged: (value) {
                                      setState(() {}); 
                                      if (value.length == 6) {
                                        _otpFocusNode.unfocus();
                                        _verifyOtp(); // Auto submit
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
                                  color: Colors.transparent, 
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(6, (index) {
                                      String? charValue;
                                      if (index < _otpController.text.length) {
                                        charValue = _otpController.text[index];
                                      }
                                      bool isActive = _otpFocusNode.hasFocus && index == _otpController.text.length;
                                      bool isError = _shakeController.value > 0;
                                      
                                      return _buildOtpCell(
                                        value: charValue, 
                                        isActive: isActive,
                                        isError: isError,
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // --- RESEND CODE / STATUS ---
                        Center(
                          child: _isResendActive
                              ? GestureDetector(
                                  onTap: () {
                                    // Handle resend logic here
                                    _startTimer();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('OTP sent successfully!'),
                                        backgroundColor: Color(0xFF0EA5A4),
                                        duration: Duration(seconds: 2),
                                      )
                                    );
                                  },
                                  child: const Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                      color: Color(0xFF0EA5A4),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Resend code in '),
                                      TextSpan(
                                        text: '00:${_start.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          color: Color(0xFF0F172A),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                        
                        const Expanded(child: SizedBox(height: 32)), 
                        
                        // Primary CTA
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: (_otpController.text.length == 6 && !_isVerifying) 
                                ? _verifyOtp 
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5A4),
                              disabledBackgroundColor: const Color(0xFFE2E8E9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: _isVerifying
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Verify & Proceed',
                                    style: TextStyle(
                                      color: _otpController.text.length == 6 
                                          ? Colors.white 
                                          : const Color(0xFF94A3B8),
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

  Widget _buildOtpCell({String? value, bool isActive = false, bool isError = false}) {
    final hasValue = value != null && value.isNotEmpty;
    
    Color borderColor = const Color(0xFFE2E8E9);
    Color bgColor = const Color(0xFFF8FAFC);
    
    if (isError) {
      borderColor = Colors.redAccent;
      bgColor = Colors.red.withValues(alpha: 0.05);
    } else if (isActive) {
      borderColor = const Color(0xFF0EA5A4);
      bgColor = Colors.white;
    } else if (hasValue) {
      borderColor = const Color(0xFF0EA5A4).withValues(alpha: 0.3);
      bgColor = const Color(0xFF0EA5A4).withValues(alpha: 0.05);
    }
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 50,
      height: 56,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: borderColor,
          width: isActive || hasValue ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: isActive && !isError
            ? [
                BoxShadow(
                  color: const Color(0xFF0EA5A4).withValues(alpha: 0.15),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: hasValue
          ? Text(
              value,
              style: TextStyle(
                color: isError ? Colors.redAccent : const Color(0xFF0F172A),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            )
          : isActive
              ? const BlinkingCaret()
              : null,
    );
  }
}

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
        width: 2.5,
        height: 24,
        decoration: BoxDecoration(
          color: const Color(0xFF0EA5A4),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
