import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7FAFB),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About',
          style: TextStyle(color: _primary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          _buildBrandHeader(),
          const SizedBox(height: 40),
          _buildLinksCard(),
          const SizedBox(height: 48),
          _buildSocialRow(),
          const SizedBox(height: 48),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
            image: const DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuA6ph_FbTS2kPhrAQkRmctPy8ubxX6_aOhKF8cBDPRS54xeWBWLo9btdwJ2KNJpDzW0qk-d7j12F3ALCB-HG1fpakgPQ-Q_Wpm8CkeyLllfzkH-_aLvhzENvNF3nCmyixb7wW4sCNjooLC5oEzo6KEwKzqz4HoHgmO3Wm6M7xnYGkRB3n6QdK44C6hBr83H9OBCBNQ0Xc8X3Q3YGNVuVSzz76x06VT7eAAF6GtwCF1mRF61enaMAINakWpuYzi-6lP_DO7geWaoJf4a',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'VOSHIFY',
          style: TextStyle(color: _textPrimary, fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: -1.0),
        ),
        const SizedBox(height: 4),
        const Text(
          'Version 2.4.0 (build 240)',
          style: TextStyle(color: _textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        const Text(
          'Fresh laundry, delivered today.',
          style: TextStyle(color: _primary, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildLinksCard() {
    final links = [
      (icon: Icons.description, label: 'Terms of service'),
      (icon: Icons.shield, label: 'Privacy policy'),
      (icon: Icons.payments, label: 'Refund policy'),
      (icon: Icons.gavel, label: 'Licenses'),
      (icon: Icons.code, label: 'Open-source acknowledgements'),
      (icon: Icons.star, label: 'Rate us on the App Store'),
      (icon: Icons.person_add, label: 'Follow us'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: links.asMap().entries.map((entry) {
          final isLast = entry.key == links.length - 1;
          final link = entry.value;

          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(link.icon, color: _primary, size: 24),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            link.label,
                            style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Icon(Icons.chevron_right, color: _textSecondary.withValues(alpha: 0.4), size: 24),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isLast) const Divider(color: _divider, height: 1, indent: 20, endIndent: 20),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSocialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton('assets/instagram.svg'),
        const SizedBox(width: 32),
        _buildSocialButton('assets/x.svg'),
        const SizedBox(width: 32),
        _buildSocialButton('assets/linkedin.svg'),
      ],
    );
  }

  Widget _buildSocialButton(String assetPlaceholder) {
    // We'll use a generic icon since we don't have SVGs in the assets folder
    // But keeping the structure ready for real SVGs
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: _surface,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.public, color: _textPrimary, size: 24),
    );
  }

  Widget _buildFooter() {
    return const Text(
      'Made with care in Bengaluru · © 2026 VOSHIFY Inc.',
      textAlign: TextAlign.center,
      style: TextStyle(color: _textSecondary, fontSize: 12, height: 1.5),
    );
  }
}
