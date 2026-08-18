import 'package:flutter/material.dart';
import 'package:laundry/core/services/location_service.dart';
import 'package:laundry/presentation/screens/location/add_address_screen.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  bool _isClosing = false;
  bool _isFetchingLocation = false;

  void _handleClose() {
    setState(() => _isClosing = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Important for showing map underneath if it was a modal, but here we just render the map
      body: Stack(
        children: [
          // Background Map (Placeholder)
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDOJQ_z924goUYmuPWmYZwf4LVb-K_XTWTKbph9CpA0UFJZ9L7Rm_rxVConx2mnMbLhkHZPxoaEz7PIqgipHKUuiFi6FcxXPTBeBZeNnUDGJQAqh7TlO8xRIDBQ1d4ichD1teIHmZKiL9zV4IQt1gdzlltqHvB8nzCv4fnzdmFZns5Z32giJOwWzte8m9iiURwNC_sZUQq6vSHFFZe4Z4U4gHIBVOolrXGSHNCv9McMapoghT2_d-IxdJmn_p4sW5sirsdwufTHOIS2',
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.1), // Slight darkening for better contrast
              colorBlendMode: BlendMode.darken,
            ),
          ),
          
          // Scrim
          Positioned.fill(
            child: GestureDetector(
              onTap: _handleClose,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _isClosing ? 0.0 : 1.0,
                child: Container(
                  color: const Color(0x660F172A), // glass-scrim equivalent
                ),
              ),
            ),
          ),

          // Bottom Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              offset: _isClosing ? const Offset(0, 1) : Offset.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Floating Close Button
                  GestureDetector(
                    onTap: _handleClose,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
                      ),
                      child: const Icon(Icons.close, color: Color(0xFF0F172A)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // The Sheet Content
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                      boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, 8))],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Drag Handle
                        const SizedBox(height: 12),
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8E9),
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Scrollable Body
                        Flexible(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Location Status Card
                                _buildLocationStatusCard(),
                                const SizedBox(height: 24),

                                // Section Header
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Select a saved address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text('See all', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),

                                // Saved Addresses List
                                _buildSavedAddress(
                                  icon: Icons.home,
                                  title: 'Home',
                                  subtitle: '21 Brigade Road, Shanthala Nagar, Bangalore...',
                                ),
                                const SizedBox(height: 16),
                                _buildSavedAddress(
                                  icon: Icons.work,
                                  title: 'Work',
                                  subtitle: 'Prestige Tech Park, Marathahalli, Outer Ring Road...',
                                ),
                                const SizedBox(height: 24),

                                // Recent Searches
                                const Text('RECENT SEARCHES', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    _buildRecentSearchChip('Indiranagar'),
                                    _buildRecentSearchChip('Koramangala'),
                                    _buildRecentSearchChip('Whitefield'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Sticky Search Field
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(top: BorderSide(color: Color(0x33E2E8E9))),
                            boxShadow: [BoxShadow(color: Color(0x08000000), blurRadius: 24, offset: Offset(0, -4))],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Search location manually',
                                hintStyle: TextStyle(color: Color(0xB364748B), fontSize: 15),
                                prefixIcon: Icon(Icons.search, color: Color(0xFF64748B)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x80E2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: const BoxDecoration(color: Color(0x1A0EA5A4), shape: BoxShape.circle),
            child: const Icon(Icons.location_off, color: Color(0xFF0EA5A4), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Device location not enabled', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('Enable your device location for better accuracy', style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: _isFetchingLocation
                ? null
                : () async {
                    setState(() => _isFetchingLocation = true);
                    try {
                      final pos = await LocationService.getCurrentPosition();
                      if (pos != null) {
                        final address = await LocationService.getAddressFromCoordinates(pos.latitude, pos.longitude);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Location found: $address')));
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAddressScreen()));
                        }
                      }
                    } catch (e) {
                      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    } finally {
                      if (mounted) setState(() => _isFetchingLocation = false);
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0EA5A4),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: _isFetchingLocation 
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('Enable', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedAddress({required IconData icon, required String title, required String subtitle}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0x4DE2E8E9)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
              child: Icon(icon, color: const Color(0xFF64748B)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14), overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0x6664748B)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x80E2E8E9)),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
    );
  }
}
