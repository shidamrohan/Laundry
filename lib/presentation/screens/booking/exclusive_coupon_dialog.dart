import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExclusiveCouponDialog extends StatefulWidget {
  const ExclusiveCouponDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: const Color(0x660F172A), // backdrop-blur equivalent
      builder: (context) => const ExclusiveCouponDialog(),
    );
  }

  @override
  State<ExclusiveCouponDialog> createState() => _ExclusiveCouponDialogState();
}

class _ExclusiveCouponDialogState extends State<ExclusiveCouponDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isCopied = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.reverse().then((_) => Navigator.pop(context));
  }

  void _copyCode() {
    Clipboard.setData(const ClipboardData(text: 'GETOFF80ON149'));
    setState(() => _isCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isCopied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Floating Close Button
            GestureDetector(
              onTap: _close,
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
                ),
                child: const Icon(Icons.close, color: Color(0xFF0F172A)),
              ),
            ),
            const SizedBox(height: 24),

            // Popup Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [BoxShadow(color: Color(0x1F0F172A), blurRadius: 40, offset: Offset(0, 20))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Large Badge
                  SizedBox(
                    width: 192,
                    height: 192,
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA5OrrFeJnFYE3nOFo23-sNqgj67PrPEYrtf3fo577UC0LhyO5zIcQSt7NUEDDHZVIWwUMGGxLK7AGVZl7wt2EXru5PqGAURfK9A0NtgKRUPLX2KwO6UOLwGC1mbI6Ou56CUrRIcyAEEq0ytTLqkQx7gdIIzZ_DYeobD5PVQK9WIMC6sdVcixyyCkL93Yf1ZZ5KRCkswAnmGJyQt7Pl8gkOjDTivUqRUA3QTAFMgnlmku9sfCnl-ocbKBXmv_s0jUlr1YYS47MnSf5I',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.local_offer, size: 80, color: Color(0xFF0EA5A4)),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Small Heading
                  const Text(
                    '✦ EXCLUSIVELY FOR YOU ✦',
                    style: TextStyle(
                      color: Color(0xFF0EA5A4),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Main Heading
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(fontFamily: 'Plus Jakarta Sans', color: Color(0xFF0F172A), fontSize: 28, fontWeight: FontWeight.bold, height: 1.1),
                      children: [
                        TextSpan(text: 'Save '),
                        TextSpan(text: '₹80', style: TextStyle(color: Color(0xFF0EA5A4))),
                        TextSpan(text: ' on this order'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Subtitle & Coupon Code
                  const Text('with coupon', style: TextStyle(color: Color(0xFF64748B), fontSize: 16)),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _copyCode,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0x80EFF6F6),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0x660EA5A4),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'GETOFF80ON149',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            _isCopied ? Icons.check : Icons.content_copy,
                            color: _isCopied ? const Color(0xFF16A34A) : const Color(0xFF0EA5A4),
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Instruction
                  const Text('Tap on APPLY to avail this', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                  const SizedBox(height: 16),

                  // Primary Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0EA5A4),
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: const Color(0x330EA5A4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('APPLY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
