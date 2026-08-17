import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);
  static const _success = Color(0xFF16A34A);

  String _selectedMethod = 'google_pay'; // Currently selected method id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: _surface.withValues(alpha: 0.85),
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
          'Payment Methods',
          style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 40),
        children: [
          _buildSavedCardsSection(),
          const SizedBox(height: 32),
          _buildUpiSection(),
          const SizedBox(height: 32),
          _buildWalletsSection(),
          const SizedBox(height: 32),
          _buildNetBankingSection(),
          const SizedBox(height: 48),
          _buildTrustFooter(),
        ],
      ),
    );
  }

  // --- Saved Cards Section ---
  Widget _buildSavedCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'SAVED CARDS',
            style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        _buildSavedCardItem(
          title: '•••• 4242 · HDFC Debit',
          subtitle: 'Expiry 12/28',
          isDefault: true,
        ),
        const SizedBox(height: 12),
        _buildSavedCardItem(
          title: '•••• 8890 · ICICI Bank',
          subtitle: 'Expiry 05/26',
        ),
        const SizedBox(height: 12),
        _buildAddNewCardButton(),
      ],
    );
  }

  Widget _buildSavedCardItem({required String title, required String subtitle, bool isDefault = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 32,
            decoration: BoxDecoration(
              color: _surfaceAlt,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _divider),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.credit_card, color: _textSecondary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
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
                Text(subtitle, style: const TextStyle(color: _textSecondary, fontSize: 14)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: _textSecondary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewCardButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _primary.withValues(alpha: 0.3), style: BorderStyle.none),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, color: _primary),
              SizedBox(width: 8),
              Text('Add new card', style: TextStyle(color: _primary, fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  // --- UPI Section ---
  Widget _buildUpiSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'UPI',
            style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _buildSelectableRow(
                id: 'google_pay',
                icon: Icons.account_balance,
                title: 'Google Pay',
                subtitle: 'aarav@okhdfc',
              ),
              const Divider(color: _divider, height: 1),
              _buildSelectableRow(
                id: 'phonepe',
                icon: Icons.smartphone,
                title: 'PhonePe',
                subtitle: 'aarav@ybl',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.add_circle, color: _primary, size: 20),
                SizedBox(width: 4),
                Text('Add new UPI ID', style: TextStyle(color: _primary, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Wallets Section ---
  Widget _buildWalletsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'WALLETS',
            style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _buildSelectableRow(
                id: 'orio_wallet',
                icon: Icons.account_balance_wallet,
                title: 'Orio Wallet',
                subtitleWidget: const Text('₹1,250', style: TextStyle(color: _success, fontSize: 14, fontWeight: FontWeight.bold)),
                iconColor: _primary,
                iconBg: _primary.withValues(alpha: 0.1),
              ),
              const Divider(color: _divider, height: 1),
              _buildSelectableRow(
                id: 'amazon_pay',
                icon: Icons.account_balance_wallet,
                title: 'Amazon Pay',
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Net Banking Section ---
  Widget _buildNetBankingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'NET BANKING',
            style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        Material(
          color: _surface,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: const Icon(Icons.account_balance, color: _textSecondary, size: 20),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text('Select bank', style: TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                  const Icon(Icons.chevron_right, color: _textSecondary),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Generic Selectable Row for Radio Buttons ---
  Widget _buildSelectableRow({
    required String id,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? subtitleWidget,
    Color iconColor = _textSecondary,
    Color iconBg = const Color(0xFFF1F5F9), // slate-100
  }) {
    final isSelected = _selectedMethod == id;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = id),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                    if (subtitleWidget != null) ...[
                      const SizedBox(height: 2),
                      subtitleWidget,
                    ] else if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(color: _textSecondary, fontSize: 14)),
                    ],
                  ],
                ),
              ),
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? _primary : _divider, width: 2),
                  color: isSelected ? _primary : Colors.transparent,
                ),
                alignment: Alignment.center,
                child: isSelected
                    ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle))
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Trust Footer ---
  Widget _buildTrustFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8E9).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.lock, color: _textSecondary, size: 14),
              SizedBox(width: 6),
              Text('Your payment info is encrypted & secure', style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0,      0,      0,      1, 0,
              ]), // Grayscale effect
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCY41yYa0R_3CnADQcuq_ZNzYG9dmj7GRpvmMnHTEtq429-18FDsEI6z_95Uo7ZusLmD3JI54q28aoBe4wXxbykqhxJaCZCL7LDUyqQur_aRaT2xr5xlMBNhjHi8Sss0IR4xzZomcs5ibMwqmwxQXxitskBPC7nUL7In4REm0HkSODM4kaPVH8hBVyByxgiZne9YVFFTgPbDv0Kql8RF3VeUAqdwIkbLOlmsQSM2H3Yl_90bgs51qGHRIbg6Sj7CnOjn-s1DYIO1nkW',
                height: 16,
              ),
            ),
            const SizedBox(width: 24),
            ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0,      0,      0,      1, 0,
              ]),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuC5EMewOwKOO3CHBKvHvLrNQfXpuyFkz0pj2PaFF-nP-8tUz4iNZ8MB9jTeQoK3TbQ05OZ1HyCiGZDlYk2w-OBE2LEc0ZECSwJLBk0J1sX-8c868FJpWD1WNLEdkvWbPtQGOxDnBaftHHACpppHGMcWZl2AIXiIhk-eeurCoYDP0TG52Z_Tvmpvi_rFXBDsAlYkrzr3PEUwqUxB7uSWy7Ifh7EEeqDy40r0kD7oPaGhVuj4DGHfjoVXYKLUqXCoNHiQKGzAFJ0OM97n',
                height: 24,
              ),
            ),
            const SizedBox(width: 24),
            ColorFiltered(
              colorFilter: const ColorFilter.matrix([
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0,      0,      0,      1, 0,
              ]),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDH6u2vKBAqHPxXtRxczBLz95hf6gozti4j51GMO9v9QfXYbgMe7lqcEk_iDnSeY1UNsGXUfKGkqOqZRjImuDRt6QbQq_VqsRiqs0nyBF1AAJhsz5UAzdb2-27XWs8rpRzQky3Rf1j1awxxDkDjgU69B4_bnGVqfQ-NyAj23rHAwvZuHQx9b80O-MaoNc53slnctTJiqTI5MK-zkhWb_h8sRelGDpFUy4Rb8SGymU87wJtqB5YoMnAcYku70oXl-vKVXcQZR06bNkAn',
                height: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
