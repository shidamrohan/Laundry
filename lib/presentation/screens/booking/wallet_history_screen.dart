import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/filter_transactions_bottom_sheet.dart';
import 'package:laundry/presentation/screens/booking/transaction_details_screen.dart';

class WalletHistoryScreen extends StatefulWidget {
  final bool isEmpty;
  final bool isOffline;

  const WalletHistoryScreen({
    super.key,
    this.isEmpty = false, // Set to true to test empty state
    this.isOffline = false, // Set to true to test offline state
  });

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = ['All', 'Added', 'Spent', 'Refunds', 'Expired'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Space for header + tabs
                SliverToBoxAdapter(child: SizedBox(height: topPadding + 64 + 56)),

                // Filter chips + result count (hide if empty)
                if (!widget.isEmpty) SliverToBoxAdapter(child: _buildFilterRow(context)),

                // Transaction groups or Empty State
                if (widget.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 256,
                            height: 256,
                            decoration: const BoxDecoration(
                              color: Color(0x0D0EA5A4), // primary/5
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0x33FFFFFF),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Image.network(
                                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAGFBmITlkQgn0K2UjIbmFw9w9Y_q89zU9sh9oeSiz-Ffz-O_Fw4FjKVc8PaZgWSKdqUgxg3uRx5I5ziEBPG7arLrEkEFHLYI_2CzdikIbdbvdNl9hCQcLdGtTfjVPVe58nmr5SfoT5U3u3AtDULXgib97Gy63Tw2-lYrDLbt5FCMtAaFAMnXMmLhUA_CzAMIFUmoBlBgf1CvSdR5l2IGzX1W0ymJfa9WOj6TW-NlGOXef5mNjUMr9MdzpSqDOyjAI3u3vp8COCMi1s',
                                  width: 192,
                                  height: 192,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_balance_wallet, size: 64, color: Color(0xFF0EA5A4)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'No transactions yet',
                            style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Add money or place an order to see your wallet activity here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF64748B), fontSize: 15, height: 1.5),
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add, size: 20),
                            label: const Text('Add money', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0EA5A4),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 8,
                              shadowColor: const Color(0x330EA5A4),
                            ),
                          ),
                          const SizedBox(height: 64),
                        ],
                      ),
                    ),
                  )
                else
                  SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    child: Column(
                      children: [
                        _buildDateGroup('Today', [
                          _buildStandardCard(
                            icon: Icons.account_balance_wallet,
                            iconBgColor: const Color(0x1A16A34A),
                            iconColor: const Color(0xFF16A34A),
                            title: 'Added to Wallet',
                            subtitle: 'UPI • Google Pay',
                            amount: '+₹200',
                            amountColor: const Color(0xFF16A34A),
                            badgeLabel: 'Success',
                            badgeColor: const Color(0xFF16A34A),
                            badgeBg: const Color(0x1A16A34A),
                            ref: 'Ref #TXN8829',
                            time: '10:30 AM',
                          ),
                          _buildExpandedCard(),
                        ]),
                        const SizedBox(height: 24),
                        _buildDateGroup('Yesterday', [
                          _buildStandardCard(
                            icon: Icons.assignment_return,
                            iconBgColor: const Color(0x1A2563EB),
                            iconColor: const Color(0xFF2563EB),
                            title: 'Refund Issued',
                            subtitle: 'Cancellation: Item missing',
                            amount: '+₹150 refund',
                            amountColor: const Color(0xFF2563EB),
                            badgeLabel: 'Refunded',
                            badgeColor: const Color(0xFF2563EB),
                            badgeBg: const Color(0x1A2563EB),
                            ref: 'Order #ORIO1038',
                            time: '04:20 PM',
                          ),
                          _buildStandardCard(
                            icon: Icons.military_tech,
                            iconBgColor: const Color(0x1AF59E0B),
                            iconColor: const Color(0xFFF59E0B),
                            title: 'Reward Credits',
                            subtitle: 'Referral Bonus: Rahul V.',
                            amount: '+50 pts reward',
                            amountColor: const Color(0xFFF59E0B),
                            badgeLabel: 'Success',
                            badgeColor: const Color(0xFF16A34A),
                            badgeBg: const Color(0x1A16A34A),
                            ref: 'Ref #REF009',
                            time: '11:00 AM',
                          ),
                        ]),
                        const SizedBox(height: 24),
                        _buildDateGroup('Jul 18', [
                          _buildStandardCard(
                            icon: Icons.iron,
                            iconBgColor: const Color(0x1ADC2626),
                            iconColor: const Color(0xFFDC2626),
                            title: 'Spent on Order',
                            subtitle: 'Wash & Iron',
                            amount: '−₹320',
                            amountColor: const Color(0xFFDC2626),
                            badgeLabel: 'Success',
                            badgeColor: const Color(0xFF16A34A),
                            badgeBg: const Color(0x1A16A34A),
                            ref: 'Order #ORIO1022',
                            time: '02:10 PM',
                          ),
                          _buildStandardCard(
                            icon: Icons.timer_off,
                            iconBgColor: const Color(0x1464748B),
                            iconColor: const Color(0xFF64748B),
                            title: 'Expired Points',
                            subtitle: 'Promo rewards cleanup',
                            amount: '−10 pts',
                            amountColor: const Color(0xFF64748B),
                            badgeLabel: 'Expired',
                            badgeColor: const Color(0xFF64748B),
                            badgeBg: const Color(0xFFE2E8E9),
                            ref: 'Ref #EXP11',
                            time: '12:00 AM',
                            isExpired: true,
                          ),
                        ]),
                        const SizedBox(height: 24),
                        _buildLoadingSkeleton(),
                      ],
                    ),
                  ),
                ),

                // Bottom nav spacing
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            ),
          ),

          // Fixed header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),

          // Offline Banner
          if (widget.isOffline)
            Positioned(
              bottom: 100, // Above bottom nav
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E6),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0x33F59E0B)),
                    boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.cloud_off, color: Color(0xFFF59E0B), size: 18),
                      const SizedBox(width: 8),
                      const Text(
                        "You're offline — pull to refresh",
                        style: TextStyle(color: Color(0xFFF59E0B), fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.refresh, color: Color(0xFFF59E0B), size: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Fixed bottom nav
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HEADER ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: topPadding),
          child: Container(
            height: 64,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
                ),
                const SizedBox(width: 4),
                const Expanded(
                  child: Text('Transactions', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, color: Color(0xFF0F172A)),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, color: Color(0xFF0F172A)),
                ),
              ],
            ),
          ),
        ),
        // Tab bar
        Container(
          color: Colors.white,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
          ),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: const Color(0xFF0EA5A4),
            indicatorWeight: 3,
            labelColor: const Color(0xFF0EA5A4),
            unselectedLabelColor: const Color(0xFF64748B),
            labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            tabs: _tabs.map((t) => Tab(text: t)).toList(),
          ),
        ),
      ],
    );
  }

  // ─────────────────────── FILTER ROW ───────────────────────

  Widget _buildFilterRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          _buildFilterChip(context, 'Last 30 days'),
          const SizedBox(width: 8),
          _buildFilterChip(context, 'All types'),
          const Spacer(),
          const Text('42 results', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
    return GestureDetector(
      onTap: () => FilterTransactionsBottomSheet.show(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFE2E8E9)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0F172A), size: 18),
          ],
        ),
      ),
    );
  }

  // ─────────────────────── DATE GROUP ───────────────────────

  Widget _buildDateGroup(String dateLabel, List<Widget> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            dateLabel.toUpperCase(),
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
        ),
        ...cards.map((c) => Padding(padding: const EdgeInsets.only(bottom: 12), child: c)),
      ],
    );
  }

  // ─────────────────────── STANDARD CARD ───────────────────────

  Widget _buildStandardCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
    required String badgeLabel,
    required Color badgeColor,
    required Color badgeBg,
    required String ref,
    required String time,
    bool isExpired = false,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionDetailsScreen())),
      child: Opacity(
        opacity: isExpired ? 0.75 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x80E2E8E9)),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(amount, style: TextStyle(color: amountColor, fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(30)),
                        child: Text(badgeLabel.toUpperCase(), style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Color(0x80E2E8E9), height: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(ref, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500)),
                  Text(time, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────── EXPANDED CARD ───────────────────────

  Widget _buildExpandedCard() {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionDetailsScreen())),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: const Border(
            left: BorderSide(color: Color(0xFFDC2626), width: 4),
            top: BorderSide(color: Color(0xFFE2E8E9)),
            right: BorderSide(color: Color(0xFFE2E8E9)),
            bottom: BorderSide(color: Color(0xFFE2E8E9)),
          ),
          boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: const BoxDecoration(color: Color(0x1ADC2626), shape: BoxShape.circle),
                  child: const Icon(Icons.local_laundry_service, color: Color(0xFFDC2626), size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order Payment', style: TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Text('Premium Wash & Fold', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('−₹844', style: TextStyle(color: Color(0xFFDC2626), fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: const Color(0x1A16A34A), borderRadius: BorderRadius.circular(30)),
                      child: const Text('SUCCESS', style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Detail panel
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Payment Method', 'HDFC Bank •••• 4242'),
                  const SizedBox(height: 8),
                  _buildDetailRow('Transaction ID', '129384756'),
                  const SizedBox(height: 8),
                  _buildDetailRow('Order Reference', 'Order #ORIO1042'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Detailed invoice sent to email', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontStyle: FontStyle.italic)),
                Text('09:15 AM', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
        Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ─────────────────────── LOADING SKELETON ───────────────────────

  Widget _buildLoadingSkeleton() {
    return Column(
      children: [
        _buildSkeletonCard(),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: const Color(0xFF0EA5A4),
                backgroundColor: const Color(0xFFE2E8E9),
                strokeWidth: 2.5,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Loading history...', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x4DE2E8E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: const BoxDecoration(color: Color(0x66E2E8E9), shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 12, width: double.infinity * 0.4, decoration: BoxDecoration(color: const Color(0x66E2E8E9), borderRadius: BorderRadius.circular(6))),
                const SizedBox(height: 8),
                Container(height: 10, width: 120, decoration: BoxDecoration(color: const Color(0x66E2E8E9), borderRadius: BorderRadius.circular(6))),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(height: 20, width: 48, decoration: BoxDecoration(color: const Color(0x66E2E8E9), borderRadius: BorderRadius.circular(30))),
        ],
      ),
    );
  }

  // ─────────────────────── BOTTOM NAV ───────────────────────

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, -2))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home', false),
            _buildNavItem(Icons.local_laundry_service_outlined, Icons.local_laundry_service, 'Orders', false),
            _buildNavItem(Icons.account_balance_wallet_outlined, Icons.account_balance_wallet, 'Wallet', true),
            _buildNavItem(Icons.person_outline, Icons.person, 'Account', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData outlinedIcon, IconData filledIcon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(isActive ? filledIcon : outlinedIcon, color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 10, fontWeight: isActive ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
