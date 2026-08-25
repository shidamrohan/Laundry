import 'dart:math';
import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/main_layout_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _bubble1Controller;
  late AnimationController _bubble2Controller;
  late AnimationController _bubble3Controller;
  late AnimationController _rowController;

  // Button state: 0 = idle, 1 = loading, 2 = success
  int _btnState = 0;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _bubble1Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _bubble2Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);

    _bubble3Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    _rowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _glowController.dispose();
    _bubble1Controller.dispose();
    _bubble2Controller.dispose();
    _bubble3Controller.dispose();
    _rowController.dispose();
    super.dispose();
  }

  void _handleEnable() async {
    setState(() => _btnState = 1);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) {
      setState(() => _btnState = 2);
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    final bottomPadding = mq.padding.bottom;
    final topPadding = mq.padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // --- ATMOSPHERIC GLOW ---
          Positioned(
            top: size.height * 0.15,
            left: size.width / 2 - size.width * 0.7,
            child: AnimatedBuilder(
              animation: _glowController,
              builder: (_, _) {
                final scale = 1.0 + _glowController.value * 0.1;
                final opacity = 0.04 + _glowController.value * 0.04;
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: size.width * 1.4,
                    height: size.width * 1.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF0EA5A4).withValues(alpha: opacity),
                    ),
                  ),
                );
              },
            ),
          ),

          // --- FLOATING BUBBLES ---
          _buildBubble(_bubble1Controller, size.width * 0.10, size.height * 0.15, 48),
          _buildBubble(_bubble2Controller, size.width * 0.88, size.height * 0.40, 32),
          _buildBubble(_bubble3Controller, size.width * 0.05, size.height * 0.72, 64),

          // --- MAIN CONTENT ---
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        24,
                        topPadding + 24,
                        24,
                        bottomPadding + 24,
                      ),
                      child: Column(
                        children: [
                          // --- ILLUSTRATION (flexible, shrinks on small screens) ---
                          Flexible(
                            flex: 5,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 260),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 180,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF0EA5A4).withValues(alpha: 0.15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF0EA5A4).withValues(alpha: 0.15),
                                          blurRadius: 60,
                                          spreadRadius: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                  Image.network(
                                    'https://lh3.googleusercontent.com/aida/AP1WRLuA1gChLBYvQbnsBosFn2uXGXf7CtU_5MfBYr9-ssb6u9hQtmzX222e7zcibFQVtS7iS1XeL4tZ9iscGRIj7Jsk0ZDKzMPuDD9j7dkQoNX9esmI8bbyb4x146ubxTPlxZpOYmkhIJyBH2Q0aqRjEnIx0S2bhFN4NcSleLEahIwYFlak0v7AmJnB1jB7O-jfaYA-m0LoCHLrvdWVeURW9EbGUKw5Zuby8sjtmEp869SHS7wreYfrao7BVfmm',
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, _, _) => const Icon(
                                      Icons.notifications_active,
                                      size: 100,
                                      color: Color(0xFF0EA5A4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // --- HEADLINE ---
                          const Text(
                            'Stay in the loop',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Turn on notifications so you never miss an update about your laundry.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 15,
                                height: 1.6,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // --- BENEFITS ---
                          _buildBenefitRow(Icons.schedule_outlined, 'Pickup reminders', 0),
                          const SizedBox(height: 20),
                          _buildBenefitRow(Icons.local_shipping_outlined, 'Real-time delivery updates', 1),
                          const SizedBox(height: 20),
                          _buildBenefitRow(Icons.notifications_active_outlined, 'Order status alerts', 2),
                          const SizedBox(height: 20),
                          _buildBenefitRow(Icons.redeem_outlined, 'Exclusive offers & confirmations', 3),

                          // Push buttons to bottom
                          const Spacer(),

                          const SizedBox(height: 32),

                          // --- ENABLE BUTTON ---
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _btnState == 0 ? _handleEnable : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _btnState == 2
                                    ? const Color(0xFF16A34A)
                                    : const Color(0xFF0EA5A4),
                                disabledBackgroundColor: _btnState == 2
                                    ? const Color(0xFF16A34A)
                                    : const Color(0xFF0EA5A4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 8,
                                shadowColor: const Color(0xFF0EA5A4).withValues(alpha: 0.3),
                              ),
                              child: _buildButtonContent(),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // --- SKIP ---
                          TextButton(
                            onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
                      (route) => false,
                    );
                  },
                            child: const Text(
                              'Skip for now',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButtonContent() {
    switch (_btnState) {
      case 1:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Enabling…',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      case 2:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle_outline, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              'Notifications Enabled',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
            SizedBox(width: 10),
            Text(
              'Enable notifications',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        );
    }
  }

  Widget _buildBenefitRow(IconData icon, String label, int index) {
    final delay = index * 0.15;
    return AnimatedBuilder(
      animation: _rowController,
      builder: (_, child) {
        final t = ((_rowController.value - delay) / (1.0 - delay)).clamp(0.0, 1.0);
        final progress = Curves.easeOut.transform(t);
        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - progress)),
            child: child,
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0EA5A4).withValues(alpha: 0.12),
              border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: const Color(0xFF0EA5A4), size: 20),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubble(AnimationController ctrl, double left, double top, double sz) {
    return AnimatedBuilder(
      animation: ctrl,
      builder: (_, _) {
        final dx = sin(ctrl.value * pi * 2) * 10.0;
        final dy = sin(ctrl.value * pi * 2 * 0.66) * (-20.0);
        return Positioned(
          left: left + dx,
          top: top + dy,
          child: Container(
            width: sz,
            height: sz,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.4, -0.4),
                colors: [
                  const Color(0xFF0EA5A4).withValues(alpha: 0.4),
                  Colors.transparent,
                ],
              ),
              border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.2)),
            ),
          ),
        );
      },
    );
  }
}
