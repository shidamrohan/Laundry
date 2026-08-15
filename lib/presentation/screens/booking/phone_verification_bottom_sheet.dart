import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry/presentation/screens/booking/otp_verification_bottom_sheet.dart';

class PhoneVerificationBottomSheet extends StatefulWidget {
  const PhoneVerificationBottomSheet({super.key});

  /// Convenience method to show this bottom sheet
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x66000000),
      builder: (_) => const PhoneVerificationBottomSheet(),
    );
  }

  @override
  State<PhoneVerificationBottomSheet> createState() => _PhoneVerificationBottomSheetState();
}

class _PhoneVerificationBottomSheetState extends State<PhoneVerificationBottomSheet> {
  bool _isSending = false;

  Future<void> _sendCode() async {
    setState(() => _isSending = true);
    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() => _isSending = false);
      Navigator.pop(context);
      OtpVerificationBottomSheet.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -8))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag Handle ──
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8E9),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(height: 4),

          // ── Scrollable Content ──
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 56, height: 56,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF6F6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified_user, color: Color(0xFF0EA5A4), size: 30),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Verify your number',
                          style: TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Verify to secure your wallet\nand unlock instant refunds.',
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Benefits grid
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0x80EFF6F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: const [
                        _BenefitRow(icon: Icons.account_balance_wallet, label: 'Secure wallet'),
                        SizedBox(height: 12),
                        _BenefitRow(icon: Icons.currency_exchange, label: 'Instant refunds'),
                        SizedBox(height: 12),
                        _BenefitRow(icon: Icons.speed, label: 'Faster checkout'),
                        SizedBox(height: 12),
                        _BenefitRow(icon: Icons.loyalty, label: 'Cashback eligibility'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Phone display row
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6F6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE2E8E9)),
                    ),
                    child: Row(
                      children: [
                        const Text('🇮🇳', style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 10),
                        const Text('+91', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            '98765 43210',
                            style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600, fontSize: 15, letterSpacing: 0.5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text('Change', style: TextStyle(color: Color(0xFF0EA5A4), fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Privacy note
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.lock_outline, color: Color(0xFF64748B), size: 15),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "We'll send a one-time code via SMS. Standard rates may apply.",
                          style: TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: ElevatedButton(
                        onPressed: _isSending ? null : _sendCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0EA5A4),
                          disabledBackgroundColor: const Color(0xFF7AD4D3),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 4,
                          shadowColor: const Color(0x330EA5A4),
                        ),
                        child: _isSending
                            ? const SizedBox(
                                width: 20, height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                              )
                            : const Text('Send code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
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

// ─────────────────────── BENEFIT ROW ───────────────────────

class _BenefitRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BenefitRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0EA5A4), size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
