import 'package:flutter/material.dart';
import 'package:laundry/presentation/widgets/app_widgets.dart';
import 'package:laundry/presentation/screens/booking/edit_profile_screen.dart';
import 'package:laundry/presentation/screens/booking/notification_settings_screen.dart';
import 'package:laundry/presentation/screens/booking/accessibility_settings_screen.dart';
import 'package:laundry/presentation/screens/booking/about_screen.dart';
import 'package:laundry/presentation/screens/profile/terms_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: VoshifyAppBar(title: 'Settings'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 32),

            _buildSection(
              title: 'ACCOUNT',
              items: [
                _SettingsRow(icon: Icons.person, label: 'Edit profile',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
                _SettingsRow(icon: Icons.link, label: 'Linked accounts', onTap: () {}),
                _SettingsRow(icon: Icons.devices, label: 'Manage devices', onTap: () {}),
              ],
            ),
            const SizedBox(height: 32),

            _buildSection(
              title: 'NOTIFICATIONS',
              items: [
                _SettingsRow(icon: Icons.notifications, label: 'Push, email & SMS',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()))),
              ],
            ),
            const SizedBox(height: 32),

            _buildSection(
              title: 'SECURITY',
              items: [
                _SettingsRow(icon: Icons.lock_open, label: 'App lock', subtitle: 'Face ID', onTap: () {}),
                _SettingsRow(icon: Icons.dialpad, label: 'Change PIN', onTap: () {}),
                _SettingsRow(
                  icon: Icons.verified_user,
                  label: 'Two-factor authentication',
                  onTap: () {},
                  trailingBadge: VoshifyBadge(label: 'ON', color: AppColors.success, textColor: AppColors.success),
                ),
              ],
            ),
            const SizedBox(height: 32),

            _buildSection(
              title: 'APPEARANCE',
              items: [
                _SettingsRow(icon: Icons.palette, label: 'Theme', subtitle: 'System',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccessibilitySettingsScreen()))),
                _SettingsRow(icon: Icons.language, label: 'Language', subtitle: 'English', onTap: () {}),
              ],
            ),
            const SizedBox(height: 32),

            _buildSection(
              title: 'PRIVACY',
              items: [
                _SettingsRow(icon: Icons.security, label: 'Data & privacy', onTap: () {}),
                _SettingsRow(icon: Icons.download, label: 'Download my data', onTap: () {}),
                _SettingsRow(icon: Icons.cleaning_services, label: 'Clear cache', subtitle: '24 MB', onTap: () {}),
              ],
            ),
            const SizedBox(height: 32),

            _buildSection(
              title: 'ABOUT',
              items: [
                _SettingsRow(icon: Icons.info_outline, label: 'About VOSHIFY',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()))),
                _SettingsRow(icon: Icons.description_outlined, label: 'Terms',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen()))),
                _SettingsRow(icon: Icons.policy, label: 'Privacy policy', onTap: () {}),
                _SettingsRow(icon: Icons.ad_units, label: 'App version', subtitle: 'v2.4.0', isNavigable: false),
              ],
            ),
            const SizedBox(height: 32),

            // Danger Zone
            Center(
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Delete account', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  '© 2024 VOSHIFY Inc. Made with care for your clothes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 64, height: 64,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBf1m6Uc8fEeWaA2w0IBlkvNfk9jps83niP4j6z4ITfv-DA-VEff6RkYDiTEo_kqAcq7jFuQNn3npNUVtqI94jh4YGuqDucIMMWqMbmPngu4fAq1oEBsG6RBIeUPezZBknjtWaj4gA4vffFV82kF9LU5PqjR1SlIDh8lTgIG4KzY4d7iOgRIn4-PA6rR4hLnK8olwYU7uz_Ti0hXRfSvr7vNooqV55cROAoqn8uGO_f6bKBLPS01uHDOoI1HOU9BEwMPZHgMKmB6zBF',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceAlt,
                  alignment: Alignment.center,
                  child: const Icon(Icons.person, color: AppColors.primary, size: 32),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alex Henderson', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Premium Member • Gold Tier', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: AppColors.primary, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<_SettingsRow> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 16, offset: Offset(0, 4))],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  _buildRow(item),
                  if (index < items.length - 1)
                    const VoshifyDivider(indent: 16, endIndent: 16),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(_SettingsRow item) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(item.icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                if (item.subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(item.subtitle!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ],
            ),
          ),
          if (item.trailingBadge != null) ...[
            item.trailingBadge!,
            const SizedBox(width: 8),
          ],
          if (item.isNavigable)
            const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
        ],
      ),
    );

    if (!item.isNavigable || item.onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        splashColor: AppColors.primary.withValues(alpha: 0.05),
        highlightColor: AppColors.surfaceAlt,
        child: content,
      ),
    );
  }
}

class _SettingsRow {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
    this.trailingBadge,
    this.isNavigable = true,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailingBadge;
  final bool isNavigable;
}
