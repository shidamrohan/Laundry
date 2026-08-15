import 'package:flutter/material.dart';

class WalletActivatedScreen extends StatefulWidget {
  const WalletActivatedScreen({super.key});

  @override
  State<WalletActivatedScreen> createState() => _WalletActivatedScreenState();
}

class _WalletActivatedScreenState extends State<WalletActivatedScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.elasticOut)),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward(from: 0.5);
      }
    });
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
        title: const Text('Activation Successful',
            style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.3)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 40, bottom: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAnimatedHero(),
                  const SizedBox(height: 32),
                  const Text(
                    'Your wallet is ready!',
                    style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Start earning rewards and pay faster on every order.',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 15, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildRewardCard(),
                ],
              ),
            ),
          ),
          
          // Fixed action buttons
          Positioned(
            bottom: 80,
            left: 24,
            right: 24,
            child: Column(
              children: [
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
                    child: const Text('Explore wallet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF0EA5A4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Go to home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),

          // Bottom nav mock
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildAnimatedHero() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulsing Ring
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF0EA5A4), width: 2),
                    ),
                  ),
                ),
              );
            },
          ),
          // Main Circle
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0EA5A4),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: const Color(0xFF0EA5A4).withValues(alpha: 0.4), blurRadius: 20, spreadRadius: 4)
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.check, color: Colors.white, size: 60),
                  ),
                ),
              );
            },
          ),
          // Confetti details could be added here as small positioned containers
        ],
      ),
    );
  }

  Widget _buildRewardCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5A4), Color(0xFF38BDF8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 16, offset: Offset(0, 4))],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative glow
          Positioned(
            top: -20, right: -20,
            child: Container(
              width: 100, height: 100,
              decoration: const BoxDecoration(
                color: Color(0x1AFFFFFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.card_giftcard, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text('Welcome reward added', style: TextStyle(color: Color(0xE6FFFFFF), fontSize: 14, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('CURRENT BALANCE', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                        SizedBox(height: 4),
                        Text('₹50.00', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -1)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 28),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 16, offset: Offset(0, -4))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home', false),
            _buildNavItem(Icons.local_laundry_service_outlined, Icons.local_laundry_service, 'Orders', false),
            _buildNavItem(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Wallet', true),
            _buildNavItem(Icons.person_outline, Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData outlinedIcon, IconData filledIcon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isActive
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(16)),
                child: Icon(filledIcon, color: const Color(0xFF0EA5A4), size: 24),
              )
            : Icon(outlinedIcon, color: const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
