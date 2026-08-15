import 'package:flutter/material.dart';

class WalletLockedScreen extends StatelessWidget {
  const WalletLockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7FAFB),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wallet Security',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                    child: Column(
                      children: [
                        const Spacer(),

                        // Premium Graphic Container
                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: const BoxDecoration(
                                  color: Color(0x1A0EA5A4), // primary/10
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image.network(
                                'https://lh3.googleusercontent.com/aida/AP1WRLtQ-aNnOFWPAA_nwp1rrzWU5GIdVxUGiNd16Fx9qp3hs6Io0tBR5-S1FTniXyWbLzT9_b8AGxcynE2o6PNGo6qjDimDYg8CqT5GstrCgnlQq6n0y3V_sSEZIFNWWDAvwHf1QBirO8KfBLTSprDCWASLDB4XBB5tEVFfVAQY6BiFMFq6w5Sf9Da3jTb6162WoYLG7PfD0eww8CD4pz46wNByitdYx88J9ZAei7lxO1wKN9oaxqL06YTlV7oy',
                                width: 128,
                                height: 128,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.lock, size: 64, color: Color(0xFF0EA5A4)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Typography Block
                        const Text(
                          'Wallet locked',
                          style: TextStyle(
                            color: Color(0xFF0F172A),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "For your security, your wallet is temporarily locked. Verify it's you to continue.",
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 15,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // Interactive Security Options Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildOptionButton(
                              icon: Icons.fingerprint,
                              label: 'Unlock with biometrics',
                              onTap: () {},
                            ),
                            const SizedBox(width: 12),
                            _buildOptionButton(
                              label: 'Enter wallet PIN',
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Primary CTA Area
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5A4),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 4,
                              shadowColor: const Color(0x330EA5A4),
                            ),
                            child: const Text('Unlock wallet', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF64748B),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            child: const Text('Use another method', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Forgot PIN?',
                            style: TextStyle(
                              color: Color(0xFF0EA5A4),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Spacer(),

                        // Footer Support Anchor
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.support_agent, color: Color(0xFF64748B), size: 16),
                              SizedBox(width: 8),
                              Text(
                                'Contact support',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildOptionButton({IconData? icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE2E8E9)),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: const Color(0xFF0EA5A4), size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
