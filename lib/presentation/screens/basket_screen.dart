import 'package:flutter/material.dart';
import 'care_instructions_screen.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final List<Map<String, dynamic>> _basketItems = [
    {
      'id': '1',
      'title': 'Formal Shirt',
      'desc': 'Cotton · Iron · Eco wash',
      'price': 158,
      'qty': 2,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVz_EVSc1e7fkUWlt9TllasqGfxzTfhAlD-_-hzcJu6et3X-Cs_aqNucJSk80XH-ha6MfAZsTTYt2rVBJQHENJvXsftOQcP-Dh9k8AxeUGqv8fNzptJQjulCZ9Hj3cntzVKTIhNDAUgLP_U4uQalWwVnX9dfns-YDFR1jULA8EMdeNB4l4sxDKhMZtixbV2b9duHXCSfNRhAiKyByG1HKBsdwS1Tc_DWNEhoEFgTfv09oBVU0NW1SIcU8fCrQAgT1gdGRFJMxcHLfr',
    },
    {
      'id': '2',
      'title': 'Denim Jeans',
      'desc': 'Tumble Dry · Softener',
      'price': 238,
      'qty': 2,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAKFylEDh6-fnZ8S9RHFn_wLTCuSF1BdKqMJCgKGVul2Sa3Lr-qrN3c7BZ29IT_Ed5AVMsEbINXVElrUggRnqALJrNSiG_qX7muGwrOhU3-6gyrmvWaV0gS7VbBoP7eWMWbHVx4B-ZJu9-NZT5K7Njsy81c_tlu2buuC77F6Rfc-NKMY7cSQUK9QYXZMO2Rv5jtcDPImU4Zjw9Mh8E73az5BWuvMM2oPpmAm3RBK6Lq9Hr6k4mbp9wMKpD8GOGWtqNLarGVxJ6TcIBt',
    },
    {
      'id': '3',
      'title': 'Formal Trousers',
      'desc': 'Wool mix · Steam Iron',
      'price': 297,
      'qty': 3,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuAuizUzVHwInzJagQJLyXkMe9y0L1f4x9wrbmVgRsGvgInFsrusxMoOOWpwFycZnsuxHc_TGU4IYYRwcM1BM3TVV13iHJ6UCmSv-6X4JSgtyxVHY7LplTOwwEo0vt7QrEDy91RxngY5xnpTEWnTV7OeQ7_EKrU84xiCophYrEmhjQ-iICkK49n1OrV88sVoIQeIKZ1HvYcLDS6lclJu0WNGzKoj1fQrzHoemOnk2iRWb6Q2tl1_ptcvO0nrzoc6mFG9BDQe24NnPKeC',
    },
    {
      'id': '4',
      'title': 'T-Shirt Pack',
      'desc': 'Mixed colors · Soft Wash',
      'price': 255,
      'qty': 5,
      'image': 'https://lh3.googleusercontent.com/aida-public/AB6AXuBTVz-fYgliPYe-9NaDd1XfxlIQWurBuUD23F-HI4TQTn9vWeTEypRTTcrKkalw85hiM1e_9cmp9S_KpMo0ZKeUfsDycGAtKCedX5f4UeSau6p0YqPUgradSGtRZO5FqzYJNtzUpg5_bDOOI19B9BV96V2KS06JgbkLiwvobFlJGijZ38ZN8WLmGH3Q9ddX2ly-yQB7Vj4_UVIriFspDwSXxk5YvwW1PR2dD9qTtFtJiDA6O1h9gs71XwZ3ZN8CawWmSyI0gMSahvTQ',
    },
  ];

  int get _totalItems => _basketItems.fold(0, (sum, item) => sum + (item['qty'] as int));
  int get _totalPrice => _basketItems.fold(0, (sum, item) => sum + (item['price'] as int)); // Assuming price is total for the qty line item as per mockup

  void _updateQty(int index, int delta) {
    setState(() {
      final current = _basketItems[index]['qty'] as int;
      if (current + delta > 0) {
        _basketItems[index]['qty'] = current + delta;
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _basketItems.removeAt(index);
    });
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
              padding: EdgeInsets.only(top: topPadding + 64, bottom: 180),
              children: [
                _buildSummaryCard(),
                _buildItemList(),
                _buildAddMoreButton(),
              ],
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),
          
          // Sticky Footer
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildFooter(),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, topPadding + 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
                      splashRadius: 24,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 12),
                    const Text('Your basket', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, color: Color(0xFF0F172A)),
                  splashRadius: 24,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Progress Bar (Step 3)
          Container(
            height: 4,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0x4DE2E8E9)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.50,
              child: Container(decoration: const BoxDecoration(color: Color(0xFF0EA5A4))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.scale, color: Color(0xFF0EA5A4), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: '$_totalItems items ', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                        const TextSpan(text: '· ', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16)),
                        const TextSpan(text: 'est. 4.5 kg', style: TextStyle(color: Color(0xFF64748B), fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF16A34A), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      const Text('PICKUP AVAILABLE TODAY', style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0x6664748B)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(_basketItems.length, (index) {
          final item = _basketItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Dismissible(
              key: Key(item['id']),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => _removeItem(index),
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete, color: Color(0xFFDC2626)),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.transparent), // for hover effect if web, skipped here
                  boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6F6),
                        borderRadius: BorderRadius.circular(8),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title'], style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 2),
                                    Text(item['desc'], style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                              Text('₹${item['price']}', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Text('Edit', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 12, fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6F6),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: const Color(0xFFE2E8E9)),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _updateQty(index, -1),
                                      child: Container(
                                        width: 32, height: 32,
                                        decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                                        child: const Icon(Icons.remove, color: Color(0xFF0F172A), size: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                      child: Center(child: Text('${item['qty']}', style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold))),
                                    ),
                                    GestureDetector(
                                      onTap: () => _updateQty(index, 1),
                                      child: Container(
                                        width: 32, height: 32,
                                        decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                                        child: const Icon(Icons.add, color: Color(0xFF0F172A), size: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAddMoreButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E8E9), width: 2, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add_circle_outline, color: Color(0xFF0EA5A4)),
              SizedBox(width: 8),
              Text('+ Add more garments', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -8))],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$_totalItems items inclusive of tax', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const Text('Total: ', style: TextStyle(color: Color(0xFF64748B), fontSize: 18)),
                        Text('₹$_totalPrice', style: const TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Text('View break-up', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.expand_more, color: Color(0xFF0EA5A4), size: 16),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CareInstructionsScreen()));
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
                    Text('Continue to schedule', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
}
