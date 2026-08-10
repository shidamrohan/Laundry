import 'package:flutter/material.dart';
import 'terms_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          children: [
            // --- APPBAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
                    splashRadius: 24,
                  ),
                  const Text(
                    'Location Access',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 48), // Spacer to keep title centered
                ],
              ),
            ),
            
            // --- MAIN CONTENT ---
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    children: [
                      // --- ILLUSTRATION ---
                      SizedBox(
                        height: 260,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Atmospheric glow
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0EA5A4).withOpacity(0.15),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0EA5A4).withOpacity(0.2),
                                    blurRadius: 80,
                                    spreadRadius: 40,
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuDx_JWH_lf-t1NcKaePTIbGimMomPNY8BGlqEp456xH8T4TThh-5SXwK1-nBYOlUOUO8wioICFmICq323Gg1tMgZ_300GgN74VvkadA9JbVsJ2Q1tjS1DjoM9SVnK_j5rO4L4Mpn8zUfLGeffh50ku_PusMmCrMfvEVVquhYA9ry_ZR6Aa7iE0CEaFHbJLVLgyecegkQ4FzMjK6aIAsoAy6vAoj_wZ3r2j80_Pf8nVDxLkfPODekBGIfbaMj_-EcjMWFjntJWW7gkp0',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.location_on, size: 100, color: Colors.white24),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // --- HEADLINES ---
                      const Text(
                        'Enable location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Allow Orio to access your location for accurate pickup and delivery.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // --- BENEFITS LIST ---
                      _buildBenefitRow(Icons.speed, 'Faster pickup scheduling', "We'll find the nearest driver instantly"),
                      const SizedBox(height: 24),
                      _buildBenefitRow(Icons.location_on, 'Accurate address detection', "No more manual address typing"),
                      const SizedBox(height: 24),
                      _buildBenefitRow(Icons.local_shipping, 'Better delivery tracking', "Real-time updates on your laundry's journey"),
                      const SizedBox(height: 24),
                      _buildBenefitRow(Icons.local_offer, 'Improved service availability', "Exclusive deals in your specific area"),
                      
                      const SizedBox(height: 48),
                      
                      // --- ACTION BUTTONS ---
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TermsScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0EA5A4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 8,
                            shadowColor: const Color(0xFF0EA5A4).withOpacity(0.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.near_me, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Enable location',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TermsScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            'Not now',
                            style: TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // --- FOOTER ---
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Learn more about our privacy policy',
                          style: TextStyle(
                            color: Color(0xFF0EA5A4),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF0EA5A4),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF0EA5A4).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF0EA5A4), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
