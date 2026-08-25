import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'package:laundry/presentation/screens/auth/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Logo animation
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoGlow;

  // Text animation
  late AnimationController _textController;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;

  // Tagline animation
  late AnimationController _tagController;
  late Animation<double> _tagOpacity;

  // Background pulse
  late AnimationController _pulseController;

  // Shimmer sweep
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    // Force dark statusbar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = CurvedAnimation(parent: _logoController, curve: Curves.elasticOut)
        .drive(Tween(begin: 0.0, end: 1.0));
    _logoOpacity = CurvedAnimation(parent: _logoController, curve: const Interval(0, 0.4))
        .drive(Tween(begin: 0.0, end: 1.0));
    _logoGlow = _logoController.drive(Tween(begin: 0.0, end: 1.0));

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textOpacity = CurvedAnimation(parent: _textController, curve: Curves.easeOut)
        .drive(Tween(begin: 0.0, end: 1.0));
    _textSlide = CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic)
        .drive(Tween(begin: const Offset(0, 0.4), end: Offset.zero));

    _tagController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _tagOpacity = CurvedAnimation(parent: _tagController, curve: Curves.easeIn)
        .drive(Tween(begin: 0.0, end: 1.0));

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    // Staggered entrance
    _logoController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _textController.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) _tagController.forward();
    });

    // Navigate after 3s
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OnboardingScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _tagController.dispose();
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // ── ANIMATED BACKGROUND GRADIENT ──
          AnimatedBuilder(
            animation: _pulseController,
            builder: (_, __) {
              final pulse = _pulseController.value;
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, -0.2),
                    radius: 1.2 + pulse * 0.15,
                    colors: [
                      const Color(0xFF0EA5A4).withValues(alpha: 0.18 + pulse * 0.06),
                      const Color(0xFFF7FAFB),
                      const Color(0xFFF7FAFB),
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              );
            },
          ),

          // ── FLOATING PARTICLES ──
          ...List.generate(8, (i) => _FloatingParticle(index: i, size: size)),

          // ── ANIMATED WAVE (background) ──
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _pulseController,
              builder: (_, __) => CustomPaint(
                painter: _SplashWavePainter(_pulseController.value),
              ),
            ),
          ),

          // ── CENTER CONTENT ──
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo glow ring
                AnimatedBuilder(
                  animation: Listenable.merge([_logoController, _pulseController]),
                  builder: (_, __) {
                    return Transform.scale(
                      scale: _logoScale.value,
                      child: Opacity(
                        opacity: _logoOpacity.value.clamp(0.0, 1.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer glow
                            Container(
                              width: 140 + _pulseController.value * 12,
                              height: 140 + _pulseController.value * 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    const Color(0xFF0EA5A4).withValues(
                                        alpha: 0.15 + _pulseController.value * 0.05),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            // Inner ring
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF0EA5A4)
                                      .withValues(alpha: 0.25 + _pulseController.value * 0.1),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            // Logo container
                            Container(
                              width: 96,
                              height: 96,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF0EA5A4), Color(0xFF0D8F8E), Color(0xFF1A6FD8)],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0EA5A4)
                                        .withValues(alpha: 0.35 + _pulseController.value * 0.15),
                                    blurRadius: 32,
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF2563EB).withValues(alpha: 0.2),
                                    blurRadius: 48,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Stack(
                                  children: [
                                    // Shimmer overlay
                                    AnimatedBuilder(
                                      animation: _shimmerController,
                                      builder: (_, __) {
                                        return Transform.translate(
                                          offset: Offset(
                                            -96 + _shimmerController.value * 192,
                                            -96 + _shimmerController.value * 192,
                                          ),
                                          child: Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white.withValues(alpha: 0),
                                                  Colors.white.withValues(alpha: 0.2),
                                                  Colors.white.withValues(alpha: 0),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // Icon stack
                                    const Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.water_drop, color: Colors.white, size: 30),
                                          Icon(Icons.local_laundry_service_outlined,
                                              color: Colors.white, size: 24),
                                        ],
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
                  },
                ),

                const SizedBox(height: 36),

                // App name
                SlideTransition(
                  position: _textSlide,
                  child: FadeTransition(
                    opacity: _textOpacity,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF0EA5A4)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'VOSHIFY',
                        style: TextStyle(
                          color: Colors.white, // Color is controlled by ShaderMask
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 6,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Tagline
                FadeTransition(
                  opacity: _tagOpacity,
                  child: const Text(
                    'Fresh laundry, delivered today.',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 15,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── BOTTOM LOADER ──
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _tagOpacity,
              child: Column(
                children: [
                  // Animated dots loader
                  _DotsLoader(),
                  const SizedBox(height: 24),
                  Text(
                    'PREMIUM CARE DIVISION',
                    style: TextStyle(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.3),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
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
// DOTS LOADER (Swiggy-style)
// ─────────────────────────────────────────────────────────────────────────────

class _DotsLoader extends StatefulWidget {
  @override
  State<_DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<_DotsLoader> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) {
      final c = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
      Future.delayed(Duration(milliseconds: i * 160), () {
        if (mounted) c.repeat(reverse: true);
      });
      return c;
    });
    _anims = _controllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeInOut)
            .drive(Tween(begin: 0.0, end: 1.0)))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _anims[i],
          builder: (_, __) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.lerp(
                  const Color(0xFF1E3A5F),
                  const Color(0xFF0EA5A4),
                  _anims[i].value,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FLOATING PARTICLE
// ─────────────────────────────────────────────────────────────────────────────

class _FloatingParticle extends StatefulWidget {
  const _FloatingParticle({required this.index, required this.size});
  final int index;
  final Size size;

  @override
  State<_FloatingParticle> createState() => _FloatingParticleState();
}

class _FloatingParticleState extends State<_FloatingParticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late double x, y, radius;

  @override
  void initState() {
    super.initState();
    final rng = math.Random(widget.index * 13 + 7);
    x = rng.nextDouble();
    y = rng.nextDouble();
    radius = 4 + rng.nextDouble() * 8;

    _c = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000 + (rng.nextInt(2000))),
    )..repeat(reverse: true);
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
        return Positioned(
          left: x * widget.size.width,
          top: y * widget.size.height + _c.value * 20 - 10,
          child: Opacity(
            opacity: 0.06 + _c.value * 0.08,
            child: Container(
              width: radius * 2,
              height: radius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.index.isEven
                    ? const Color(0xFF0EA5A4)
                    : const Color(0xFF2563EB),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WAVE PAINTER
// ─────────────────────────────────────────────────────────────────────────────

class _SplashWavePainter extends CustomPainter {
  final double t;
  _SplashWavePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0EA5A4).withValues(alpha: 0.04)
      ..style = PaintingStyle.fill;

    void drawWave(double yFactor, double amplitude, double phase) {
      final path = Path();
      path.moveTo(0, size.height * yFactor);
      for (double x = 0; x <= size.width; x += 1) {
        final y = size.height * yFactor +
            amplitude * math.sin((x / size.width * 2 * math.pi) + phase + t * 2 * math.pi);
        path.lineTo(x, y);
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      canvas.drawPath(path, paint);
    }

    drawWave(0.78, 18, 0);
    drawWave(0.83, 14, math.pi * 0.6);
    drawWave(0.88, 10, math.pi * 1.2);
  }

  @override
  bool shouldRepaint(_SplashWavePainter old) => true;
}
