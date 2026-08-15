import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otp_verification_bottom_sheet.dart';

class ChangePhoneNumberBottomSheet extends StatefulWidget {
  final String currentNumber;

  const ChangePhoneNumberBottomSheet({
    super.key,
    this.currentNumber = '+91 98765 43210',
  });

  static Future<void> show(BuildContext context, {String currentNumber = '+91 98765 43210'}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x66000000), // 40% black scrim
      builder: (_) => ChangePhoneNumberBottomSheet(currentNumber: currentNumber),
    );
  }

  @override
  State<ChangePhoneNumberBottomSheet> createState() => _ChangePhoneNumberBottomSheetState();
}

class _ChangePhoneNumberBottomSheetState extends State<ChangePhoneNumberBottomSheet> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isValid = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      final text = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
      setState(() => _isValid = text.length == 10);
    });

    // Auto-focus keyboard
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _focusNode.requestFocus();
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_isValid) return;

    setState(() => _isSubmitting = true);
    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    Navigator.pop(context);
    final newNumber = '+91 ${_phoneController.text.trim()}';
    OtpVerificationBottomSheet.show(context, phoneNumber: newNumber);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        margin: EdgeInsets.only(bottom: bottomInset),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -8))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            const SizedBox(height: 12),
            Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8E9),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            const SizedBox(height: 6),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Change linked number',
                    style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32, height: 32,
                      decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
                      child: const Icon(Icons.close, color: Color(0xFF64748B), size: 20),
                    ),
                  ),
                ],
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Number Row
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.verified_user, color: Color(0xFF0EA5A4), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Current: ${widget.currentNumber}',
                              style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0x1A16A34A),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('VERIFIED',
                                style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Input Section
                    const Padding(
                      padding: EdgeInsets.only(left: 4, bottom: 8),
                      child: Text('New number', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6F6),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: _focusNode.hasFocus ? const Color(0xFF0EA5A4) : Colors.transparent),
                      ),
                      child: Row(
                        children: [
                          // Country selector mock
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xFFE2E8E9))),
                              ),
                              child: Row(
                                children: const [
                                  Text('🇮🇳', style: TextStyle(fontSize: 20)),
                                  SizedBox(width: 6),
                                  Text('+91', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 15)),
                                  SizedBox(width: 4),
                                  Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B), size: 14),
                                ],
                              ),
                            ),
                          ),
                          // Phone Input
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              focusNode: _focusNode,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.w600),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter new number',
                                hintStyle: TextStyle(color: Color(0x8064748B), fontWeight: FontWeight.normal),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                            ),
                          ),
                          // Valid check icon
                          AnimatedOpacity(
                            opacity: _isValid ? 1.0 : 0.3,
                            duration: const Duration(milliseconds: 200),
                            child: AnimatedScale(
                              scale: _isValid ? 1.0 : 0.9,
                              duration: const Duration(milliseconds: 200),
                              child: const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "We'll send a code to verify your new number. Standard carrier rates may apply.",
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.5),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Security Badge
                    Center(
                      child: Opacity(
                        opacity: 0.6,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.lock, size: 14),
                            SizedBox(width: 8),
                            Text('SECURE VERIFICATION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Actions
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (_isValid && !_isSubmitting) ? _submit : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0EA5A4),
                          disabledBackgroundColor: const Color(0xFF7AD4D3),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 4,
                          shadowColor: const Color(0x330EA5A4),
                        ),
                        child: _isSubmitting
                            ? const SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, size: 18),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF64748B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
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
