import 'package:flutter/material.dart';

class CouponsOffersScreen extends StatefulWidget {
  const CouponsOffersScreen({super.key});

  @override
  State<CouponsOffersScreen> createState() => _CouponsOffersScreenState();
}

class _CouponsOffersScreenState extends State<CouponsOffersScreen> {
  final TextEditingController _couponController = TextEditingController();
  int _selectedFilterIndex = 0;
  bool _showToast = true;

  final List<String> _filters = ['All', 'First Order', 'Membership', 'Festival', 'Cashback', 'Referral'];

  @override
  void initState() {
    super.initState();
    // Auto-hide toast after 3 seconds for realism
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showToast = false);
      }
    });
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

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
                _buildManualEntry(),
                const SizedBox(height: 16),
                _buildAutoApplyCard(),
                const SizedBox(height: 16),
                _buildFilterSection(),
                const SizedBox(height: 16),
                _buildCouponList(),
                const SizedBox(height: 32),
                _buildEmptyIllustration(),
                const SizedBox(height: 32),
              ],
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),

          // Toast
          if (_showToast)
            Positioned(
              top: topPadding + 16,
              left: 16,
              right: 16,
              child: _buildToast(),
            ),

          // Sticky Bottom Nav
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomNav(),
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
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
            splashRadius: 24,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          const Text('Coupons & offers', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
        ],
      ),
    );
  }

  Widget _buildToast() {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0x1A16A34A),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0x3316A34A)),
            // Simulate backdrop blur
            boxShadow: const [BoxShadow(color: Colors.white, blurRadius: 10, spreadRadius: 5)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 18),
              SizedBox(width: 8),
              Text('Coupon applied · ₹150 saved', style: TextStyle(color: Color(0xFF16A34A), fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManualEntry() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
              ),
              child: TextField(
                controller: _couponController,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.0),
                decoration: const InputDecoration(
                  hintText: 'ENTER COUPON CODE',
                  hintStyle: TextStyle(color: Color(0x8064748B), fontWeight: FontWeight.w600, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5A4),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0x4D0EA5A4),
              minimumSize: const Size(80, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('Apply', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoApplyCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 96,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF0EA5A4), Color(0xFF38BDF8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -40, bottom: -40,
              child: Container(
                width: 160, height: 160,
                decoration: const BoxDecoration(color: Color(0x1AFFFFFF), shape: BoxShape.circle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(color: const Color(0x33FFFFFF), borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.auto_awesome, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Auto-apply best coupon', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 2),
                          Text("We'll find the biggest savings for you", style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 12, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: const Color(0x4DFFFFFF)),
                        ),
                        child: const Text('BEST SAVING ₹150', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 8, offset: Offset(0, 4))],
                        ),
                        child: const Text('Apply best', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(_filters.length, (index) {
          final filter = _filters[index];
          final isSelected = _selectedFilterIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilterIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
                  boxShadow: isSelected ? const [BoxShadow(color: Color(0x330EA5A4), blurRadius: 8, offset: Offset(0, 2))] : null,
                ),
                child: Text(
                  filter,
                  style: TextStyle(color: isSelected ? Colors.white : const Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCouponList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildCouponCard(
            code: 'VOSHIFY150',
            desc: '₹150 off orders above ₹499',
            saveText: 'You save ₹150',
            validity: 'Valid till 30 Jul',
            state: 'applied',
          ),
          const SizedBox(height: 16),
          _buildCouponCard(
            code: 'FEST40',
            desc: 'Up to 40% off on all bulk orders',
            saveText: 'Add ₹120 more to unlock',
            validity: 'Bulk orders only',
            state: 'ineligible',
          ),
          const SizedBox(height: 16),
          _buildCouponCard(
            code: 'CASHBACK200',
            desc: 'Flat ₹200 Cashback on your 5th order',
            saveText: 'You save ₹200',
            validity: 'Valid till 15 Aug',
            state: 'available',
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard({required String code, required String desc, required String saveText, required String validity, required String state}) {
    Color borderColor;
    Color codeColor;
    Widget actionWidget;
    Widget saveWidget;
    double opacity = 1.0;

    if (state == 'applied') {
      borderColor = const Color(0xFF0EA5A4);
      codeColor = const Color(0xFF0EA5A4);
      actionWidget = Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 16),
          const SizedBox(width: 4),
          const Text('Applied', style: TextStyle(color: Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          GestureDetector(onTap: () {}, child: const Text('Remove', style: TextStyle(color: Color(0xFFDC2626), fontSize: 12, fontWeight: FontWeight.bold))),
        ],
      );
      saveWidget = Text(saveText, style: const TextStyle(color: Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.bold));
    } else if (state == 'ineligible') {
      borderColor = const Color(0x4D7C3AED);
      codeColor = const Color(0x997C3AED);
      opacity = 0.6; // Simulate disabled state
      actionWidget = const SizedBox.shrink();
      saveWidget = Row(
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF64748B), size: 14),
          const SizedBox(width: 4),
          Text(saveText, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      );
    } else { // available
      borderColor = const Color(0xFFF59E0B);
      codeColor = const Color(0xFFF59E0B);
      actionWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFF0EA5A4)),
        ),
        child: const Text('Apply', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold)),
      );
      saveWidget = Text(saveText, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.bold));
    }

    return Opacity(
      opacity: opacity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            // Left border and perforation
            Container(
              width: 4,
              height: 120,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
              ),
            ),
            // Notch container
            SizedBox(
              width: 16,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -12,
                    child: Container(width: 24, height: 24, decoration: const BoxDecoration(color: Color(0xFFF7FAFB), shape: BoxShape.circle)),
                  ),
                  Positioned(
                    top: 12, bottom: 12, left: 14,
                    child: Container(
                      width: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFFE2E8E9), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(code, style: TextStyle(color: codeColor, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                        actionWidget,
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(desc, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    saveWidget,
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(validity, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500)),
                        const Text('Terms', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyIllustration() {
    return Opacity(
      opacity: 0.4,
      child: Column(
        children: [
          Container(
            width: 64, height: 64,
            decoration: const BoxDecoration(color: Color(0xFFE2E8E9), shape: BoxShape.circle),
            child: const Icon(Icons.confirmation_number, color: Color(0xFF64748B), size: 32),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'More offers are added every week. Keep checking for the best laundry deals!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500),
            ),
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
            _buildNavItem(Icons.home, 'Home', false),
            _buildNavItem(Icons.receipt_long, 'Orders', false),
            _buildNavItem(Icons.local_offer, 'Offers', true),
            _buildNavItem(Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B),
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
