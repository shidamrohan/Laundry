import 'package:flutter/material.dart';
import 'package:laundry/core/services/location_service.dart';
import 'package:laundry/presentation/screens/booking/select_location_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context, topPadding),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  _buildHeroSection(),
                  const SizedBox(height: 32),
                  _buildTypographySection(),
                  const SizedBox(height: 32),
                  _buildBenefitsRow(),
                  const SizedBox(height: 40),
                  _buildActionButtons(),
                  const SizedBox(height: 32),
                  _buildFooterHint(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 8),
      height: topPadding + 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            splashRadius: 22,
          ),
          const Text('Location Access', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(width: 48), // Spacer to center title
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Simulated blurred map background
          Container(
            width: 240,
            height: 240,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDG29EVFogZ2XiBDmKjFAY6MjHQopZCMUL-Ri6CWoDNWGg3lTuYRejpCfMuNsW-PmM9ssUPFkakakNDvEI6ElPdU87dzoslcfTms_Bo-wyMD0vOcuXbJJ2btGXIDRF_AVqtH-zIqhbf3roATqL5qKBIGaqXRr6_ueKq5QbmPcfvdod5DyManUgCSR5lkh8kqCtBdLxYhQGDNL8c5stHRB4DyenRksQ114_sB439Z5-4vq9aqga3E4rh2P6Q6QmqvywCKW0DjHyCBbPD'),
                fit: BoxFit.cover,
              ),
              boxShadow: [BoxShadow(color: Colors.white.withValues(alpha: 0.6), spreadRadius: 10, blurRadius: 20)],
            ),
          ),
          // White overlay to make it subtle
          Container(width: 240, height: 240, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.7))),
          // Main Illustration (with simple implicit animation in a real app, here static for simplicity, or could use an AnimatedBuilder)
          Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCc7tBfv_5n8_-OOV_268Kwg4PHZ28Oyjp3L93WWuzBDf4ihNE1MzVj-lF1AdkreEwJpmIbOkSv-kCxpLluadfdn6wPM1CuK_hMJTzKknWVMGl40qmhBXE9kouClfIrUj5kFwNOfwH06r6OKDWT3nbhoOKyb08pMgAN7J0Ldq-lwHCvb164AevDm1ajE9T0ZM2DPGuBx3_YRvIyGxj27pJmf7z0e6oeLJ278hKcdCCQq4rPSSXHcY9jyu5rApVVRvTWmRXp804CwCII',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  Widget _buildTypographySection() {
    return Column(
      children: const [
        Text(
          'Turn on location',
          style: TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.bold, height: 1.2),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          'VOSHIFY needs your location to detect your address and show accurate pickup times.',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 15, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBenefitsRow() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 12,
      children: [
        _buildBenefitChip(Icons.verified, 'Precise pickup'),
        _buildBenefitChip(Icons.speed, 'Faster checkout'),
        _buildBenefitChip(Icons.location_on, 'Live tracking'),
      ],
    );
  }

  Widget _buildBenefitChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF0EA5A4), size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() => _isLoading = true);
                    try {
                      await LocationService.getCurrentPosition();
                      // Location granted and fetched. Go to SelectLocationScreen
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SelectLocationScreen()),
                        );
                      }
                    } catch (e) {
                      // Failed or denied, still let them go to manual select
                      if (mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SelectLocationScreen()),
                        );
                      }
                    } finally {
                      if (mounted) {
                        setState(() => _isLoading = false);
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5A4),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF0EA5A4).withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: _isLoading 
                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('Enable location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SelectLocationScreen()),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF0EA5A4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('Enter address manually', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterHint() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
        children: [
          TextSpan(text: 'Location services are off — turn them on in '),
          TextSpan(text: 'Settings', style: TextStyle(color: Color(0xFF0EA5A4), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
