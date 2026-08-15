import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/services/item_customization_bottom_sheet.dart';
import 'package:laundry/presentation/screens/booking/basket_screen.dart';

class AddGarmentsScreen extends StatefulWidget {
  final String serviceName;
  
  const AddGarmentsScreen({
    super.key,
    this.serviceName = 'Wash & Fold',
  });

  @override
  State<AddGarmentsScreen> createState() => _AddGarmentsScreenState();
}

class _AddGarmentsScreenState extends State<AddGarmentsScreen> {
  int _selectedCategoryIndex = 0;
  
  final List<String> _categories = [
    'Shirts', 'T-Shirts', 'Jeans', 'Trousers', 'Sarees', 'Suits', 'Jackets'
  ];

  final List<Map<String, dynamic>> _garments = [
    {
      'name': 'Shirt',
      'desc': 'Cotton · Gentle wash',
      'price': 49,
      'badge': 'EXPRESS',
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLuAZHx67I8s-ApIAeKA0fUDm_-C8l9GEY_tNZ5u8KAYsj3pmBNEYLy9lwCBLc30j0nE1w4sUq-pb7L5yylwQtxUrXW6zjCMWisCxmE02IK4Rz8vM9ge83KKDMMXVvI0ASPmPJIwI-e9_utFaI1VSowFM1ukNnCdSldwQspOyLJb6YvKzicNMxLoCvNoKhu-Z0VfYpUc22o7Xm2HeMgFVDOcaUF4Fg8jER0dq0nJm2un41ovpzGhYOR39i1w',
      'qty': 2,
    },
    {
      'name': 'T-Shirt',
      'desc': 'Cotton · Everyday wear',
      'price': 39,
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLveTERVcjmQlRoCzd9OLsNqgsEUA1h4ItpMBPOirxe6XsTkeU3-lJ5-GxU-rQCklXdA3Y7wR4D70fmGDkSmLWINKkoFI2Qae8x6hCJuQ99L7O_SO3jaopEdJbSJsQvgUaAPHtAHqwC5SzJPyfFG0RyquNluMQeQbgEo8YyU4dziVT7suijnCo3BHsaIa7EAHAfS3KKtt5MMkvsKMFhf1Xyv3KWV9-XJNMQj8kssS2KThHpNBwiBMRJLHx7x',
      'qty': 0,
    },
    {
      'name': 'Jeans',
      'desc': 'Denim · Heavy duty',
      'price': 79,
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLujUXY3TPStyHunNJTcgCz6J3SN3St2OHln6fCrANvcdxicocBJpMlITMSRid7iWinSlZkn_krk45NLP-s9OW16mhCi2LFprrVZ3fifyxgJeMjRbjmFC1OTDIoV_sXA0IGHFiihCVlayacsqwzrSOIX9gsfbfyG1kPrjUHCeBci9eugA2QW9khTFfRqmjNQZVX6kz_QFUDtJqAA4EUqrmBpaaZxBiOR24iqVSIQywUIkKdNyWyAz0knhNQ',
      'qty': 1,
    },
    {
      'name': 'Saree',
      'desc': 'Silk · Premium care',
      'price': 199,
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLvPd37TyzUaJdYrLXK_MzAtdbZAe8tPlLXCDo8Hvcbd4To2B0LwfUpbaWdUHJk6Q5eHWH1BScpUfny6nRyXUF1basobc-BNixVBVHYXIwspg_VJjQ_FReNRuUsYGYkHRCk6KjboptloYX8iPzp4tkTkmnuaUd1uyrw-XLREWx3DAFndQQ99e9Rt-fP1L3mCwx_GqlUOfx7VWFuS2vModQjcBAp2TfBRV_9KxAeBGiJHHmK5Bglojv2HoVo',
      'qty': 0,
    },
    {
      'name': 'Trouser',
      'desc': 'Formal · Crisp press',
      'price': 69,
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLsDcxKzDMAvN4sQKDLZO_GAC0x4WUhn6G-upd9kaA23C3FfqnTeOno4aMMqCKR1rmn7Rcq1iWKOHU-glduKRLTPeOTtdVnFMXo8Ks9RW5rkrWbcs6zn35r_kuzerj_h3NqN2xPJIEYKJQRelDwcEA83opV5PERy8c6PHl3hZaceJJVlMGySvPpUBHHYBsGBXSpWwxK3_XDkyDc9k2uxwiMOq3_jH7QVKbYMIQb_iEPeGJKnn2ESoA2Up_fS',
      'qty': 1,
    },
    {
      'name': 'Suit',
      'desc': 'Wool · Dry clean only',
      'price': 249,
      'image': 'https://lh3.googleusercontent.com/aida/AP1WRLt9vgzoweewE1Cgwba2O14fqKaTj317z-fEbSbFFYFINgjfR9NJUPtdZFgoWf7My-uED6FyU9CfsfJBIGFngeGrzeDdFpQ84g_ltmiheok_FHpSIVQJ2a7dNDJGq5zEENRtJugs8Poqi90p_PGhamHZ2aYD6z0E1-ExXx2LXaqjoK2HBqlheV7dy6xR7CH213h-0mxQCyJoniihT4WDznQ6ajeIBB2UGmiuQ94fkJUwy3aMbKtkFa8JCxU',
      'qty': 0,
    },
  ];

  int get _totalItems => _garments.fold(0, (sum, item) => sum + (item['qty'] as int));
  int get _totalPrice => _garments.fold(0, (sum, item) => sum + ((item['price'] as int) * (item['qty'] as int)));

  void _updateQty(int index, int delta) {
    setState(() {
      final current = _garments[index]['qty'] as int;
      if (current + delta >= 0) {
        _garments[index]['qty'] = current + delta;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // Main Scrollable Content
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: topPadding + 64, bottom: 100),
              children: [
                _buildSearchField(),
                _buildCategoryChips(),
                _buildQuickAdd(),
                _buildGarmentsList(),
              ],
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),
          
          // Sticky Floating Cart
          if (_totalItems > 0)
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: _buildFloatingCart(),
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
        border: Border(bottom: BorderSide(color: Color(0x1AE2E8E9))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
                    splashRadius: 24,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add your garments', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0x1A0EA5A4), borderRadius: BorderRadius.circular(4)),
                        child: Text(widget.serviceName.toUpperCase(), style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: Color(0xFF64748B)),
                splashRadius: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar (Step 2)
          Container(
            height: 2,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0x4DE2E8E9)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.33,
              child: Container(decoration: const BoxDecoration(color: Color(0xFF0EA5A4))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search garments',
            hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: _categories.asMap().entries.map((entry) {
          final idx = entry.key;
          final title = entry.value;
          final isSelected = _selectedCategoryIndex == idx;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategoryIndex = idx),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
                  boxShadow: isSelected ? const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 16, offset: Offset(0, 4))] : null,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuickAdd() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recently ordered', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildQuickAddChip('White Shirt'),
              _buildQuickAddChip('Denim Jeans'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddChip(String label) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          border: Border.all(color: const Color(0x1A0EA5A4)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            const Icon(Icons.add, color: Color(0xFF0EA5A4), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildGarmentsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _garments.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;
          final qty = item['qty'] as int;

          return GestureDetector(
            onTap: () {
              // Open customization bottom sheet when tapping a garment
              ItemCustomizationBottomSheet.show(context);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6F6),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(item['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(child: Text(item['name'], style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis)),
                            if (item['badge'] != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0x1A7C3AED), borderRadius: BorderRadius.circular(4)),
                                child: Text(item['badge'], style: const TextStyle(color: Color(0xFF7C3AED), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                              ),
                            ]
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(item['desc'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                        const SizedBox(height: 4),
                        Text('₹${item['price']}', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  if (qty > 0)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6F6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => _updateQty(idx, -1),
                            child: Container(
                              width: 32, height: 32,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 4, offset: Offset(0, 2))]),
                              child: const Icon(Icons.remove, color: Color(0xFF0EA5A4), size: 20),
                            ),
                          ),
                          Container(
                            width: 24,
                            alignment: Alignment.center,
                            child: Text('$qty', style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
                          ),
                          GestureDetector(
                            onTap: () => _updateQty(idx, 1),
                            child: Container(
                              width: 32, height: 32,
                              decoration: const BoxDecoration(color: Color(0xFF0EA5A4), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x330EA5A4), blurRadius: 4, offset: Offset(0, 2))]),
                              child: const Icon(Icons.add, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed: () => _updateQty(idx, 1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0x1A0EA5A4),
                        foregroundColor: const Color(0xFF0EA5A4),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFloatingCart() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32), // extra padding for bottom safe area
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            const Color(0xFFF7FAFB),
            const Color(0xFFF7FAFB).withOpacity(0.95),
            const Color(0xFFF7FAFB).withOpacity(0.0),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
          border: Border.all(color: const Color(0x1AE2E8E9)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$_totalItems items', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold)),
                Text('₹$_totalPrice', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const BasketScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0EA5A4),
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: const Color(0x330EA5A4),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                children: const [
                  Text('Review basket', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
