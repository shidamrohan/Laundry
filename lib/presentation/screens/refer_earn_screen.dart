import 'package:flutter/material.dart';

class ReferEarnScreen extends StatefulWidget {
  const ReferEarnScreen({super.key});

  @override
  State<ReferEarnScreen> createState() => _ReferEarnScreenState();
}

class _ReferEarnScreenState extends State<ReferEarnScreen> {
  bool _isCopied = false;

  void _copyCode() {
    setState(() => _isCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isCopied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      body: Stack(
        children: [
          // ── MAIN CONTENT ──
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: topPadding + 64 + 16)),

              // ── HERO ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildHero(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── SUMMARY ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildSummary(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // ── REFERRAL BLOCK ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildReferralBlock(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── MILESTONES ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildMilestones(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),

              // ── HISTORY ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildHistory(),
                ),
              ),

              SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 100)),
            ],
          ),

          // ── HEADER ──
          Positioned(
            top: 0, left: 0, right: 0,
            child: _buildHeader(topPadding),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HEADER ───────────────────────

  Widget _buildHeader(double topPadding) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(4, topPadding, 4, 0),
      height: topPadding + 64,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0EA5A4), size: 24),
            splashRadius: 22,
          ),
          const Text(
            'Refer & Earn',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────── HERO ───────────────────────

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0EA5A4), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0EA5A4).withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Bubbles
          Positioned(
            top: -20, right: -20,
            child: Container(width: 120, height: 120, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle)),
          ),
          Positioned(
            bottom: -20, left: -20,
            child: Container(width: 90, height: 90, decoration: BoxDecoration(color: const Color(0xFF0B7F7E).withOpacity(0.2), shape: BoxShape.circle)),
          ),
          // Content
          Column(
            children: [
              Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuBEnEqgzajrvLBpG7nEJw4CF4-sfvVAOVzMOTZTBmyrVS2OX720bigtsFlbZYizs44CJJ4_JovTJGaz36NDNBQfCYrGERC9-C9tEfjCEQLpLUUC0jiaIsDSbBzXKtQ-HxnnujHF6EN3vEexeAg3RcCa_gjhC9ffCTuP7Di_rvPVCWMWEWYSIckzpiy_Kn57O7cV5tTbxPODp0WeNbtdjXRQRy74leJTh3a-ON8Z8EFOS6qiESgIv23iJavvj35SOErcr4TMQfQ4uNlX',
                height: 140,
                errorBuilder: (_, __, ___) => const SizedBox(height: 140, child: Icon(Icons.group, size: 80, color: Colors.white)),
              ),
              const SizedBox(height: 16),
              const Text('Give ₹100, Get ₹100',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
              const SizedBox(height: 8),
              Text('Invite friends to Orio and you both earn.',
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }

  // ─────────────────────── SUMMARY ───────────────────────

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8E9)),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TOTAL REWARDS', style: TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1.0)),
                  const SizedBox(height: 4),
                  RichText(
                    text: const TextSpan(
                      text: '₹500 ',
                      style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 28, fontWeight: FontWeight.bold),
                      children: [TextSpan(text: 'earned', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500))],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFFEFF6F6), borderRadius: BorderRadius.circular(30)),
                child: const Icon(Icons.account_balance_wallet, color: Color(0xFF0EA5A4), size: 28),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE2E8E9)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildStatColumn('5', 'Invited', const Color(0xFF0F172A))),
              Container(width: 1, height: 36, color: const Color(0xFFE2E8E9)),
              Expanded(child: _buildStatColumn('3', 'Joined', const Color(0xFF16A34A))),
              Container(width: 1, height: 36, color: const Color(0xFFE2E8E9)),
              Expanded(child: _buildStatColumn('2', 'Pending', const Color(0xFFF59E0B))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label, Color countColor) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: countColor, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
      ],
    );
  }

  // ─────────────────────── REFERRAL BLOCK ───────────────────────

  Widget _buildReferralBlock() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8E9), width: 2), // Dashed visual style roughly translates to solid bordered box in standard Flutter without external pkgs
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('YOUR REFERRAL CODE', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  SizedBox(height: 4),
                  Text('AARAV100', style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
                ],
              ),
              GestureDetector(
                onTap: _copyCode,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: _isCopied ? const Color(0xFF16A34A).withOpacity(0.1) : const Color(0xFFEFF6F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_isCopied ? Icons.check_circle : Icons.copy, color: _isCopied ? const Color(0xFF16A34A) : const Color(0xFF0EA5A4), size: 18),
                      const SizedBox(width: 8),
                      Text(_isCopied ? 'Copied!' : 'Copy', style: TextStyle(color: _isCopied ? const Color(0xFF16A34A) : const Color(0xFF0EA5A4), fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0EA5A4),
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: const Color(0xFF0EA5A4).withOpacity(0.4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.share, size: 20),
              SizedBox(width: 12),
              Text('Share invite', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildShareBtn(Icons.chat, const Color(0xFF25D366), 'WhatsApp'),
              const SizedBox(width: 12),
              _buildShareBtn(Icons.sms, const Color(0xFF2563EB), 'SMS'),
              const SizedBox(width: 12),
              _buildShareBtn(Icons.link, const Color(0xFF64748B), 'Copy link'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShareBtn(IconData icon, Color iconColor, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8E9)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // ─────────────────────── MILESTONES ───────────────────────

  Widget _buildMilestones() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Referral milestones', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFF0EA5A4).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: const Text('3/5 Complete', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Base Line
            Container(width: double.infinity, height: 8, decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(4))),
            // Progress Line
            FractionallySizedBox(
              widthFactor: 0.6,
              child: Container(height: 8, decoration: BoxDecoration(color: const Color(0xFF0EA5A4), borderRadius: BorderRadius.circular(4))),
            ),
            // Nodes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMilestoneNode('1st', '₹100', true),
                _buildMilestoneNode('3rd', '₹250', true),
                _buildMilestoneNode('5th', '₹500', false),
                _buildMilestoneNode('10th', '', false, icon: Icons.workspace_premium),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMilestoneNode(String label, String amount, bool isAchieved, {IconData? icon}) {
    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
            color: isAchieved ? const Color(0xFF0EA5A4) : const Color(0xFFE2E8E9),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 4)],
          ),
          child: Center(
            child: icon != null
                ? Icon(icon, color: isAchieved ? Colors.white : const Color(0xFF64748B), size: 16)
                : Text(amount, style: TextStyle(color: isAchieved ? Colors.white : const Color(0xFF0F172A), fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ),
        Text(label, style: TextStyle(color: isAchieved ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // ─────────────────────── HISTORY ───────────────────────

  Widget _buildHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Invite history', style: TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildHistoryRow(
          img: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCm_qvioob-rGZDIM2zf1J3QVgSbZgaaOrEjiQ3hvifACGMbEKyMU4Nug063ORR3vxVeiFjCN5csAfSe7uwp7GqYHP2BDOQTl32_Fe9CYfC-yzAP2EqBcfyQY_-OH7v0HHoiZFE5KWdwJnDiTbq6jMAWHNBeWyYcZoUNDCV4yZe5UH73rLVX6VlfFpRcpNjm3A4zs_dA4OQdWCAHaXc45XJoGka2Z0s7fgZxfMXnTIQDqs2LbUJDh4GbXcbTGROHGMzo_8UTFjcmpC9',
          name: 'Priya Sharma',
          date: 'Invited on 24 Oct',
          reward: '+₹100',
          status: 'Joined',
          isJoined: true,
        ),
        const SizedBox(height: 12),
        _buildHistoryRow(
          img: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBJf__2be2D8Rc7yIdjiXwXdZrcFmA-gcDeY4h5xcfBEWY0b6a1jFpbNDZ-1lAzFSwOcOh53B8nYVXimFg09Nnxpy8wcN5OwFHjCXp6ZS7u-CV3wVkmcsLtZJDr_wY5IK7LA7uIoot2bMJW9k1G3efIjzBpAjqiRSxWjH86VSb-jSCHxs_M9r0vYYmbS5T5XDMrtQf8sePmS-CSbQ_L58kIPxbEk69k3AaBnt52ZI5z-qZFEZ3P-Gig_TwEc7vHr5mkuH833AGkQVQq',
          name: 'Rahul Varma',
          date: 'Invited on 22 Oct',
          reward: '--',
          status: 'Pending',
          isJoined: false,
        ),
        const SizedBox(height: 12),
        _buildHistoryRow(
          img: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDo8FX9hzM_xvSByKn4J61Xu3fBB5Cszf3j34hwoDhYiGbs3MBJaS-4UU-oxzjM-l8fLZ2FUyn9F85N6kCpdoNUeJt9BjTcJsgZG1XQItFB6jQ0YwHlq3oCfDAmnKVWuhjXQBvvYJQA_Uhh-owIDxm9I_4I1B6rKeLDL_2Y4r6DHJsFOeWqm2pQ1fYZrMwM9sG9DvS8WY2vCxsgwzmrWXjEaBsZHMSoOiuAOPuQox0yMzmXEMBdvsy5tHdAstJtxA8EcZqQlRVD7Er5',
          name: 'Sneha Kapoor',
          date: 'Invited on 20 Oct',
          reward: '+₹250',
          status: 'Joined',
          isJoined: true,
        ),
      ],
    );
  }

  Widget _buildHistoryRow({
    required String img,
    required String name,
    required String date,
    required String reward,
    required String status,
    required bool isJoined,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8E9)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20, backgroundImage: NetworkImage(img), backgroundColor: const Color(0xFFE2E8E9)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 13, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(date, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10)),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(reward, style: TextStyle(color: isJoined ? const Color(0xFF16A34A) : const Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isJoined ? const Color(0xFF16A34A).withOpacity(0.1) : const Color(0xFFF59E0B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(status, style: TextStyle(color: isJoined ? const Color(0xFF16A34A) : const Color(0xFFF59E0B), fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
