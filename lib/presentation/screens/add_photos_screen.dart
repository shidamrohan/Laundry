import 'package:flutter/material.dart';
import 'schedule_screen.dart';

class AddPhotosScreen extends StatefulWidget {
  const AddPhotosScreen({super.key});

  @override
  State<AddPhotosScreen> createState() => _AddPhotosScreenState();
}

class _AddPhotosScreenState extends State<AddPhotosScreen> with SingleTickerProviderStateMixin {
  late AnimationController _spinnerController;

  final List<Map<String, dynamic>> _photos = [
    {
      'id': '1',
      'type': 'ai', // AI detected
      'url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDlJpnFmGEdh2uuAXtd0getfztMqT7_GwUohP4vMluDRJKSpjbXF-haiWYvP3jA8WPxNNkATM2gc6jj0-qLUZ9zgbFNlmf0FhyEbM6Tbd_rhbFy6PbryvBpqxXYDuKF7tNwqe48k0ZEitVzUFFNmg9T8jLh_YR3eWUdR67pskXZleDM_aIigIMn3adpKPFChBNlLZvvYIroukpasx6e8maxQo4OmPFRd0ENHEkDmtpG9gYag_HEZYRF4ohsXwBy6QEDcoHjo7UNmOC0',
      'message': 'AI: STAIN DETECTED ON COLLAR',
    },
    {
      'id': '2',
      'type': 'standard',
      'url': 'https://lh3.googleusercontent.com/aida-public/AB6AXuDSN06S9eJ6Ni7ALB_4XLICtbNEAs9hXn9QQeIj49gfh-IPFR3k98l7QI5saawLgOlwuZru7WS9RqHjIlaI1x4OKw7_sBMAyw9dbNIRUsylPvNlzyCZS6OCgVqMgdY6MJKHMBT13tFzYVKS3N2sP_yP9vSZMmIhwDpxytB177drvnGhqVVysBHoTDa8dzlqSjzOAoGOPpis2yNbtik-ywvzrk5jgQ4pP6c9NAumsrdiSwVolFPaZCxkYSn92NoP1PW0uvb3946UR1V2',
    },
    {
      'id': '3',
      'type': 'uploading',
    },
  ];

  @override
  void initState() {
    super.initState();
    _spinnerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _spinnerController.dispose();
    super.dispose();
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
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
              padding: EdgeInsets.only(top: topPadding + 64 + 24, bottom: 120, left: 20, right: 20),
              children: [
                _buildExplainerCard(),
                const SizedBox(height: 24),
                _buildActionTiles(),
                const SizedBox(height: 24),
                _buildGalleryGrid(),
                const SizedBox(height: 24),
                const Text('Up to 6 photos · JPG or PNG', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
              ],
            ),
          ),
          
          // Fixed Header
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),
          
          // Sticky Bottom Bar
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildBottomBar(),
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
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
                  splashRadius: 24,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                const Expanded(child: Text('Add photos', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: -0.5))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(30)),
                  child: const Text('OPTIONAL', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ),
              ],
            ),
          ),
          // Progress Bar (Step 5 - 83%)
          Container(
            height: 4,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFFE2E8E9)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.83,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0EA5A4),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(2), bottomRight: Radius.circular(2)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplainerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x1A0EA5A4)),
        boxShadow: const [BoxShadow(color: Color(0x050F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 4, offset: Offset(0, 2))]),
            child: const Icon(Icons.auto_awesome, color: Color(0xFF0EA5A4), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Color(0xFF64748B), fontSize: 15, height: 1.5),
                children: [
                  TextSpan(text: 'Photos help our experts', style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
                  TextSpan(text: ' spot stains and handle unique fabrics correctly for the best results.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTiles() {
    return Row(
      children: [
        Expanded(
          child: _buildActionTile(Icons.photo_camera, 'Take photo', () {}),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionTile(Icons.photo_library, 'Upload from gallery', () {}),
        ),
      ],
    );
  }

  Widget _buildActionTile(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8E9), width: 2, style: BorderStyle.solid), // Dashed not natively supported, using solid light
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48, height: 48,
                decoration: const BoxDecoration(color: Color(0xFFEFF6F6), shape: BoxShape.circle),
                child: Icon(icon, color: const Color(0xFF0EA5A4), size: 24),
              ),
              const SizedBox(height: 12),
              Text(label, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryGrid() {
    if (_photos.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: _photos.length,
      itemBuilder: (context, index) {
        final photo = _photos[index];
        final isUploading = photo['type'] == 'uploading';
        final isAI = photo['type'] == 'ai';

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8E9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 4, offset: Offset(0, 2))],
          ),
          clipBehavior: Clip.hardEdge,
          child: isUploading
              ? _buildUploadingThumbnail()
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(photo['url'], fit: BoxFit.cover),
                    Positioned(
                      top: 6, right: 6,
                      child: GestureDetector(
                        onTap: () => _removePhoto(index),
                        child: Container(
                          width: 24, height: 24,
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 4)]),
                          child: const Icon(Icons.close, color: Color(0xFFDC2626), size: 16),
                        ),
                      ),
                    ),
                    if (isAI)
                      Positioned(
                        bottom: 0, left: 0, right: 0,
                        child: Container(
                          color: const Color(0xFF0EA5A4).withOpacity(0.9),
                          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.flare, color: Colors.white, size: 12),
                              const SizedBox(width: 4),
                              Expanded(child: Text(photo['message'], style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildUploadingThumbnail() {
    return Container(
      color: const Color(0xFFEFF6F6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            turns: _spinnerController,
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0x330EA5A4), width: 3),
              ),
              // Simulating the spinner border-top effect
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0EA5A4)),
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text('UPLOADING', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: const Border(top: BorderSide(color: Color(0x80E2E8E9))),
        boxShadow: const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 24, offset: Offset(0, -8))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleScreen()));
                },
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF64748B),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Skip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0EA5A4), Color(0xFF2563EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [BoxShadow(color: Color(0x330EA5A4), blurRadius: 16, offset: Offset(0, 4))],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScheduleScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
