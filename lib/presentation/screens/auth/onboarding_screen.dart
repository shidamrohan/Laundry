import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:laundry/presentation/screens/auth/login_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────

class _OnboardPage {
  const _OnboardPage({
    required this.icon,
    required this.secondaryIcon,
    required this.gradientColors,
    required this.title,
    required this.highlight,
    required this.subtitle,
    required this.pills,
  });

  final IconData icon;
  final IconData secondaryIcon;
  final List<Color> gradientColors;
  final String title;
  final String highlight; // colored word inside title
  final String subtitle;
  final List<_Pill> pills;
}

class _Pill {
  const _Pill(this.icon, this.label);
  final IconData icon;
  final String label;
}

const _pages = [
  _OnboardPage(
    icon: Icons.local_laundry_service,
    secondaryIcon: Icons.water_drop,
    gradientColors: [Color(0xFF0EA5A4), Color(0xFF0D8F8E)],
    title: 'Pickup & Delivery\nat Your',
    highlight: 'Doorstep',
    subtitle:
        'Schedule a pickup in seconds. We collect, clean, and deliver your clothes — same day or next day.',
    pills: [
      _Pill(Icons.access_time, 'Same-Day'),
      _Pill(Icons.local_shipping_outlined, 'Free Pickup'),
      _Pill(Icons.star_outline, '4.9 Rated'),
    ],
  ),
  _OnboardPage(
    icon: Icons.dry_cleaning,
    secondaryIcon: Icons.checkroom,
    gradientColors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
    title: 'Premium Care\nFor Every',
    highlight: 'Fabric',
    subtitle:
        'Silk, cotton, wool or denim — our specialists treat each garment with the exact care it needs.',
    pills: [
      _Pill(Icons.eco_outlined, 'Eco Solvents'),
      _Pill(Icons.shield_outlined, 'Fabric Safe'),
      _Pill(Icons.recycling, 'Zero Waste'),
    ],
  ),
  _OnboardPage(
    icon: Icons.track_changes,
    secondaryIcon: Icons.notifications_outlined,
    gradientColors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    title: 'Live Order\nTracking &',
    highlight: 'Updates',
    subtitle:
        'Know exactly where your laundry is. Get real-time notifications at every step of the process.',
    pills: [
      _Pill(Icons.gps_fixed, 'Live Tracking'),
      _Pill(Icons.message_outlined, 'SMS + Push'),
      _Pill(Icons.history, 'Order History'),
    ],
  ),
  _OnboardPage(
    icon: Icons.wallet,
    secondaryIcon: Icons.card_giftcard,
    gradientColors: [Color(0xFF16A34A), Color(0xFF15803D)],
    title: 'Rewards, Offers &\nEasy',
    highlight: 'Payments',
    subtitle:
        'Pay via UPI, cards, or VOSHIFY Wallet. Earn points on every order and unlock exclusive perks.',
    pills: [
      _Pill(Icons.currency_rupee, 'UPI & Cards'),
      _Pill(Icons.redeem, 'Earn Points'),
      _Pill(Icons.percent, 'Daily Offers'),
    ],
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
// MAIN SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Per-page content animation
  late AnimationController _contentController;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;

  // Button animation
  late AnimationController _btnController;
  late Animation<double> _btnScale;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _contentFade = CurvedAnimation(parent: _contentController, curve: Curves.easeOut)
        .drive(Tween(begin: 0.0, end: 1.0));
    _contentSlide = CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic)
        .drive(Tween(begin: const Offset(0, 0.12), end: Offset.zero));

    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _btnScale = _btnController.drive(Tween(begin: 1.0, end: 0.94));

    _contentController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _contentController.dispose();
    _btnController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
    _contentController.forward(from: 0);
  }

  void _goNext() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (c, a1, a2) => const LoginScreen(),
          transitionsBuilder: (c, animation, a2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic)),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 450),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final page = _pages[_currentPage];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── BACKGROUND HERO AREA ──
          _AnimatedBackground(
            gradientColors: page.gradientColors,
            height: size.height * 0.52,
          ),

          // ── PAGEVIEW ──
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (_, index) => _OnboardPageView(
              page: _pages[index],
              contentFade: _contentFade,
              contentSlide: _contentSlide,
              isCurrent: index == _currentPage,
            ),
          ),

          // ── TOP BAR: LOGO + SKIP ──
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  Row(
                    children: [
                      Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: page.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(Icons.local_laundry_service, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 8),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: page.gradientColors[0],
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                        child: const Text('VOSHIFY'),
                      ),
                    ],
                  ),

                  // Skip
                  if (_currentPage < _pages.length - 1)
                    TextButton(
                      onPressed: _navigateToLogin,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                        ),
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── BOTTOM NAVIGATION AREA ──
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0x120F172A), blurRadius: 20, offset: Offset(0, -4)),
                ],
              ),
              padding: EdgeInsets.fromLTRB(
                24, 20, 24,
                MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom + 12
                    : 28,
              ),
              child: Row(
                children: [
                  // Dot indicators
                  Expanded(
                    child: Row(
                      children: List.generate(_pages.length, (i) {
                        final isActive = i == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 6),
                          width: isActive ? 24 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isActive
                                ? _pages[_currentPage].gradientColors[0]
                                : const Color(0xFFE2E8E9),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // CTA button
                  GestureDetector(
                    onTapDown: (_) => _btnController.forward(),
                    onTapUp: (_) {
                      _btnController.reverse();
                      _goNext();
                    },
                    onTapCancel: () => _btnController.reverse(),
                    child: AnimatedBuilder(
                      animation: _btnScale,
                      builder: (_, child) => Transform.scale(
                        scale: _btnScale.value,
                        child: child,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: LinearGradient(
                            colors: page.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: page.gradientColors[0].withValues(alpha: 0.4),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
                                key: ValueKey(_currentPage < _pages.length - 1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                _currentPage < _pages.length - 1
                                    ? Icons.arrow_forward_rounded
                                    : Icons.rocket_launch_outlined,
                                color: Colors.white,
                                size: 20,
                                key: ValueKey(_currentPage < _pages.length - 1),
                              ),
                            ),
                          ],
                        ),
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

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATED BACKGROUND
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedBackground extends StatelessWidget {
  const _AnimatedBackground({
    required this.gradientColors,
    required this.height,
  });

  final List<Color> gradientColors;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0, left: 0, right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gradientColors[0],
              gradientColors[1],
              gradientColors[0].withValues(alpha: 0.7),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SINGLE PAGE VIEW
// ─────────────────────────────────────────────────────────────────────────────

class _OnboardPageView extends StatelessWidget {
  const _OnboardPageView({
    required this.page,
    required this.contentFade,
    required this.contentSlide,
    required this.isCurrent,
  });

  final _OnboardPage page;
  final Animation<double> contentFade;
  final Animation<Offset> contentSlide;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heroHeight = size.height * 0.52;
    final topPad = MediaQuery.of(context).padding.top;

    return Column(
      children: [
        // ── HERO ILLUSTRATION ──
        SizedBox(
          height: heroHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Decorative rings
              Positioned(
                top: topPad + 60,
                child: _DecorativeRings(color: Colors.white),
              ),

              // Central icon cluster
              Positioned(
                top: topPad + 64,
                child: _IconCluster(page: page),
              ),

              // Floating badges
              Positioned(
                bottom: 28,
                left: 24,
                right: 24,
                child: FadeTransition(
                  opacity: contentFade,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPill(page.pills[0]),
                          const SizedBox(width: 8),
                          _buildPill(page.pills[1]),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildPill(page.pills[2]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── TEXT CONTENT ──
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Bottom navigation bar is ~100px; use remaining space safely
              final bottomInset = MediaQuery.of(context).padding.bottom;
              final navBarHeight = 100.0 + (bottomInset > 0 ? bottomInset + 12 : 28);
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      28,
                      28,
                      28,
                      navBarHeight,
                    ),
                    child: SlideTransition(
                      position: contentSlide,
                      child: FadeTransition(
                        opacity: contentFade,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Title with highlighted word
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Color(0xFF0F172A),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                  letterSpacing: -0.5,
                                ),
                                children: [
                                  TextSpan(text: '${page.title}\n'),
                                  TextSpan(
                                    text: page.highlight,
                                    style: TextStyle(color: page.gradientColors[0]),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Subtitle
                            Text(
                              page.subtitle,
                              style: const TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 15,
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPill(_Pill pill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(pill.icon, color: Colors.white, size: 13),
          const SizedBox(width: 5),
          Text(
            pill.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DECORATIVE RINGS
// ─────────────────────────────────────────────────────────────────────────────

class _DecorativeRings extends StatelessWidget {
  const _DecorativeRings({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _ring(200, 0.06),
        _ring(154, 0.09),
        _ring(110, 0.14),
      ],
    );
  }

  Widget _ring(double d, double opacity) {
    return Container(
      width: d,
      height: d,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: opacity), width: 1.5),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ANIMATED ICON CLUSTER
// ─────────────────────────────────────────────────────────────────────────────

class _IconCluster extends StatefulWidget {
  const _IconCluster({required this.page});
  final _OnboardPage page;

  @override
  State<_IconCluster> createState() => _IconClusterState();
}

class _IconClusterState extends State<_IconCluster>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _bounce;
  late Animation<double> _orbit;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    _bounce = CurvedAnimation(parent: _c, curve: Curves.easeInOut)
        .drive(Tween(begin: 0.0, end: 1.0));
    _orbit = _c.drive(Tween(begin: 0.0, end: 2 * 3.14159));
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) {
        final dy = -8 + _bounce.value * 16;
        final orbitR = 52.0;
        final ox = orbitR * math.cos(_orbit.value - math.pi / 2);
        final oy = orbitR * math.sin(_orbit.value - math.pi / 2);

        return SizedBox(
          width: 200,
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Orbiting secondary icon
              Transform.translate(
                offset: Offset(ox, oy),
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                  ),
                  child: Icon(widget.page.secondaryIcon, color: Colors.white, size: 22),
                ),
              ),

              // Main icon with bounce
              Transform.translate(
                offset: Offset(0, dy),
                child: Container(
                  width: 96, height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(widget.page.icon, color: Colors.white, size: 48),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
