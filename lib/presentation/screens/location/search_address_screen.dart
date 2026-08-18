import 'package:flutter/material.dart';
import 'package:laundry/core/services/location_service.dart';
import 'package:laundry/presentation/screens/location/add_address_screen.dart';

class SearchAddressScreen extends StatefulWidget {
  const SearchAddressScreen({super.key});

  @override
  State<SearchAddressScreen> createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFetchingLocation = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showDeleteModal() {
    showDialog(
      context: context,
      barrierColor: const Color(0xFF0F172A).withValues(alpha: 0.6),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 24,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64, height: 64,
                  decoration: BoxDecoration(color: const Color(0xFFDC2626).withValues(alpha: 0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.delete, color: Color(0xFFDC2626), size: 32),
                ),
                const SizedBox(height: 24),
                const Text('Delete this address?', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.5),
                    children: [
                      TextSpan(text: 'This will remove '),
                      TextSpan(text: "'Home — 21 Brigade Road'", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
                      TextSpan(text: ' permanently. This action can\'t be undone.'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDC2626),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 4,
                      shadowColor: const Color(0xFFDC2626).withValues(alpha: 0.4),
                    ),
                    child: const Text('Delete', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Cancel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Column(
        children: [
          _buildHeader(topPadding),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                _buildCurrentLocationRow(),
                const SizedBox(height: 24),
                _buildSearchResults(),
                const SizedBox(height: 24),
                _buildMapPreview(),
                const SizedBox(height: 120), // Bottom nav space
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── COMPONENTS ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(4, topPadding + 8, 16, 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8E9))),
        boxShadow: [BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
            splashRadius: 22,
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Address',
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => _searchController.clear(),
                        child: const Icon(Icons.close, color: Color(0xFF64748B), size: 20),
                      ),
                      const SizedBox(width: 8),
                      // Mocking the pulsing cursor effect from HTML
                      Container(width: 2, height: 16, decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(2))),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentLocationRow() {
    return GestureDetector(
      onTap: _fetchLocation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1), shape: BoxShape.circle),
              child: _isFetchingLocation 
                  ? const Padding(padding: EdgeInsets.all(10.0), child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF0EA5A4)))
                  : const Icon(Icons.my_location, color: Color(0xFF0EA5A4), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Use current location', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: const Color(0xFF0EA5A4).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                        child: const Text('PRECISE', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text('Using GPS to find your address', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF64748B)),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchLocation() async {
    setState(() => _isFetchingLocation = true);
    try {
      final position = await LocationService.getCurrentPosition();
      if (position != null) {
        final address = await LocationService.getAddressFromCoordinates(position.latitude, position.longitude);
        if (mounted && address != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location found: $address')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddAddressScreen()), // Passed successfully!
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isFetchingLocation = false);
      }
    }
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('SEARCH RESULTS', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
          ),
          child: Column(
            children: [
              _buildResultItem('Brigade', ' Road', '1.2 km', 'Shanthala Nagar, Bengaluru, Karnataka', Icons.location_on, 'Recent', false),
              const Divider(color: Color(0xFFE2E8E9), height: 1),
              _buildResultItem('Brigade', ' Metropolis', '8.4 km', 'Garudachar Palya, Mahadevapura, Bengaluru', Icons.location_on, 'Saved', true, isSaved: true),
              const Divider(color: Color(0xFFE2E8E9), height: 1),
              _buildResultItem('Brigade', ' Gateway', '4.7 km', 'Malleswaram, Rajajinagar, Bengaluru', Icons.location_on, null, false),
              const Divider(color: Color(0xFFE2E8E9), height: 1),
              _buildResultItem('Brigade', ' Orchards', '12.2 km', 'Devanahalli, North Bengaluru, Karnataka', Icons.location_on, null, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResultItem(String highlight, String rest, String distance, String address, IconData icon, String? tag, bool hasDelete, {bool isSaved = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF64748B), size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(text: highlight, style: const TextStyle(color: Color(0xFF0EA5A4), fontWeight: FontWeight.bold)),
                              TextSpan(text: rest),
                            ],
                          ),
                        ),
                        Text(distance, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(address, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                    if (tag != null || hasDelete) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (tag != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: isSaved ? const Color(0xFF0EA5A4).withValues(alpha: 0.1) : const Color(0xFFEFF6F6),
                                border: isSaved ? null : Border.all(color: const Color(0xFFE2E8E9)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  Icon(isSaved ? Icons.star : Icons.history, color: isSaved ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 14),
                                  const SizedBox(width: 4),
                                  Text(tag, style: TextStyle(color: isSaved ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          if (hasDelete)
                            GestureDetector(
                              onTap: _showDeleteModal,
                              child: const Icon(Icons.delete_outline, color: Color(0xFFDC2626), size: 18),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapPreview() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 192,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 4))],
          image: const DecorationImage(
            image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBuhAngkMMN71OHMcHUkrxbmOT2_jy8x22ORBAsBMGPq2GykDnhDGbMcmJJlTvp62J2rmmpP8ifSr9jwOcbwdPtCSmZmiZQa37qlKqmqGfT2UTTPSNm01S3nFOQ8lAfmbDxgaSueEcntSInRciG7B4Ys14z2_E5tblwN54Mp4eIQZbHnatdZ_oghB7tQdb9qni29YvlECmbz1yXUXgQwQ2XVzL_N6_PTU3ujMpURldT5A9F7WK1B95-T_ml0eLdH_b9Pr-dFwupZmmK'),
            fit: BoxFit.cover,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter))),
            ),
            Positioned(
              bottom: 16, left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('DON\'T SEE YOUR ADDRESS?', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  SizedBox(height: 2),
                  Text('Pick location from map', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Center(
              child: Container(
                width: 56, height: 56,
                decoration: const BoxDecoration(color: Color(0xFF0EA5A4), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 12, offset: Offset(0, 4))]),
                child: const Icon(Icons.map, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
