import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/your_orders_screen.dart';
import 'package:laundry/presentation/screens/booking/address_book_screen.dart';
import 'package:laundry/presentation/screens/booking/payment_methods_screen.dart';
import 'package:laundry/presentation/screens/booking/wallet_settings_screen.dart';
import 'package:laundry/presentation/screens/booking/notification_settings_screen.dart';
import 'package:laundry/presentation/screens/booking/accessibility_settings_screen.dart';
import 'package:laundry/presentation/screens/booking/help_center_screen.dart';
import 'package:laundry/presentation/screens/booking/about_screen.dart';
import 'package:laundry/presentation/screens/booking/report_issue_screen.dart';
import 'package:laundry/presentation/screens/booking/logout_confirmation_dialog.dart';
import 'package:laundry/presentation/screens/booking/edit_profile_screen.dart';
import 'package:laundry/presentation/screens/booking/wallet_screen.dart';
import 'package:laundry/presentation/screens/booking/coupons_offers_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xCCFFFFFF), // surface/80
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text('Profile', style: TextStyle(color: Color(0xFF111C2D), fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Color(0xFF111C2D)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileCard(context),
            const SizedBox(height: 24),
            _buildMembershipCard(),
            const SizedBox(height: 24),
            _buildQuickActionRow(context),
            const SizedBox(height: 32),
            _buildSettingsGroups(context),
            const SizedBox(height: 32),
            
            // Logout Button
            OutlinedButton.icon(
              onPressed: () {
                showLogoutConfirmationDialog(context);
              },
              icon: const Icon(Icons.logout, color: Color(0xFFDC2626)),
              label: const Text('Log out', style: TextStyle(color: Color(0xFFDC2626), fontSize: 18, fontWeight: FontWeight.w600)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0x33DC2626), width: 2), // dashed-like mock
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 16),
            const Text('VOSHIFY Laundry v4.2.0 • Made with Cleanliness', textAlign: TextAlign.center, style: TextStyle(color: Color(0x663D4949), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [BoxShadow(color: Color(0x4D0EA5A4), blurRadius: 50, offset: Offset(0, 20))],
      ),
      padding: const EdgeInsets.all(24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background decorative elements mocked by container shape
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 96, height: 96,
                    decoration: BoxDecoration(
                      color: const Color(0x33FFFFFF),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0x4DFFFFFF), width: 4),
                    ),
                    alignment: Alignment.center,
                    child: const Text('AK', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 2))],
                      ),
                      child: const Icon(Icons.edit, color: Color(0xFF0EA5A4), size: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Aarav Kumar', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              const Text('+91 98765 43210', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 14)),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0x80FFFFFF)),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Edit profile', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x337C3AED), blurRadius: 30, offset: Offset(0, 15))],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.workspace_premium, color: Colors.white, size: 24), // crown proxy
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('VOSHIFY Plus member', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text("You've saved ₹2,480", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xB3FFFFFF)),
        ],
      ),
    );
  }

  Widget _buildQuickActionRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.account_balance_wallet,
            iconColor: const Color(0xFF0EA5A4),
            iconBgColor: const Color(0x1A0EA5A4),
            title: 'Wallet',
            value: '₹1,250',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen())),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.confirmation_number,
            iconColor: const Color(0xFF2563EB),
            iconBgColor: const Color(0x1A2563EB),
            title: 'Coupons',
            value: '6 available',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CouponsOffersScreen())),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({required IconData icon, required Color iconColor, required Color iconBgColor, required String title, required String value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 4, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const Icon(Icons.chevron_right, color: Color(0x663D4949), size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Color(0xB33D4949), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Color(0xFF111C2D), fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsGroups(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSettingsGroup(
          title: 'ORDERS & SERVICES',
          items: [
            _SettingsItem(icon: Icons.local_laundry_service, iconColor: const Color(0xFF0EA5A4), title: 'Your orders', subtitle: 'Track, cancel, or reorder', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const YourOrdersScreen()))),
            _SettingsItem(icon: Icons.location_on, iconColor: const Color(0xFF0EA5A4), title: 'Address book', subtitle: 'Manage home and office addresses', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressBookScreen()))),
            _SettingsItem(icon: Icons.bookmark, iconColor: const Color(0xFF0EA5A4), title: 'Saved services', subtitle: 'Quick access to frequent needs', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved services coming soon!')));
            }),
          ],
        ),
        const SizedBox(height: 32),
        _buildSettingsGroup(
          title: 'PAYMENTS',
          items: [
            _SettingsItem(icon: Icons.credit_card, iconColor: const Color(0xFF0EA5A4), title: 'Payment methods', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()))),
            _SettingsItem(icon: Icons.account_balance, iconColor: const Color(0xFF0EA5A4), title: 'VOSHIFY Wallet settings', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletSettingsScreen()))),
          ],
        ),
        const SizedBox(height: 32),
        _buildSettingsGroup(
          title: 'PREFERENCES',
          items: [
            _SettingsItem(icon: Icons.notifications_active, iconColor: const Color(0xFF0EA5A4), title: 'Notifications', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()))),
            _SettingsItem(icon: Icons.palette, iconColor: const Color(0xFF0EA5A4), title: 'Appearance', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccessibilitySettingsScreen()))),
            _SettingsItem(icon: Icons.language, iconColor: const Color(0xFF0EA5A4), title: 'Language', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Language settings coming soon!')));
            }),
          ],
        ),
        const SizedBox(height: 32),
        _buildSettingsGroup(
          title: 'SUPPORT',
          items: [
            _SettingsItem(icon: Icons.help_center, iconColor: const Color(0xFF0EA5A4), title: 'Help & support', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpCenterScreen()))),
            _SettingsItem(icon: Icons.info, iconColor: const Color(0xFF0EA5A4), title: 'About VOSHIFY', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()))),
            _SettingsItem(icon: Icons.report, iconColor: const Color(0xFFDC2626), title: 'Report emergency', titleColor: const Color(0xFFDC2626), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportIssueScreen()))),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsGroup({required String title, required List<_SettingsItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(title, style: const TextStyle(color: Color(0x993D4949), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: item.onTap ?? () {},
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(color: item.iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                              alignment: Alignment.center,
                              child: Icon(item.icon, color: item.iconColor, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title, style: TextStyle(color: item.titleColor ?? const Color(0xFF111C2D), fontSize: 15, fontWeight: FontWeight.w600)),
                                  if (item.subtitle != null) ...[
                                    Text(item.subtitle!, style: const TextStyle(color: Color(0xB33D4949), fontSize: 12)),
                                  ],
                                ],
                              ),
                            ),
                            Icon(Icons.chevron_right, color: item.titleColor != null ? item.titleColor!.withValues(alpha: 0.5) : const Color(0x803D4949)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (index < items.length - 1)
                    const Divider(color: Color(0xFFE2E8F0), height: 1, indent: 72),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

}

class _SettingsItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final VoidCallback? onTap;

  _SettingsItem({required this.icon, required this.iconColor, required this.title, this.subtitle, this.titleColor, this.onTap});
}
