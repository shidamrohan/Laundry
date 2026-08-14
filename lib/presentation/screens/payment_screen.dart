import 'package:flutter/material.dart';
import 'add_card_bottom_sheet.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'google_pay'; // Default recommended

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // Content
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: topPadding + 64, bottom: 120),
              children: [
                const SizedBox(height: 16),
                _buildAmountSummary(),
                const SizedBox(height: 16),
                _buildOffersBanner(),
                const SizedBox(height: 24),
                _buildRecommendedSection(),
                const SizedBox(height: 24),
                _buildUPISection(),
                const SizedBox(height: 24),
                _buildCardsSection(),
                const SizedBox(height: 24),
                _buildMoreOptionsSection(),
                const SizedBox(height: 32),
                _buildTrustBadges(),
                const SizedBox(height: 32),
              ],
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),
          
          // Sticky Bottom Bar
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomBar(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Text('Payment', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5))),
          const SizedBox(width: 40), // Spacer for balance
        ],
      ),
    );
  }

  Widget _buildAmountSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Amount to pay', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text('₹844', style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.w900)),
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: const [
                  Text('View bill', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.visibility, color: Color(0xFF0EA5A4), size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffersBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF), // Blue-50
          border: Border.all(color: const Color(0xFFDBEAFE)), // Blue-100
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 4, offset: Offset(0, 1))],
                    image: const DecorationImage(
                      image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBE_J33ca1hgintlS_nUQhgKIaeymKeq5ucc0xbR9fyUlMRt6npn_ilKmDdcbWhvQXsis-BQdQ47duP2UE8-zJMn5Ti-nshWs7BRuQU3XADzZbraOQsxgkIJWkmCVA3ksfEHyodh4VIzAW1i3vZ6q0oP0PSBTvvCvgW01ycSAw8oKDNDuzExWGjXo3E0RmjCvDvAdfMfmeKk9s6pa5qQXovlqPkWe-tD1OdkYk-0cTqtiUGxTAa7ga9i9VV6I4k_8CT64QuBsYsaqdE'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Save ₹40 with Paytm', style: TextStyle(color: Color(0xFF1E40AF), fontSize: 14, fontWeight: FontWeight.w600)),
              ],
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF60A5FA), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedSection() {
    final isSelected = _selectedPaymentMethod == 'google_pay';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 12),
            child: Text('RECOMMENDED', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          ),
          GestureDetector(
            onTap: () => setState(() => _selectedPaymentMethod = 'google_pay'),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 16, offset: Offset(0, 4))],
              ),
              child: Stack(
                children: [
                  // Gradient Border Simulation
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0x330EA5A4), width: 2), // Fallback
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48, height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6F6),
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDncvDr8SL7fjKVtntK6s7W6T8fIk0mLmVk7tJi_9BtRMV6-9umYnZy_CS9VQql7AZTJWwM8V8fFBDDUevea464Bg17-1PCrg0kp6FakaSojNzCuVBCcBHTkRZhGYTJx2EFN0dwq9LjPQZi2zipD91L3W6mTWsGB-oSGOmbW0bJB8pvGP5ABzNghToeuwlvn2A7pM4TtPS5aXNff9t-tnQS3O1tJNOv_KgugTD10vTR1kcM3vjWljp34aYKuoaUqLJZw5vIgRADvoQA'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('UPI · Google Pay', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(color: const Color(0x1A0EA5A4), borderRadius: BorderRadius.circular(12)),
                                    child: const Text('5% CASHBACK', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 10, fontWeight: FontWeight.w900)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text('Instant & Secure Payment', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      _buildRadio(isSelected),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUPISection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('PAY BY UPI', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            ),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildPaymentOption(
              id: 'phonepe',
              title: 'PhonePe',
              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBHOlIeHGSqgo9CKHP_7jDbGrEQmJih79W6nhlTKDBX3Vb0gb-dW_vmsgVnCpFEZnizm4lN055phsgp9h4NXjlIcqyBHF_HluAOAipFDTucVTJimRrcpfpmm7klfRvOGGNcIv4WTR8JZgVUkF2zUNBIBMwB_rWfsBpnaV7e4Cf8F4mRYzyDsWdsyYO0RmbvD85SbMNoAm0Q_zZ9QykztCsC7471St04rBHY_2jvYqo-4d5zBznmiuXcqpHTwu-BmNa4ifL2vM-npEkY',
            ),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildPaymentOption(
              id: 'paytm',
              title: 'Paytm',
              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAskMhGo4tZ2HIW4ANolyHObUZ_HXIp6iCCg026f3l1h5gYQPk6yUmWTw_M9X8NJPG9_Y2Ce4cstplwaN7SP0rlwzEeDhWziOuaVCxIr11kTq74q7M6lxX_VSgjZQ2iMfnkAJGjJ4aEaFtndyMMSul8-RvRRXKpILHE9IR4MgGgd1YWnPD4ay9In_GJw4ZbG1BK4XeAQK-oo859ouJnMkRDXB5fxCRy1fvyvkGB3xf2G9hFuPRifdnq57a5sJvSbcon61z1ttTYMKZL',
            ),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildActionOption(
              icon: Icons.add,
              title: 'Add new UPI ID',
              color: const Color(0xFF0EA5A4),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('CARDS', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            ),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildPaymentOption(
              id: 'card_4242',
              title: '•••• 4242',
              subtitle: 'HDFC Bank · Credit Card',
              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDSyb5VDwToXFNTznILPQ6yJx5bQvxOv_bdgFJwIwFpcrUn7oRkP1JMGmtRvZIXjdu2DTE7If2623_jne5ZGb7CErf8E45i17wM-IrvXvhw85s6ntYU98_sfiUvrRHzn0ANm2bdqnyT94vV0VgJhr_iUt2glddb5wRm63P4D6I9fDHyvYcjxIRVzw12HHALYLz5jMnc_n0c-My9ydo6RHZop0bn3_oIV38fM-V6BGixdVk5Di2OK4JqnUx_hFkMN2BXq8HBdeROUH9b',
            ),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildActionOption(
              icon: Icons.credit_card,
              title: 'Add new card',
              color: const Color(0xFF0EA5A4),
              onTap: () => showAddCardBottomSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoreOptionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('MORE OPTIONS', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            ),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildNavOption(icon: Icons.account_balance, title: 'Net Banking'),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildNavOption(
              icon: null,
              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAilJZyRE7WoK_mRTk8TvFsxXKaWzX4lpGkQkqJdNip254OLFCYbynLYhwRWWaXxj3c_Dci7bXw9AH7nyGj2mGYthGNexIcslfOw2bVtTtpyH3wdWC79PnayxolLH2yviSI9qMNF8Cwwo8aPloR_Xs4GHAHCX9qxNQKaXlBmgaTWl8nYu7KQvPm5Vp-js7NmcQnnq4Pg0fNhBDDJ08kfRt0Y5T3vK39_9NZP8HcwrEQziwnEd9oRQE9UNcKUtiqkQy4Pffe3ciyTmKl',
              title: 'Wallets',
              subtitle: 'Orio Wallet: ₹450',
              subtitleColor: const Color(0xFF0EA5A4),
            ),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildPaymentOption(id: 'cop', title: 'Cash on pickup', icon: Icons.payments),
            const Divider(height: 1, color: Color(0xFFE2E8E9)),
            _buildPaymentOption(id: 'cod', title: 'Cash on delivery', icon: Icons.handshake),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustBadges() {
    return Column(
      children: const [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_user, color: Color(0xFF0F172A), size: 16),
            SizedBox(width: 8),
            Text('100% SECURE PAYMENTS', style: TextStyle(color: Color(0xFF0F172A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          ],
        ),
        SizedBox(height: 8),
        Text('PCI-DSS compliant systems with 256-bit encryption', style: TextStyle(color: Color(0xFF0F172A), fontSize: 10)),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0A000000), blurRadius: 30, offset: Offset(0, -8))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('Total to pay', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text('₹844', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.w900)),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Final payment action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A4),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: const Color(0x330EA5A4),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Pay ₹844', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helpers

  Widget _buildPaymentOption({required String id, required String title, String? subtitle, String? imageUrl, IconData? icon}) {
    final isSelected = _selectedPaymentMethod == id;
    return InkWell(
      onTap: () => setState(() => _selectedPaymentMethod = id),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildIconOrImage(icon, imageUrl),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ],
                ),
              ],
            ),
            _buildRadio(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _buildActionOption({required IconData icon, required String title, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavOption({IconData? icon, String? imageUrl, required String title, String? subtitle, Color? subtitleColor}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildIconOrImage(icon, imageUrl),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(subtitle, style: TextStyle(color: subtitleColor ?? const Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ],
                ),
              ],
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF64748B), size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildIconOrImage(IconData? icon, String? imageUrl) {
    return Container(
      width: 40, height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: imageUrl != null
          ? ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(imageUrl, fit: BoxFit.contain))
          : Icon(icon, color: const Color(0xFF64748B), size: 20),
    );
  }

  Widget _buildRadio(bool isSelected) {
    return Container(
      width: 24, height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9), width: 2),
      ),
      child: isSelected
          ? Center(child: Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFF0EA5A4), shape: BoxShape.circle)))
          : null,
    );
  }
}
