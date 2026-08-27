import 'package:flutter/material.dart';
import 'package:laundry/presentation/widgets/skeleton_loader.dart';
import 'package:laundry/presentation/screens/booking/select_location_screen.dart';
import 'package:laundry/presentation/screens/services/all_services_screen.dart';
import 'package:laundry/presentation/screens/services/categories_screen.dart';
import 'package:laundry/presentation/screens/services/select_service_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedAddressTag = 'Home';
  String _selectedAddressString = '21 Brigade Road, Shanthala Nagar, Bengaluru...';

  final int _currentBanner = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  final List<Map<String, dynamic>> _services = [
    {'icon': Icons.local_laundry_service, 'label': 'Wash & Fold'},
    {'icon': Icons.dry_cleaning, 'label': 'Dry Cleaning'},
    {'icon': Icons.iron, 'label': 'Ironing'},
    {'icon': Icons.star_outline, 'label': 'Premium Care'},
    {'icon': Icons.ice_skating, 'label': 'Shoes'},
    {'icon': Icons.curtains, 'label': 'Curtains'},
    {'icon': Icons.bed_outlined, 'label': 'Blankets'},
    {'icon': Icons.bolt, 'label': 'Express'},
  ];

  final List<Map<String, dynamic>> _bundles = [
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCwIoaltRt6QgIUPiYeRq91vTfN1GTPB3kR4jUVmWO0A1lJWaSfI1lqDsp-8s-uUpF8SuYYDDnZoTRU1ggm3OtF761Xuv-ta88YYMw1VkJACf0VJ9x8VZ9c-ipFodvDKIeC_r4kRoOsGLIlxE-Jghp9Kj3OwVmkwo35sZLgATTOqt8Rap-Nkph74-MU0MeheM_80FepB1fb198FmzrWHZ61Fl7vBWTyL-DyUYkIOrhNRRiPrTro7xpxt_1Oi7wampTqwlrz4FgyuJQZ',
      'rating': '4.8',
      'name': "Bachelor's Pack",
      'delivery': '24h Delivery',
      'price': '₹499',
    },
    {
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDxvrxdt4PszQIqttsF4hpHdl1I4pCqCj4TMdahffJaW73uvkFRd5d-l2uNHIkd-p51Od-A8mhu8Cl_Sv-PD8n2ffcfYZ5O4tD507ZWeTvERdtBu1cLf1cpRVU_z6QP205vzdjTidiblUTyUIp0-TqowYHL2mL194R-rhp25Sk0jzJq3vfzXymL6BfbrbPu67hqXn9cYUYO6axi5xM_A7ekXRtSQy59OkJmJXPt0eMl7U-xBuB-MzmAyznQXBDZ-pb4xdMSib8cAXVM',
      'rating': '4.9',
      'name': 'Family Load (5kg)',
      'delivery': 'Next Day',
      'price': '₹899',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // --- SCROLLABLE CONTENT ---
          _isLoading 
            ? const Positioned.fill(child: HomeSkeletonLoader())
            : CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Top space for header
              SliverToBoxAdapter(child: SizedBox(height: topPadding + 72)),

              // --- SEARCH BAR ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: _buildSearchBar(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              // --- HERO BANNER ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildHeroBanner(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // --- SERVICES GRID ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildServicesGrid(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // --- POPULAR BUNDLES ---
              SliverToBoxAdapter(
                child: _buildPopularBundles(),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // --- VOSHIFY PLUS BANNER ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildVOSHIFYPlus(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // --- RECENT ORDER ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildRecentOrder(),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 80)),
            ],
          ),

          // --- FIXED HEADER ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(topPadding),
          ),
        ],
      ),

    );
  }

  // ─────────────────────────────── WIDGETS ────────────────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: const Color(0xFFF7FAFB),
      padding: EdgeInsets.fromLTRB(16, topPadding + 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Zomato/Swiggy Style Address Bar
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectLocationScreen()),
                );
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    _selectedAddressTag = result['tag'];
                    _selectedAddressString = result['address'];
                  });
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF0EA5A4), size: 24),
                      const SizedBox(width: 4),
                      Text(
                        _selectedAddressTag,
                        style: const TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0F172A), size: 24),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      _selectedAddressString,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right side actions: Profile / Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0EA5A4).withValues(alpha: 0.2),
                  blurRadius: 12,
                )
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'AK',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9)),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.search, color: Color(0xFF64748B), size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for services…',
                hintStyle: TextStyle(color: Color(0xFF64748B), fontSize: 15),
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Icon(Icons.mic_none, color: const Color(0xFF64748B), size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 192,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0EA5A4).withValues(alpha: 0.15),
            blurRadius: 24,
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          // Blur orbs
          Positioned(
            top: 16, left: 40,
            child: Container(
              width: 96, height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: 16, right: 40,
            child: Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),

          // Bubble icon decoration
          Positioned(
            right: -8, bottom: -8,
            child: Icon(Icons.bubble_chart, size: 80, color: Colors.white.withValues(alpha: 0.3)),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Same-Day\nDelivery',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Free pickup on your first order',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SelectServiceScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0EA5A4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 4,
                  ),
                  child: const Text('Order now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ],
            ),
          ),

          // Indicators
          Positioned(
            bottom: 12,
            left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: i == _currentBanner ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: i == _currentBanner ? 1.0 : 0.4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Our Services',
              style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoriesScreen()),
              ),
              child: const Text('See all',
                  style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: _services.length,
          itemBuilder: (context, i) {
            return _buildServiceItem(_services[i]['icon'] as IconData, _services[i]['label'] as String);
          },
        ),
      ],
    );
  }

  Widget _buildServiceItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AllServicesScreen()),
      ),
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8E9)),
                ),
                child: Icon(icon, color: const Color(0xFF0EA5A4), size: 28),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularBundles() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Popular Bundles',
                  style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: const Text('View all',
                    style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _bundles.length,
            itemBuilder: (context, i) {
              final b = _bundles[i];
              return _buildBundleCard(
                imageUrl: b['image'] as String,
                rating: b['rating'] as String,
                name: b['name'] as String,
                delivery: b['delivery'] as String,
                price: b['price'] as String,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBundleCard({
    required String imageUrl,
    required String rating,
    required String name,
    required String delivery,
    required String price,
  }) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8E9)),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 110,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: const Color(0xFFE2E8E9),
                    child: const Icon(Icons.image_not_supported_outlined, color: Color(0xFF334155)),
                  ),
                ),
                // Rating badge
                Positioned(
                  top: 8, right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Color(0xFFFBBF24), size: 12),
                        const SizedBox(width: 3),
                        Text(rating,
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(delivery, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price, style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 18, fontWeight: FontWeight.w800)),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0EA5A4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        elevation: 0,
                      ),
                      child: const Text('Book', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVOSHIFYPlus() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: 0.25), blurRadius: 20)
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: -16, top: -16,
            child: Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.workspace_premium, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text('VOSHIFY Plus', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Save 20% on every order',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF7C3AED),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 4,
                ),
                child: const Text('Explore', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentOrder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Order',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8E9)),
          ),
          child: Row(
            children: [
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_laundry_service, color: Color(0xFF0EA5A4), size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Wash & Fold',
                        style: TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('8 Items • Completed on Mon',
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0EA5A4),
                  side: const BorderSide(color: Color(0xFF0EA5A4), width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Reorder',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


