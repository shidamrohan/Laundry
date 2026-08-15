import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/location/address_selection_screen.dart';
import 'package:laundry/presentation/screens/services/item_customization_bottom_sheet.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  bool _isFavorite = false;
  bool _isIncludedExpanded = true;
  final Set<String> _expandedFaqs = {};

  final List<Map<String, String>> _faqs = [
    {
      'id': 'faq1',
      'question': 'How do you handle delicate lace?',
      'answer': 'We use a specific low-temperature cycle and protective mesh bags for all intricate details.',
    },
    {
      'id': 'faq2',
      'question': 'Can you remove old wine stains?',
      'answer': 'Yes, our chemical stain-lifting process is highly effective even on aged stains, though results vary by fabric.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // ── MAIN CONTENT ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── HERO IMAGE ──
              SliverToBoxAdapter(child: _buildHeroSection()),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── TITLE & STATS ──
                      _buildTitleSection(),
                      const SizedBox(height: 24),

                      // ── BEFORE / AFTER ──
                      _buildBeforeAfterSection(),
                      const SizedBox(height: 24),

                      // ── WHAT'S INCLUDED ──
                      _buildIncludedSection(),
                      const SizedBox(height: 24),

                      // ── FAQS ──
                      _buildFaqSection(),
                      const SizedBox(height: 24),

                      // ── REVIEWS ──
                      _buildReviewsSection(),
                      const SizedBox(height: 24),

                      // ── SIMILAR SERVICES ──
                      _buildSimilarServicesSection(),

                      // Bottom spacing for sticky bar
                      SizedBox(height: bottomPadding + 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── TOP OVERLAY NAV ──
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCircleNavBtn(
                  icon: Icons.chevron_left,
                  onTap: () => Navigator.pop(context),
                ),
                _buildCircleNavBtn(
                  icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                  iconColor: _isFavorite ? const Color(0xFFDC2626) : const Color(0xFF0F172A),
                  onTap: () => setState(() => _isFavorite = !_isFavorite),
                ),
              ],
            ),
          ),

          // ── STICKY BOTTOM BAR ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(bottomPadding),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HERO ───────────────────────

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x140F172A), // shadow-e2
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuB0fs6b-U8VKDm7PeZxH1QVgJimTg4IN7kWQLc9c3v2SSeXtwycJsuyD5V1FF4wZT25oxmQ_JnKV378Y2yLmePj45hfMa_yF2gfYAStuXPeF-T7Cd6wpnnl9wAfOnHSuL-w0ibX4vO12yaNHEVwuJ4pQcotAfyMa1utA7AMx8YGdWTPGj9lirs2BVPTghQyy3sMLEZlQa8dHQgpC63SAQF1pRDa84SknTthaMnrAQROFBJTKqP1_WsKhmh3GZtlTjagUPc_S7Ju2wIO',
            fit: BoxFit.cover,
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black.withOpacity(0.4), Colors.transparent],
              ),
            ),
          ),
          // Gallery Dots
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleNavBtn({required IconData icon, Color iconColor = const Color(0xFF0F172A), required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Icon(icon, color: iconColor, size: 26),
      ),
    );
  }

  // ─────────────────────── TITLE ───────────────────────

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Dry Cleaning',
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.verified, color: Color(0xFF0EA5A4), size: 14),
                  SizedBox(width: 4),
                  Text('Premium Care',
                      style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 11, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.star, color: Color(0xFFF59E0B), size: 18),
            const SizedBox(width: 4),
            const Text('4.8', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            const Text('(1,240 reviews)', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
            const SizedBox(width: 12),
            Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFFE2E8E9), shape: BoxShape.circle)),
            const SizedBox(width: 12),
            const Icon(Icons.schedule, color: Color(0xFF0EA5A4), size: 18),
            const SizedBox(width: 4),
            const Text('24h turnaround', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: const [
            Text('₹99', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 26, fontWeight: FontWeight.w800)),
            SizedBox(width: 8),
            Text('per garment', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Our master cleaners use eco-friendly solvents and advanced tensioning equipment to restore your garments to their pristine, original finish. Ideal for delicate silks, wools, and tailored suits.',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.5),
        ),
      ],
    );
  }

  // ─────────────────────── BEFORE / AFTER ───────────────────────

  Widget _buildBeforeAfterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Results You Can See', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                        image: const DecorationImage(
                          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDhLlrVn_NmVTCgpBmbMs-O-xN0wLvRbPm-enE_fOfcGHHW10eM7hIz5xEgvETI-yISbwmS10WziLdesvm26bDYjZQtqV37jiEFwW3Xa6yg2W-Sqjrn6JcnqA8Z9Tdlz_q5sa4dSS--LtUAa4WduHFXMO_OIRcCUsFI-er-ejtRNfkWaKjYT4xSikfaQCHs9zV9ay5NvzP-PWhQ4tRxwvT0jQIZmQxvdwRByLL7n0pbM03Hq8y1SM7JbmJRFDMSyKyLIu72GvbMwVFT'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('BEFORE', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF0EA5A4).withOpacity(0.3), width: 2),
                        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                        image: const DecorationImage(
                          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuB1SY2vnSJldY6EhXWNBpwRwidlh8f55qz0H427R-QQoF05Z2yOoERZM_-B-oCLxiQHx8gI0Vw405Nv6Znk2B7vf7GcX4YOkw371Zu22a8xcxOdFJtkQJljYgMLv72OXyeODmk9itmqbwT5dI8NPLwELwmrraKCcY1ms-bxqzDgf797HtgWyYcPOW0AEcDumpUXSbz9Kgh4NJU_UVU23CO0jNctVH3Ks3IoAB3gf3rbe3NDOY9FwghMRrbPwvstwindI--soxeOvOnK'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('AFTER', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ─────────────────────── INCLUDED ───────────────────────

  Widget _buildIncludedSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _isIncludedExpanded = !_isIncludedExpanded),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("What's included", style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                  AnimatedRotation(
                    turns: _isIncludedExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: const Icon(Icons.expand_more, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  _buildIncludedItem('Pre-treatment for all visible stains'),
                  const SizedBox(height: 12),
                  _buildIncludedItem('Professional steam pressing for crisp finish'),
                  const SizedBox(height: 12),
                  _buildIncludedItem('Fabric-specific nutrient restoration'),
                  const SizedBox(height: 12),
                  _buildIncludedItem('Biodegradable solvent cleaning'),
                ],
              ),
            ),
            crossFadeState: _isIncludedExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 280),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: Color(0xFF0EA5A4), size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14))),
      ],
    );
  }

  // ─────────────────────── FAQS ───────────────────────

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text('Common Questions', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        ..._faqs.map((faq) {
          final isExpanded = _expandedFaqs.contains(faq['id']);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8E9)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      isExpanded ? _expandedFaqs.remove(faq['id']) : _expandedFaqs.add(faq['id']!);
                    }),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(faq['question']!, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600))),
                          AnimatedRotation(
                            turns: isExpanded ? 0.125 : 0, // 45 deg = 0.125 turn (turns + to x)
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.add, color: Color(0xFF64748B), size: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox(width: double.infinity, height: 0),
                    secondChild: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(faq['answer']!, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.4)),
                    ),
                    crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 250),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  // ─────────────────────── REVIEWS ───────────────────────

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Customer feedback', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: const Text('View all', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            children: [
              _buildReviewCard(
                name: 'Ananya R.',
                img: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBfy4MctGMgrWGmXhspsuWwGfppirxyd_UYIzAaStSHFWSQd6xS7-L33SPRiSb6bPfr0hlN3e7HqP-UbyXIsc-Okl2cAgLe5yyoRlCkxPtIsE4Ear2Y8Doh-Bg-HZFu9F9oH_gXzSsSG7zv9IZijL3osq2a-Y6AskOKT-m5CgZcpg1tfNN79IkJPMphnK0Fz4uNvG0sD2tPB8DU1kMiKVTrsFxxaJpiURO7PAC0UeGaRpzx6IlSdFNUbCJEe906DDSKdcf48PoTJHzy',
                rating: 5,
                text: '"My silk saree came back looking brand new. The packaging was also very premium!"',
              ),
              const SizedBox(width: 16),
              _buildReviewCard(
                name: 'Vikram M.',
                img: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC88PpQSpGsMyahlO9_EBw3CDrCqrTUZDYfBaDFSsSt3jXLYPRDE_5PLge6LpSOHXoQyJS8fXTAhWkn5OEw3WIGrvWu-j38lNXxfvxga7Yvr7rkZLaKW9AbkFqxkzjLx2IH2l8kmXz0xYHQaJDq6UvKRxCOZxGxFw4IlntwdoSjVJT1ILYo1Ef1etqXdzVPeLU19Ub9F_p_Fu7lk6PZvjT_aLgO5dgSenmMHOfjSvodo4TpKeweyRyWzn7kDu2mKT3z9MuT94-nxr1q',
                rating: 4,
                text: '"Best dry cleaning service in the city. Fast pickup and delivery as promised."',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard({required String name, required String img, required int rating, required String text}) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20, backgroundImage: NetworkImage(img), backgroundColor: const Color(0xFFE2E8E9)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Row(
                    children: List.generate(5, (i) => Icon(
                      i < rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFFF59E0B),
                      size: 14,
                    )),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(text, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  // ─────────────────────── SIMILAR ───────────────────────

  Widget _buildSimilarServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text('You might also need', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            children: [
              _buildSimilarCard(title: 'Wash & Fold', price: 'From ₹49/kg', icon: Icons.local_laundry_service),
              const SizedBox(width: 16),
              _buildSimilarCard(title: 'Ironing Only', price: 'From ₹19/pc', icon: Icons.iron),
              const SizedBox(width: 16),
              _buildSimilarCard(title: 'Shoe Polish', price: 'From ₹79/pr', icon: Icons.checkroom),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimilarCard({required String title, required String price, required IconData icon}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 76,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF0EA5A4), size: 36),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(price, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── BOTTOM BAR ───────────────────────

  Widget _buildBottomBar(double bottomPadding) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: const Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 20, offset: Offset(0, -10))],
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, bottomPadding + 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('TOTAL', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
              Text('₹99', style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ItemCustomizationBottomSheet.show(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFF6F6),
                  foregroundColor: const Color(0xFF0EA5A4),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text('Add to Cart', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressSelectionScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A4),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: const Color(0xFF0EA5A4).withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                child: const Text('Book Pickup', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
