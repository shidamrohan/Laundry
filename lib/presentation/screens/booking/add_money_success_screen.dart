import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';

class AddMoneySuccessScreen extends StatefulWidget {
  const AddMoneySuccessScreen({super.key});

  @override
  State<AddMoneySuccessScreen> createState() => _AddMoneySuccessScreenState();
}

class _AddMoneySuccessScreenState extends State<AddMoneySuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.elasticOut)),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF0EA5A4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Success',
            style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.3)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            // Success Icon Section
            _buildAnimatedIcon(),
            const SizedBox(height: 32),

            // Success Message
            const Text(
              '₹500.00 added to wallet',
              style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your money is ready to use.',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 15),
            ),
            const SizedBox(height: 40),

            // Balance Card
            _buildBalanceCard(),
            const SizedBox(height: 32),

            // Details Card
            _buildDetailsCard(),
            const SizedBox(height: 40),

            // Actions
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                icon: const Icon(Icons.download, color: Color(0xFF0EA5A4), size: 20),
                label: const Text('Download receipt', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 16, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFEFF6F6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 4,
                  shadowColor: const Color(0x330EA5A4),
                ),
                child: const Text('Done', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _glowAnimation.value * 0.2,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0EA5A4),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          // Main Icon Circle
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0EA5A4),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: const [BoxShadow(color: Color(0x330EA5A4), blurRadius: 20, spreadRadius: 4)],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida/AP1WRLvQcq1OhCkwGLky0isymyJO99qQIDwql4IkMxFcP3H10x8NZs0RxXH0ubfM7O3PngTJff-E_dxb3MPuX2cTseCqBeCIk551XA_fknv4USiyUNvAqdJ66An7DfRkttC7ilJfXxl8W63fyLaV-KORxqFzdrw9pgNxSV2f9H3zQhdtvMNHr-KL-bPfYMN4EV6xRf5ky5V_znDBaM0B2n9pbZVUxWElgiMwxs6b2Y5FVD1KRfc6J5kvBBGrjW5O',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.check, color: Colors.white, size: 40),
                    ),
                  ),
                ),
              );
            },
          ),
          // Decorative Sparkles
          Positioned(
            top: 10, right: 10,
            child: const Icon(Icons.star, color: Color(0xFF7C3AED), size: 16),
          ),
          Positioned(
            bottom: 20, left: 10,
            child: const Icon(Icons.blur_on, color: Color(0x990EA5A4), size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5A4), Color(0xFF38BDF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
      ),
      child: Column(
        children: [
          const Text('NEW WALLET BALANCE', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          const SizedBox(height: 12),
          const Text('₹1,750.00', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -1)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xE6FFFFFF),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0x33FFFFFF)),
            ),
            child: const Text('🎉 +₹50 cashback credited', style: TextStyle(color: Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TRANSACTION DETAILS', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 20),
          _buildDetailRow('Transaction ID', 'TXNADD8821', isMono: true),
          const SizedBox(height: 16),
          _buildDetailRow('Paid via', 'Google Pay UPI'),
          const SizedBox(height: 16),
          _buildDetailRow('Date & Time', 'Jul 19, 2026 · 2:48 PM'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isMono = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF0F172A),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: isMono ? 'monospace' : null,
          ),
        ),
      ],
    );
  }
}
