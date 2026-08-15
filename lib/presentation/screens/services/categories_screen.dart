import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/services/all_services_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const List<Map<String, dynamic>> _categories = [
    {
      'name': 'Everyday Wear',
      'price': 'From ₹49',
      'count': '12 items',
      'badge': 'Popular',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBxFatzjsBt5GSRZ4YIxq_cRowNDi40n28YofYFc1Gj-1wZMQuodJcdlnrOAuAypzwBzt-7iqvNUeB7DKdUOCzxP4lc-iK_e7xH90PCBP29BIu2v7q2s9cYjpoWCBN0weS7jGeqpyNdkP8-LvqHM1zrKQuzXYFGldIV6RjnNXMlnzWQJmn1tkQlUlXkGfuxG9gN6igwdyQsB-HCSrMOyW4Fhzk1s0Zttr0qVakC5L-JmYagpINxTXrMZjrK8jEpbqeSbZVzBuOpjVWg',
    },
    {
      'name': 'Formal Wear',
      'price': 'From ₹129',
      'count': '8 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDJeKhF6czFethGKf82Kerv1UwyTRsRsPClzYrMnNXf17ORP8h91DSD6JQQFlPeb_yPtuQsP-Di_4N84jlfGjcU8tfoqbtzNyIndTMLVpYTrXRp85UAU5SMG8euji8kIfjekvqJtqRcErVQYnSry_gPSLmbARzlCyMRcuvIQ-sz4qpwnarMccTPSBy7sFnS4f4wKJ2wHCI1PfX_aPodstaTsGzIJ75Ni1vOx32rI5FfSLTDBHBvXePkm_Wi8fxzkqj49fwwypwBFqUo',
    },
    {
      'name': 'Premium Garments',
      'price': 'From ₹249',
      'count': '15 items',
      'badge': 'Popular',
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBqOJgEB2_HiB5Mz-HNWN9Dl2Nq_mxV6C9JdrRjImMRKur6kCywu1a9A3biFyfXMnuA4MqWY7-5UOjQHkl7DO8TWypeeoO6Z6iB3G3s7OH5X_aI7Q0lWzYndPHXfBPrIAdrF8dpNgkRVXL5LTiCZn7DVN0e0Xb2znVNsMvUtdK751kQuoP1LFT0einUrrI1tUnPNPQCPbOddvG2j9HbnQ-slt7YVDJU_lLi9a-UEkOT5rcPvztv8aYtOA9HDxLg0Z8C316hLUqYFNHI',
    },
    {
      'name': 'Shoes',
      'price': 'From ₹199',
      'count': '6 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCyNKw2dhIe4tWjYP0G7-8pmLK2PVKMCJak8s9CxyCmao7SYkFR9wP0Zufvnu1GK6yk6lKJXAtwjsR3D9rc2ZtctdziTR2er8XctJ6uDYuDIcJpaKONgQqf261rr_0UZow4puZR9es_5hRPD7myM7GO3FtzKIswGn1gweg_qPt3doBh5zRxLAO7B2S32t136sVP7pmv2vYJ54dTfkpDLhTxHKzhKXo1b3HB9cXEFovNGB8K6wm7cmV6jl64LQ0oWxxqxbCkvl2EZi-N',
    },
    {
      'name': 'Curtains',
      'price': 'From ₹149',
      'count': '4 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDGLuJWsvAdqt8w7-A5oBmhUedbq8zNPuu-gg39HOKzDZrkuPKWN6qTBI9xUzI13TqNkwAaTqj3qk43ta16N6ZVzCpiqXyjsjHKXLS6KMt6tBNOctHWxI6o3UYk2H9WO8r6GvacPResF2D84cGMytp4ZnykTiOhdTZIzUkErpF0rDFCaUFHNY1nbO1Z_FtOHpQTrM2K0zIz4jUTskEM8q1nknOB_e9PU6fB8lZMyk5PIN9iVGri85HdKq-ZA-ylPXqLVJ1BxWhoAsF_',
    },
    {
      'name': 'Blankets',
      'price': 'From ₹299',
      'count': '5 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAzspFtkCHjY2p7uXmKfIEM-kLvzLTdr1sddrpmKVtMbW0Mk3XtuiDav2HBIZoNLpg0hXhs8N-gIJ7MTD8wY0G5MW8stms1598dk3ufizm9fIxK6wEZHVKH1i7TBgw4UwEwOSznWtjXO8owGrPKA3gh6BkH-j2K8FDp_1zFSrzOml5bSCOiyvYRmjfUzpnbmirKgkNJNE1vkz5gVjRmNzmJ9fITEXyHEdP4u8B5LSZREETziAfU4f1N5GKHi-gTKS2MQxHXO-GpkH5u',
    },
    {
      'name': 'Carpets',
      'price': 'From ₹499',
      'count': '3 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDhlvW7HrI13OsIf9s-pG8ykA_Vq1OUTYQeHm-izvZBEgfXXV5ynuacKLBKv9u5vuS4ARJLlLbmkheB6PDlSrPlWjaCX6gtME6LJjgf21u4gK-33Tk63LvwRLU-83bSySBR-Qz6N-9NXij5439jXHxyR_NIKSXWwotEmN93oMQYB1MzPWuPqxTrZpwBeZPOqM2TYNAU5dbj_h_RB5ypyFGXG3qSysYSrqZf-kKPZUjIlRqfciA9ImqHM8lNAV9vG9qObjOZnCCwb4VH',
    },
    {
      'name': 'Bags',
      'price': 'From ₹159',
      'count': '7 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDVRgbKscakvIntE5_jelxmq44uXi0-wRL1Plvk-KGcACwD2OYMWcB52vk2rx4k-s4f1I1p2iPEeTFtjJ45zx8C7XzhqKE-TEQCJPxGQrtHo-MjJcokHxf7LQcSiBGxn0Rf5a5dmHF9xtJ7OIWwAU6w5eyJPttndowdR_wOx6l1Rey24pDuozA9zTtL89XZCfPQICoVEO9sykfZc3paxXp74PHKTTduoEmwlHM6RIHelkeIksH9AKyUoaTgo2WOGKPHZDQA50lt35G8',
    },
    {
      'name': 'Delicate Fabrics',
      'price': 'From ₹179',
      'count': '9 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuCIDRq7gD2JYC7ircxpjySw4d3PC9Iw5ZARhfsoRuC4MtMTPIjhqh7STcn5xWCXLqy6uB_65L6SxHUFzRVp0cO93eDOyhSX7D98zBGGP41pWCJc07-lPGbqoh6QwUSYAa_2HKWKesltN528LX0YAylkELd0H3BVOTKRPQFZJlhSRubHS5i04HfwKWV4K55J6XMSAQ4RV0yYwFXCdnjVGhjeMO8pilxU6c5v0E-d1i60RaLGLLePfibFdC7hOUf4N8nt5gTVT581SZCw',
    },
    {
      'name': 'Wedding Wear',
      'price': 'From ₹1499',
      'count': '2 items',
      'badge': null,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVP-YYmtKc1iIWLdZi8C5lF4z7aK1c1HLIkRl4eFS_ryfRRqxmwoQ0SjxiaADfIisF7UDNnYhFDYI7vMs0_mhCsZ9RaQQYNoAV-IVgmyqflcdFI9RfGLY85bHYzxY2GCfaABpdny4DUgutxRapUXtPeMa5LAWq0HP9XT6iPvbgi1QmfOq65OtDE5RJ7-K3i4UniLTVrFe_jV3PfYuE2CJV9b8qZ0ZGHZ9VVh9cFkR3OlTMh8S6m8kIvGepqF2uR5xHVrK660_u5DcS',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          // ── FIXED HEADER ──
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(8, topPadding + 4, 8, 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0x33E2E8E9))),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4), size: 24),
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      color: Color(0xFF0EA5A4),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    child: const Icon(Icons.search, color: Color(0xFF0EA5A4), size: 24),
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),

          // ── BODY ──
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Intro text
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Text(
                      'Browse by what you need cleaned',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Category grid
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding + 24),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => _buildCategoryCard(context, i),
                      childCount: _categories.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.9,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, int i) {
    final cat = _categories[i];
    final hasBadge = cat['badge'] != null;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AllServicesScreen()),
      ),
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Card content
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circle image
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFEFF6F6),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: ClipOval(
                        child: Image.network(
                          cat['image'] as String,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.local_laundry_service,
                            color: Color(0xFF0EA5A4),
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Name
                    Text(
                      cat['name'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF0F172A),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Price
                    Text(
                      cat['price'] as String,
                      style: const TextStyle(
                        color: Color(0xFF0EA5A4),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Item count
                    Text(
                      cat['count'] as String,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // Popular badge
              if (hasBadge)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0EA5A4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      (cat['badge'] as String).toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF0EA5A4),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
