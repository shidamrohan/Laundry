import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/location/add_address_screen.dart';

class SelectDeliveryLocationScreen extends StatefulWidget {
  const SelectDeliveryLocationScreen({super.key});

  @override
  State<SelectDeliveryLocationScreen> createState() => _SelectDeliveryLocationScreenState();
}

class _SelectDeliveryLocationScreenState extends State<SelectDeliveryLocationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isSavedHome = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // ── MAP BACKGROUND ──
          Positioned(
            top: 0, left: 0, right: 0,
            height: MediaQuery.of(context).size.height * 0.65,
            child: _buildMapBackground(),
          ),

          // ── TOP OVERLAYS ──
          Positioned(
            top: topPadding + 16, left: 16, right: 16,
            child: _buildTopOverlays(context),
          ),

          // ── LOCATE ME FAB ──
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.40 + 24, right: 16,
            child: _buildLocateMeFab(),
          ),

          // ── BOTTOM SHEET ──
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomSheet(context),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildMapBackground() {
    return Stack(
      children: [
        // Map Image Placeholder
        Positioned.fill(
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCIJAfyh0jMM4r8js4Dq-I9WZTA-EUCP0mnxJiOalJlJNyKrldqs_OtGazrye5qqCrd62VLUvZVq77L-DYZUPBhZUKNKNDizypyIXdi8OqOxd4mdDxVh4qOVAUd2Vt_sXsKIHPxOTm5oN6iuojBCg-NmEc31sPOZmcKnPOfISG9ZVL40NVmjhKyLl5CFOhNSGcR5Q6KVD1ZViOs9nkVHnPd_EAZ0QKk323ROdYTQn6L4X-RQw2fN2PQlK-2yl8EgVdm560e_lC1zPFT',
            fit: BoxFit.cover,
            color: Colors.white.withValues(alpha: 0.2), // Lighten the map slightly
            colorBlendMode: BlendMode.lighten,
          ),
        ),
        // Central Pin
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulse Ring
              FadeTransition(
                opacity: Tween<double>(begin: 0.2, end: 0.5).animate(
                  CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
                ),
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.95, end: 1.1).animate(
                    CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
                  ),
                  child: Container(
                    width: 128, height: 128,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0EA5A4).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.2)),
                    ),
                  ),
                ),
              ),
              // Pin Shadow
              Positioned(
                bottom: 30,
                child: Container(
                  width: 16, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                ),
              ),
              // Pin Icon (Animated bounce)
              SlideTransition(
                position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.2)).animate(
                  CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Color(0xFF0EA5A4),
                  size: 64,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopOverlays(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: const Icon(Icons.chevron_left, color: Color(0xFF0F172A), size: 28),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('STEP 2 OF 3', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    Row(
                      children: [
                        Container(width: 32, height: 6, decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(3))),
                        const SizedBox(width: 4),
                        Container(width: 32, height: 6, decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(3))),
                        const SizedBox(width: 4),
                        Container(width: 32, height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(3))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 16, offset: Offset(0, 4))],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for a new address',
              hintStyle: TextStyle(color: const Color(0xFF64748B), fontSize: 15),
              prefixIcon: const Icon(Icons.search, color: Color(0xFF0EA5A4)),
              suffixIcon: const Icon(Icons.mic, color: Color(0xFF64748B)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocateMeFab() {
    return Container(
      width: 56, height: 56,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 24, offset: Offset(0, 8))],
      ),
      child: const Icon(Icons.my_location, color: Color(0xFF0EA5A4), size: 28),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 24, offset: Offset(0, -8))],
      ),
      child: Column(
        children: [
          // Drag Handle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(width: 48, height: 6, decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(3))),
          ),
          // Scrollable Content
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _buildAddressHeader(),
                const SizedBox(height: 24),
                _buildStatusTimingRow(),
                const SizedBox(height: 24),
                _buildNearbySaved(),
              ],
            ),
          ),
          // Footer CTA
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
            ),
            child: SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddAddressScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A4),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Confirm location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DELIVERY TO', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              child: Text('21 Brigade Road, Shanthala Nagar', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold, height: 1.2)),
            ),
            SizedBox(width: 8),
            Icon(Icons.edit_location_alt, color: Color(0xFF0EA5A4), size: 24),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusTimingRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24, height: 24,
                    decoration: BoxDecoration(color: const Color(0xFF16A34A).withValues(alpha: 0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.check_circle, color: Color(0xFF16A34A), size: 16),
                  ),
                  const SizedBox(width: 8),
                  const Text('Delivery available', style: TextStyle(color: Color(0xFF16A34A), fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                child: const Text('EXPRESS AVAILABLE', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('PICKUP IN', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.0)),
                    SizedBox(height: 2),
                    Text('~30 min', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Container(width: 1, height: 32, color: const Color(0xFFE2E8E9)),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('DELIVERY IN', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.0)),
                    SizedBox(height: 2),
                    Text('24h', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNearbySaved() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.bookmark, color: Color(0xFF0F172A), size: 18),
            SizedBox(width: 8),
            Text('Nearby & saved', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        // Saved Chip
        GestureDetector(
          onTap: () => setState(() => _isSavedHome = !_isSavedHome),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _isSavedHome ? const Color(0xFF0EA5A4) : const Color(0xFF0EA5A4).withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF0EA5A4).withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, color: _isSavedHome ? Colors.white : const Color(0xFF0EA5A4), size: 18),
                const SizedBox(width: 8),
                Text('Home', style: TextStyle(color: _isSavedHome ? Colors.white : const Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Nearby Rows
        _buildNearbyRow(Icons.location_on, 'Empire Restaurant', '0.4 km · 6 min walk'),
        _buildNearbyRow(Icons.storefront, 'Garuda Mall Entry', '0.7 km · 11 min walk'),
      ],
    );
  }

  Widget _buildNearbyRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: const Color(0xFFE2E8E9).withValues(alpha: 0.4), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF64748B), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
                Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFE2E8E9)),
        ],
      ),
    );
  }
}
