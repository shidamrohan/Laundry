import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
        title: const Text('Support',
            style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.3)),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE2E8E9)),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 120),
              children: [
                // Header Section Card
                _buildHeaderCard(),
                const SizedBox(height: 24),

                // Support Options
                _buildSupportOption(
                  icon: Icons.chat_bubble,
                  iconColor: const Color(0xFF0EA5A4),
                  iconBgColor: const Color(0x1A0EA5A4),
                  title: 'Live chat',
                  subtitle: 'Avg reply 2 min',
                  hasDot: true,
                ),
                const SizedBox(height: 12),
                _buildSupportOption(
                  icon: Icons.call,
                  iconColor: const Color(0xFF7C3AED),
                  iconBgColor: const Color(0x1A7C3AED),
                  title: 'Call us',
                  subtitle: 'Toll-free',
                ),
                const SizedBox(height: 12),
                _buildSupportOption(
                  icon: Icons.mail,
                  iconColor: const Color(0xFFEA580C), // orange-600
                  iconBgColor: const Color(0xFFFFEDD5), // orange-100
                  title: 'Email',
                  subtitle: 'support@orio.app',
                ),
                const SizedBox(height: 12),
                _buildSupportOption(
                  icon: Icons.assignment,
                  iconColor: const Color(0xFF0D9488), // teal-600
                  iconBgColor: const Color(0xFFCCFBF1), // teal-100
                  title: 'Raise a ticket',
                  subtitle: 'New request',
                ),
                const SizedBox(height: 12),
                _buildSupportOption(
                  icon: Icons.error_outline,
                  iconColor: const Color(0xFFDC2626), // error
                  iconBgColor: const Color(0x1ADC2626),
                  title: 'Report a transaction',
                  subtitle: 'Billing issues',
                ),
                const SizedBox(height: 32),

                // Ticket History
                const Padding(
                  padding: EdgeInsets.only(left: 4, bottom: 16),
                  child: Text('Your tickets', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                _buildTicketCard(),

                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Most issues are resolved within 24 hours.',
                    style: TextStyle(color: Color(0xBF64748B), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Navigation
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x80E2E8E9)),
      ),
      padding: const EdgeInsets.only(left: 24, top: 24, bottom: 24, right: 0),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "We're here to help, 24/7",
                  style: TextStyle(color: Color(0xFF0F172A), fontSize: 22, fontWeight: FontWeight.bold, leadingDistribution: TextLeadingDistribution.even),
                ),
                SizedBox(height: 8),
                Text(
                  'Our experts are online to assist with your laundry needs.',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 100,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDTc0g1sboJBZW3pmYXdmbVWPGEvhdx8alhddHyNZV7iqoRDXm6aHPtW0YKBrktoimwRXg1cS1Xgcf02xRiYHWMQJTu5NQcT9iu1ZX0rH4ZnhMEmFQgYayg5psLK7ULw8AmrbvZR4kH6jajYPihFz21XVCKETbukG8DTgJ2AHNsdoSe7pbS2mRj88FFtcMYnQacnXFkq2F9u0zzttmtzdRu6tDtNSAbzXH_V-j_oVblwch6O6jSp6iwutuZVoam26wMU8yM_hE_fg1j',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.support_agent, size: 60, color: Color(0xFF0EA5A4)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    bool hasDot = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                      child: Icon(icon, color: iconColor, size: 24),
                    ),
                    if (hasDot)
                      Positioned(
                        top: 0, right: 0,
                        child: Container(
                          width: 12, height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF16A34A),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0x6664748B)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 4, offset: Offset(0, 1))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Missing laundry items', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text('Ref: #TK-2041', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x1AF59E0B),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x33F59E0B)),
                ),
                child: const Text('IN PROGRESS', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0x80E2E8E9), height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Updated 2h ago', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              Row(
                children: const [
                  Text('Track ticket', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Color(0xFF0EA5A4), size: 18),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

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
            _buildNavItem(Icons.support_agent_outlined, Icons.support_agent, 'Support', true),
            _buildNavItem(Icons.person_outline, Icons.person, 'Profile', false),
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
            ? Transform.scale(
                scale: 1.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(20)),
                  child: Icon(filledIcon, color: const Color(0xFF0EA5A4), size: 24),
                ),
              )
            : Icon(outlinedIcon, color: const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 11, fontWeight: isActive ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
