import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['Wallet', 'Payments', 'Refunds', 'Rewards', 'Security', 'Verification'];
  
  // Track expanded state of FAQs
  int _expandedIndex = 1; // Open second one by default as per mockup

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Help Center',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.3)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF64748B)),
            onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE2E8E9)),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 24, bottom: 120),
              children: [
                // Search Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
                    ),
                    child: TextField(
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Search help topics',
                        hintStyle: const TextStyle(color: Color(0xFF64748B)),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Category Chips
                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final isSelected = i == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF0EA5A4) : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: isSelected ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9)),
                            boxShadow: isSelected
                                ? [const BoxShadow(color: Color(0x330EA5A4), blurRadius: 4, offset: Offset(0, 2))]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              _categories[i],
                              style: TextStyle(
                                color: isSelected ? Colors.white : const Color(0xFF64748B),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // FAQ Section
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text('TOP FAQ TOPICS', style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildFaqCard(
                        index: 0,
                        question: 'How do I add money to my wallet?',
                        answer: 'You can add money using UPI, credit/debit cards, or net banking directly from the Wallet screen.',
                      ),
                      const SizedBox(height: 16),
                      _buildFaqCard(
                        index: 1,
                        question: 'When will my refund arrive?',
                        answer: 'Refunds are typically processed within 24 hours of approval. However, it may take 3-5 business days for the amount to reflect in your original payment method depending on your bank\'s policies. You will receive an email confirmation once the refund has been initiated.',
                        showFeedback: true,
                      ),
                      const SizedBox(height: 16),
                      _buildFaqCard(
                        index: 2,
                        question: 'How do rewards expire?',
                        answer: 'Rewards and cashback generally expire 90 days from the date of issue unless stated otherwise.',
                      ),
                      const SizedBox(height: 16),
                      _buildFaqCard(
                        index: 3,
                        question: 'Is my wallet secure?',
                        answer: 'Yes, your VOSHIFY Wallet is secured with industry-standard encryption and requires OTP verification for significant changes.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Contact Support Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildSupportCard(),
                ),
              ],
            ),
          ),
          
          // Bottom Navigation
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }

  Widget _buildFaqCard({
    required int index,
    required String question,
    required String answer,
    bool showFeedback = false,
  }) {
    final isExpanded = _expandedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _expandedIndex = isExpanded ? -1 : index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isExpanded ? const Color(0x330EA5A4) : Colors.transparent),
          boxShadow: isExpanded
              ? [const BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))]
              : [const BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(Icons.chevron_right, color: isExpanded ? const Color(0xFF0EA5A4) : const Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity, height: 0),
              secondChild: Column(
                children: [
                  const Divider(color: Color(0x80E2E8E9), height: 1),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          answer,
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 15, height: 1.6),
                        ),
                        if (showFeedback) ...[
                          const SizedBox(height: 24),
                          const Divider(color: Color(0x80E2E8E9), height: 1),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Was this helpful?', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500)),
                              Row(
                                children: [
                                  _buildFeedbackButton(Icons.thumb_up_outlined, 'Yes', false),
                                  const SizedBox(width: 8),
                                  _buildFeedbackButton(Icons.thumb_down_outlined, 'No', true),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackButton(IconData icon, String label, bool isNegative) {
    return GestureDetector(
      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFE2E8E9)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF64748B), size: 18),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, 4))],
        border: const Border(left: BorderSide(color: Color(0xFF0EA5A4), width: 4)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Still need help?', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      'Our support team is available 24/7 to assist you with any questions or issues.',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.support_agent, color: Color(0xFF0EA5A4), size: 28),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
              icon: const Icon(Icons.chat, color: Colors.white, size: 20),
              label: const Text('Contact support', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0EA5A4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 8,
                shadowColor: const Color(0x330EA5A4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, -4))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home', false),
            _buildNavItem(Icons.local_laundry_service_outlined, Icons.local_laundry_service, 'Orders', false),
            _buildNavItem(Icons.support_agent_outlined, Icons.support_agent, 'Support', true),
            _buildNavItem(Icons.person_outline, Icons.person, 'Profile', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData outlinedIcon, IconData filledIcon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isActive
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(20)),
                child: Icon(filledIcon, color: const Color(0xFF0EA5A4), size: 24),
              )
            : Icon(outlinedIcon, color: const Color(0xFF64748B), size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: isActive ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 11, fontWeight: isActive ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
