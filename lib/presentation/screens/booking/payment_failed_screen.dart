import 'dart:async';
import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/payment_screen.dart';
import 'package:laundry/presentation/screens/home/home_screen.dart';

class PaymentFailedScreen extends StatefulWidget {
  const PaymentFailedScreen({super.key});

  @override
  State<PaymentFailedScreen> createState() => _PaymentFailedScreenState();
}

class _PaymentFailedScreenState extends State<PaymentFailedScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  int _secondsLeft = 14 * 60 + 52; // 14:52

  late AnimationController _pingController;

  @override
  void initState() {
    super.initState();

    // Ping animation on the hero circle
    _pingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Countdown timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pingController.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = _secondsLeft ~/ 60;
    final seconds = _secondsLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get _isExpired => _secondsLeft <= 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: const [
              Icon(Icons.bubble_chart, color: Color(0xFF0EA5A4), size: 24),
              SizedBox(width: 6),
              Text('VOSHIFY', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFF64748B)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE2E8E9)),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHero(),
              const SizedBox(height: 32),
              _buildHeadline(),
              const SizedBox(height: 40),
              _buildInfoCard(),
              const SizedBox(height: 24),
              _buildCountdownRow(),
              const SizedBox(height: 40),
              _buildActions(context),
              const SizedBox(height: 48),
              _buildSupportFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Center(
      child: SizedBox(
        width: 140,
        height: 140,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ping animation ring
            AnimatedBuilder(
              animation: _pingController,
              builder: (context, child) {
                return Opacity(
                  opacity: (1 - _pingController.value) * 0.25,
                  child: Transform.scale(
                    scale: 1 + _pingController.value * 0.5,
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFDC2626),
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            // Hero image
            ClipOval(
              child: SizedBox(
                width: 128,
                height: 128,
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBzJLL2usxCZX7OpQ6X_rmwsZFvZ52q5ID7gY6rnFVjXqsMHeyBjNtnjQYCpxBMdTPJxIp6UuwUxN_-D2M2827QSMVabq17HxcmuTEPm9GTfK-GFP2r99xKKlXdzWZJX5zHTSSROq2AGvc5_B75YVeEjPJU8jDeoRMiIdros8jrTXbafYlK0Mo3z1-rF2isv8NBEvDmQocqRjjueM-lK84ulaP6h5svqOdGDx68zn_xCF2WlQF0I4I3OGe_DMIwOjlKwXtnlZ5Tjfvw',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, _) => Container(
                    width: 128,
                    height: 128,
                    color: const Color(0xFFFEE2E2),
                    child: const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 64),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadline() {
    return Column(
      children: const [
        Text(
          'Payment failed',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          "Your payment couldn't be processed. Don't worry — you haven't been charged.",
          style: TextStyle(fontSize: 15, color: Color(0xFF64748B), height: 1.6),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.account_balance_wallet, color: Color(0xFF2563EB), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('UPI · Google Pay', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
                    SizedBox(height: 3),
                    Text('Primary Payment Method', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 20),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFE2E8E9), height: 1),
          const SizedBox(height: 12),
          const Text(
            'Reason: Bank declined the transaction',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownRow() {
    final timerColor = _isExpired ? const Color(0xFFDC2626) : const Color(0xFFF59E0B);
    final timerBg = _isExpired ? const Color(0x1ADC2626) : const Color(0x1AF59E0B);
    final timerBorder = _isExpired ? const Color(0x33DC2626) : const Color(0x33F59E0B);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Your order is saved for',
          style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: timerBg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: timerBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timer, color: timerColor, size: 16),
              const SizedBox(width: 6),
              Text(
                _isExpired ? '00:00' : _formattedTime,
                style: TextStyle(
                  color: timerColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PaymentScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0EA5A4),
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: const Color(0x330EA5A4),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            minimumSize: const Size(double.infinity, 56),
          ),
          child: const Text('Retry payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PaymentScreen()),
            );
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF64748B),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: const Text('Choose another method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildSupportFooter() {
    return GestureDetector(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.headset_mic, color: Color(0xFF0EA5A4), size: 18),
          SizedBox(width: 8),
          Text(
            'Contact support',
            style: TextStyle(
              color: Color(0xFF0EA5A4),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF0EA5A4),
            ),
          ),
        ],
      ),
    );
  }
}
