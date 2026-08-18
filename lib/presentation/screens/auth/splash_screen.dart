import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:laundry/presentation/screens/auth/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _loadController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _loadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Navigate to WelcomeScreen after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const WelcomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _floatController.dispose();
    _loadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0B1220), Color(0xFF0F172A)],
              ),
            ),
          ),
          
          // Radial Glow
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0EA5A4).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                  radius: 0.7,
                ),
              ),
            ),
          ),

          // Floating Elements Background (Approximate)
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              final dy = math.sin(_floatController.value * 2 * math.pi) * 20;
              return Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.25 + dy,
                    left: -40,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0EA5A4).withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0EA5A4).withValues(alpha: 0.1),
                            blurRadius: 80,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.25 - dy,
                    right: -40,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withValues(alpha: 0.1),
                            blurRadius: 100,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15 + dy * 0.5,
                    left: MediaQuery.of(context).size.width * 0.2,
                    child: _buildBubble(32),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.6 - dy * 0.8,
                    right: MediaQuery.of(context).size.width * 0.15,
                    child: _buildBubble(48),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.2 + dy * 1.2,
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: _buildBubble(24),
                  ),
                ],
              );
            },
          ),
          
          // Custom Wave Pattern (approximate SVG)
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: WavePainter(_floatController),
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with Glow
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0EA5A4).withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          color: Colors.white,
                          size: 36,
                        ),
                        Icon(
                          Icons.local_laundry_service_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // App Name
                const Text(
                  'VOSHIFY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 12),
                // Subtitle
                const Text(
                  'Fresh laundry, delivered today.',
                  style: TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 64.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Loading Bar
                  Container(
                    width: 140,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: AnimatedBuilder(
                      animation: _loadController,
                      builder: (context, child) {
                        return Stack(
                          children: [
                            Positioned(
                              left: -140 + (_loadController.value * 280),
                              child: Container(
                                width: 140,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0EA5A4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Division Text
                  Text(
                    'PREMIUM CARE DIVISION',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.2),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
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

  Widget _buildBubble(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;

  WavePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF0EA5A4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final paint2 = Paint()
      ..color = const Color(0xFF0EA5A4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final path1 = Path();
    final path2 = Path();

    final yOffset1 = math.sin(animation.value * 2 * math.pi) * 10;
    final yOffset2 = math.cos(animation.value * 2 * math.pi) * 10;

    path1.moveTo(0, size.height * 0.4 + yOffset1);
    path1.quadraticBezierTo(
      size.width * 0.25, size.height * 0.3,
      size.width * 0.5, size.height * 0.4 + yOffset1,
    );
    path1.quadraticBezierTo(
      size.width * 0.75, size.height * 0.5,
      size.width, size.height * 0.4 + yOffset1,
    );

    path2.moveTo(0, size.height * 0.6 + yOffset2);
    path2.quadraticBezierTo(
      size.width * 0.3, size.height * 0.5,
      size.width * 0.6, size.height * 0.6 + yOffset2,
    );
    path2.quadraticBezierTo(
      size.width * 0.8, size.height * 0.7,
      size.width, size.height * 0.6 + yOffset2,
    );

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}
