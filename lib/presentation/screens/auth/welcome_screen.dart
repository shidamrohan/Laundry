import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/auth/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heroHeight = MediaQuery.of(context).size.height * 0.50;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          // --- STATIC HERO BACKGROUND ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: heroHeight,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFEFF6F6), Color(0xFFFFFFFF)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
            ),
          ),

          // --- STATIC LOGO ---
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_laundry_service,
                      color: Color(0xFF0EA5A4),
                      size: 28,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'VOSHIFY',
                      style: TextStyle(
                        color: Color(0xFF0EA5A4),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- STATIC CHIP ---
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 64.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0EA5A4).withValues(alpha: 0.1),
                    border: Border.all(
                      color: const Color(0xFF0EA5A4).withValues(alpha: 0.2),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0EA5A4),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'SAME-DAY SERVICE',
                        style: TextStyle(
                          color: Color(0xFF0EA5A4),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- SWIPEABLE CONTENT (PAGEVIEW) ---
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                _buildPageContent(
                  heroHeight: heroHeight,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCDaHZBZ1UcnKs6fH1NqwyzuNuhm2gQ7YQBeCNxLQaHlZfJwSSYu2jxeajZ6wTFFhaRfb1eeVVXDZLP1N_IHgyMColoDAbDtusEW0oUSVJhQsCs1dbua0U6Tb7Byrj1kAnRqo9CbmVcpDBoUzfz3SbYiUrrxWXlbI7pe1oxlwLf5Vek7j5_uxvctYlmQDSzdvNYrDa39YHxi3MzuP9wHo6nF5RFQKnC3w0RfTzbSykkjf_5RNDijukqpknHow-KOF97kz0YUw9OFySH',
                  headline: 'Fresh Laundry.\nDelivered Today.',
                  subtext:
                      'Professional laundry, dry cleaning, and ironing services—picked up and delivered at your convenience.',
                  badges: [
                    Expanded(
                      child: _buildTrustBadge(
                        Icons.local_shipping,
                        'Pickup &\nDelivery',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTrustBadge(
                        Icons.schedule,
                        '24h\nTurnaround',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTrustBadge(Icons.verified, 'Premium\nCare'),
                    ),
                  ],
                ),
                _buildPageContent(
                  heroHeight: heroHeight,
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/3003/3003984.png',
                  headline: 'Eco-Friendly\nCleaning.',
                  subtext:
                      'We use gentle, environmentally safe solvents that keep your clothes vibrant and perfectly soft.',
                  badges: [
                    Expanded(
                      child: _buildTrustBadge(Icons.eco, 'Organic\nSolvents'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTrustBadge(Icons.water_drop, 'Zero\nWaste'),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildTrustBadge(Icons.favorite, 'Fabric\nSafe'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- STATIC BOTTOM ACTION BUTTON ---
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                24,
                0,
                24,
                MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom + 12
                    : 24,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage == 0) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0EA5A4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 4,
                    shadowColor: const Color(0xFF0EA5A4).withValues(alpha: 0.5),
                  ),
                  child: Text(
                    _currentPage == 0 ? 'Next' : 'Get Started',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent({
    required double heroHeight,
    required String imageUrl,
    required String headline,
    required String subtext,
    required List<Widget> badges,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- IMAGE (In Hero Area) ---
                  SizedBox(
                    height: heroHeight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 140,
                        left: 32,
                        right: 32,
                        bottom: 32,
                      ),
                      child: Center(
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.image,
                                size: 100,
                                color: Colors.black12,
                              ),
                        ),
                      ),
                    ),
                  ),

                  // --- BOTTOM CONTENT ---
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dashes (Progress Indicators)
                          Row(
                            children: [
                              _buildDashIndicator(active: _currentPage == 0),
                              const SizedBox(width: 6),
                              _buildDashIndicator(active: _currentPage == 1),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Text
                          Text(
                            headline,
                            style: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            subtext,
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Badges Grid
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: badges,
                          ),

                          // Spacer to avoid covering content with the static button block
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrustBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6).withValues(alpha: 0.5),
        border: Border.all(color: const Color(0xFFE2E8E9).withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF0EA5A4), size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashIndicator({required bool active}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: active ? 24 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
