import 'package:flutter/material.dart';

class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({super.key});

  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);
  static const _error = Color(0xFFDC2626);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: _surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _divider),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primary),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'Address book',
          style: TextStyle(color: _primary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 40),
        children: [
          _buildAddNewAddressButton(),
          const SizedBox(height: 16),
          _buildAddressCard(
            icon: Icons.home,
            title: 'Home',
            isDefault: true,
            nameAndPhone: 'Aarav Kumar · +91 98765 43210',
            address: '21 Brigade Road, Shanthala Nagar, Bengaluru 560025',
          ),
          const SizedBox(height: 16),
          _buildAddressCard(
            icon: Icons.work,
            title: 'Work',
            nameAndPhone: 'Aarav Kumar · +91 98765 43210',
            address: 'Prestige Tech Park, Marathahalli, Outer Ring Rd, Bengaluru',
          ),
          const SizedBox(height: 16),
          _buildAddressCard(
            icon: Icons.location_on,
            title: "Mom's place",
            nameAndPhone: 'Aarav Kumar · +91 98765 43210',
            address: 'Green Glen Layout, Bellandur, Bengaluru, Karnataka 560103',
          ),
          const SizedBox(height: 32),
          _buildFooterIllustration(),
        ],
      ),
    );
  }

  Widget _buildAddNewAddressButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _primary.withValues(alpha: 0.5), width: 2, style: BorderStyle.solid), // Flutter doesn't have native dashed border without custom painter, using solid but lighter
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(color: _surfaceAlt, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Icon(Icons.add, color: _primary),
              ),
              const SizedBox(width: 12),
              const Text(
                'Add new address',
                style: TextStyle(color: _primary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required IconData icon,
    required String title,
    bool isDefault = false,
    required String nameAndPhone,
    required String address,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _divider),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48, height: 48,
                decoration: const BoxDecoration(color: _surfaceAlt, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(icon, color: _primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                        if (isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: const Text('DEFAULT', style: TextStyle(color: _primary, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(nameAndPhone, style: const TextStyle(color: _textSecondary, fontSize: 14)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: _textSecondary),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            address,
            style: const TextStyle(color: _textPrimary, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 12),
          const Divider(color: _divider, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildActionButton('Edit', _primary),
              const SizedBox(width: 16),
              _buildActionButton('Share', _primary),
              const SizedBox(width: 16),
              _buildActionButton('Delete', _error),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildFooterIllustration() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0,      0,      0,      0.4, 0,
        ]), // grayscale + 0.4 opacity
        child: Column(
          children: [
            Container(
              width: 96, height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDGBE7VdEt1HuYCvXGy8LL9TKemSi5_Jk4Ff7wZFa6-PjKGib4XVdNpeQsU60bcj2-7rzwIc814lVhzAe1enA_0rngbjrEZIyME-Tv7JeRWIL_DDJv40LPGZmQLRWahibIuSpwC-AROVDwrZmrUB_FTiw7zhT5kEKhkSP8b1N8FcRkZ_bsm-oWGuEXeAJV23MQnUUv_VHXJH7tLgnsJjUfrVDwQea12nmE69LoCD_i5RZHjSCm8inAUgP7tQWce-41hxTVakngYNwlh'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Save multiple addresses for home, work, and family for a faster checkout experience.',
                textAlign: TextAlign.center,
                style: TextStyle(color: _textSecondary, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
