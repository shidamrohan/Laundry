import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/home/home_screen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFF0F172A)),
          onPressed: () {
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
          },
        ),
        title: const Text('Order confirmed', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 140),
            children: [
              _buildHeroSection(),
              _buildGreeting(),
              _buildTimelineCard(),
              _buildSupportRow(),
              _buildHelpTip(),
              const SizedBox(height: 32),
            ],
          ),
          
          // Sticky Bottom Actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
              decoration: const BoxDecoration(
                color: Color(0xCCFFFFFF), // 80% opacity
                backgroundBlendMode: BlendMode.srcOver,
              ),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0EA5A4),
                      foregroundColor: Colors.white,
                      elevation: 8,
                      shadowColor: const Color(0x330EA5A4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text('Track order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF64748B),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Continue shopping', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF0EA5A4),
          foregroundColor: Colors.white,
          elevation: 8,
          child: const Icon(Icons.help),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: SizedBox(
          width: 280,
          height: 280,
          child: Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCodqWgk-bjkHu2GH6BBDSs6yvWowAQnqD_yEs02p7CbK5CcKva6FT3btvtFlQ7Td2PnMcwqAQinix-5JY9F2MRUCkQOowOsj7JFxH3-5w_UQWmJ5Q2OA7p8yR2lYTr5bKn87ooQK8sEd_nLWgfv9JXfVNiLfnfNlgKEhZXUq0EXLtoBsHhc-rQFSZAaPSh984F4X2dvsX7r6PwIQjKMYVJwyEBWziUDcdoCIHVdzIEfckp_6K-r6fxH7Gsu6EbNkHD6TxWta_xS8G8',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFFEFF6F6),
              child: const Icon(Icons.check_circle, color: Color(0xFF0EA5A4), size: 100),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      children: const [
        Text(
          'You\'re all set, Aarav!',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
        ),
        SizedBox(height: 8),
        Text(
          'Order #ORIO1042 · Wash & Fold, Priority',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF64748B)),
        ),
        SizedBox(height: 32),
      ],
    );
  }

  Widget _buildTimelineCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTimelineStep(isCompleted: true, isActive: false, isFirst: true, isLast: false, title: 'Order placed', time: '10:30 AM', subtitle: null),
            _buildTimelineStep(isCompleted: false, isActive: true, isFirst: false, isLast: false, title: 'Pickup scheduled — Tomorrow 12–3 PM', subtitle: 'Our agent is assigned', time: null),
            _buildTimelineStep(isCompleted: false, isActive: false, isFirst: false, isLast: false, title: 'Picked up', time: null, subtitle: null),
            _buildTimelineStep(isCompleted: false, isActive: false, isFirst: false, isLast: false, title: 'Cleaning in progress', time: null, subtitle: null),
            _buildTimelineStep(isCompleted: false, isActive: false, isFirst: false, isLast: false, title: 'Out for delivery', time: null, subtitle: null),
            _buildTimelineStep(isCompleted: false, isActive: false, isFirst: false, isLast: true, title: 'Delivered', time: null, subtitle: null),
            
            const SizedBox(height: 32),
            const Divider(color: Color(0xFFE2E8E9)),
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.calendar_today, color: Color(0xFF0EA5A4), size: 20),
                    SizedBox(width: 8),
                    Text('Expected completion', style: TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.w600)),
                  ],
                ),
                const Text('Thu, 25 Jul', style: TextStyle(color: Color(0xFF0F172A), fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required bool isCompleted,
    required bool isActive,
    required bool isFirst,
    required bool isLast,
    required String title,
    String? subtitle,
    String? time,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                if (!isLast)
                  Positioned(
                    top: 24,
                    bottom: 0,
                    child: Container(width: 2, color: const Color(0xFFE2E8E9)),
                  ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isCompleted || isActive ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
                      shape: BoxShape.circle,
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : isActive
                            ? Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                            : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: isActive ? const Color(0xFF0EA5A4) : (isCompleted ? const Color(0xFF0F172A) : const Color(0x660F172A)),
                            fontSize: 15,
                            fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      ),
                      if (time != null)
                        Text(
                          time,
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                        ),
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0EA5A4),
                foregroundColor: Colors.white,
                elevation: 8,
                shadowColor: const Color(0x330EA5A4),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.chat_bubble_outline, size: 20),
                  SizedBox(width: 8),
                  Text('Chat with us', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0F172A),
                side: const BorderSide(color: Color(0xFFE2E8E9)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.phone_outlined, size: 20),
                  SizedBox(width: 8),
                  Text('Call', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpTip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          border: Border.all(color: const Color(0x1A0EA5A4)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.info_outline, color: Color(0xFF0EA5A4), size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Need to change your pickup window? You can reschedule up to 2 hours before the time slot.',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
