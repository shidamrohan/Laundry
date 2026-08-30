import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/phone_verification_bottom_sheet.dart';
import 'package:laundry/presentation/screens/booking/change_phone_number_bottom_sheet.dart';

class WalletSettingsScreen extends StatelessWidget {
  const WalletSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Wallet settings', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.3)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF0EA5A4)),
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE2E8E9)),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
            children: [
              _buildStatusCard(),
              const SizedBox(height: 24),
              _buildSection('Account & Security', [
                _buildSettingsItem(
                  icon: Icons.phone_android,
                  label: 'Change phone number',
                  subtitle: 'Update your linked mobile',
                  onTap: () => ChangePhoneNumberBottomSheet.show(context),
                ),
                _buildSettingsItem(
                  icon: Icons.verified_user,
                  label: 'Verify mobile',
                  subtitle: 'Ensure account ownership',
                  onTap: () => PhoneVerificationBottomSheet.show(context),
                ),
                _buildSettingsItem(
                  icon: Icons.fingerprint,
                  label: 'Wallet security',
                  subtitle: 'PIN & biometrics for extra safety',
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Support & Legals', [
                _buildSettingsItem(
                  icon: Icons.help,
                  label: 'FAQs',
                  subtitle: 'Learn how VOSHIFY Wallet works',
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                ),
                _buildSettingsItem(
                  icon: Icons.policy,
                  label: 'Privacy policy',
                  subtitle: 'How we protect your data',
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                ),
                _buildSettingsItem(
                  icon: Icons.gavel,
                  label: 'Terms of use',
                  subtitle: 'Legal guidelines',
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                ),
                _buildSettingsItem(
                  icon: Icons.support_agent,
                  label: 'Contact support',
                  subtitle: 'Get help from our team',
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Transactions', [
                _buildSettingsItem(
                  icon: Icons.report_problem,
                  label: 'Raise an issue',
                  subtitle: 'Report transaction problems',
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                ),
                _buildSettingsItem(
                  icon: Icons.ios_share,
                  label: 'Export transactions',
                  subtitle: 'Download history as PDF/CSV',
                  onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
                ),
              ]),
              const SizedBox(height: 24),
              _buildDeleteCard(context),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  // ─────────────────────── STATUS CARD ───────────────────────

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Stack(
        children: [
          // Decorative blob
          Positioned(
            top: -20, right: -20,
            child: Container(
              width: 100, height: 100,
              decoration: const BoxDecoration(
                color: Color(0x0D0EA5A4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Linked phone number', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text('+91 98765 43210', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0x1A16A34A),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 12),
                                  SizedBox(width: 4),
                                  Text('Verified', style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Wallet active pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0x1A16A34A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6, height: 6,
                          decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        const Text('Wallet active', style: TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Stacked avatars
                  SizedBox(
                    width: 48,
                    height: 32,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          child: Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              color: const Color(0xFFEFF6F6),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                'https://lh3.googleusercontent.com/aida-public/AB6AXuAU5WxXmoK1I-rr93crJwFIOsLSt0zqXT1zTa99kFAMv9GzooutyMSETKoi0nkBC2o4_3_pO5IJNzAzsPDc1Ux3_Ejg_43DohHoGfPnnp1ZK6JyRvjapD_xAAlCRWvA5R12IXMi-QXIhTYOIU54UPQbFemv4kMyTq8C8aeEeXKvtNVkMWcRTxCYLS3nL4nZeFLfyanogFM1VfmrFphIUa5R6dFg7Jfy2Dq8zkI2hEs9kJogT0vlw6xl9M_f9aYI06FNg_ac3_BwxXgU',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, _) => const Icon(Icons.person, size: 18, color: Color(0xFF0EA5A4)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          child: Container(
                            width: 32, height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF0EA5A4),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Center(
                              child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('v2.4', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────── SETTINGS SECTION ───────────────────────

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        ...items.map((item) => Padding(padding: const EdgeInsets.only(bottom: 8), child: item)),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: const Color(0x1A0EA5A4),
        highlightColor: const Color(0x0D0EA5A4),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x050F172A), blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: const Color(0x1A0EA5A4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF0EA5A4), size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                  ],
                ),
              ),
              const Opacity(
                opacity: 0.4,
                child: Icon(Icons.arrow_forward_ios, color: Color(0xFF64748B), size: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────── DELETE CARD ───────────────────────

  Widget _buildDeleteCard(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => _showDeleteDialog(context),
        borderRadius: BorderRadius.circular(16),
        splashColor: const Color(0x1ADC2626),
        highlightColor: const Color(0x0DDC2626),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: const Color(0x1ADC2626),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete, color: Color(0xFFDC2626), size: 22),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delete wallet', style: TextStyle(color: Color(0xFFDC2626), fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text('This action cannot be undone', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                  ],
                ),
              ),
              const Opacity(
                opacity: 0.3,
                child: Icon(Icons.chevron_right, color: Color(0xFFDC2626), size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete wallet?', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        content: const Text(
          'This will permanently remove your VOSHIFY Wallet and all associated data. This action cannot be undone.',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(foregroundColor: const Color(0xFFDC2626)),
            child: const Text('Delete', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── BOTTOM NAV ───────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, -4))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home', false),
            _buildNavItem(Icons.local_laundry_service_outlined, Icons.local_laundry_service, 'Orders', false),
            _buildNavItem(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Wallet', false),
            _buildNavItem(Icons.person_outline, Icons.person, 'Profile', true),
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
