import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationBottomSheet extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationBottomSheet({
    super.key,
    this.phoneNumber = '+91 98765 43210',
  });

  static Future<void> show(BuildContext context, {String phoneNumber = '+91 98765 43210'}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x66000000),
      builder: (_) => OtpVerificationBottomSheet(phoneNumber: phoneNumber),
    );
  }

  @override
  State<OtpVerificationBottomSheet> createState() => _OtpVerificationBottomSheetState();
}

class _OtpVerificationBottomSheetState extends State<OtpVerificationBottomSheet>
    with TickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late AnimationController _cursorController;
  late Animation<double> _cursorOpacity;

  Timer? _resendTimer;
  int _secondsLeft = 24;
  bool _canResend = false;
  bool _isVerifying = false;

  static const int _otpLength = 6;

  @override
  void initState() {
    super.initState();

    // Blinking cursor animation
    _cursorController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
      ..repeat(reverse: true);
    _cursorOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(_cursorController);

    _startResendTimer();

    _otpController.addListener(() => setState(() {}));

    // Auto-focus keyboard
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _focusNode.requestFocus();
      });
    });
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() {
      _secondsLeft = 24;
      _canResend = false;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _canResend = true;
          t.cancel();
        }
      });
    });
  }

  Future<void> _verify() async {
    if (_otpController.text.length < _otpLength) return;
    HapticFeedback.mediumImpact();
    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    setState(() => _isVerifying = false);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF16A34A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Row(
          children: [
            Icon(Icons.verified_user, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Phone verified successfully!',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text ?? '';
    final digits = text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isNotEmpty) {
      _otpController.text = digits.length > _otpLength ? digits.substring(0, _otpLength) : digits;
      _otpController.selection = TextSelection.collapsed(offset: _otpController.text.length);
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    _cursorController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final otpText = _otpController.text;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        margin: EdgeInsets.only(bottom: bottomInset),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 40, offset: Offset(0, -8))],
        ),
        child: Stack(
          children: [
            // Hidden text field for keyboard input
            Positioned(
              left: -400, top: 0,
              child: SizedBox(
                width: 1, height: 1,
                child: TextField(
                  controller: _otpController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  maxLength: _otpLength,
                  showCursor: false,
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(counterText: ''),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                const SizedBox(height: 12),
                Container(
                  width: 48, height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8E9),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 6),

                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
                    child: Column(
                      children: [
                        // Security icon
                        Container(
                          width: 48, height: 48,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF6F6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.security, color: Color(0xFF0EA5A4), size: 26),
                        ),
                        const SizedBox(height: 16),

                        // Title
                        const Text('Enter verification code',
                            style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 8),

                        // Subtitle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Sent to ${widget.phoneNumber}',
                                style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Text('Change',
                                  style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // OTP boxes
                        GestureDetector(
                          onTap: () => _focusNode.requestFocus(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_otpLength, (i) => _buildOtpCell(i, otpText)),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Auto-detecting chip
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6F6),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0x80E2E8E9)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 14, height: 14,
                                child: CircularProgressIndicator(
                                  color: const Color(0xFF0EA5A4),
                                  strokeWidth: 2,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('Auto-detecting code…',
                                  style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Paste button
                        GestureDetector(
                          onTap: _pasteFromClipboard,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.content_paste, color: Color(0xFF2563EB), size: 18),
                              SizedBox(width: 6),
                              Text('Paste from clipboard',
                                  style: TextStyle(color: Color(0xFF2563EB), fontSize: 14, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Resend row
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Color(0x66E2E8E9)),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!_canResend)
                                    Text(
                                      'Resend code in ${_secondsLeft.toString().padLeft(2, '0')}s',
                                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
                                    ),
                                  GestureDetector(
                                    onTap: _canResend ? _startResendTimer : null,
                                    child: Text(
                                      'Resend',
                                      style: TextStyle(
                                        color: _canResend ? const Color(0xFF0EA5A4) : const Color(0xFFCBD5E1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                                child: Row(
                                  children: const [
                                    Icon(Icons.call, color: Color(0xFF0EA5A4), size: 18),
                                    SizedBox(width: 6),
                                    Text('Call me instead',
                                        style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Wrong number
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text('Wrong number?',
                              style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 24),

                        // Verify CTA
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (!_isVerifying && otpText.length == _otpLength) ? _verify : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5A4),
                              disabledBackgroundColor: const Color(0xFFB2E0E0),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 4,
                              shadowColor: const Color(0x330EA5A4),
                            ),
                            child: _isVerifying
                                ? const SizedBox(
                                    width: 20, height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                                  )
                                : const Text('Verify', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpCell(int index, String otpText) {
    final hasValue = index < otpText.length;
    final isActive = index == otpText.length && index < _otpLength;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        width: 52,
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive ? const Color(0xFF0EA5A4) : Colors.transparent,
            width: isActive ? 2.0 : 1.0,
          ),
          boxShadow: isActive
              ? [const BoxShadow(color: Color(0x1A0EA5A4), blurRadius: 12, spreadRadius: 2)]
              : [],
        ),
        child: Center(
          child: hasValue
              ? Text(
                  otpText[index],
                  style: const TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.bold),
                )
              : isActive
                  ? FadeTransition(
                      opacity: _cursorOpacity,
                      child: Container(
                        width: 2,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0EA5A4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
