import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);
  static const _error = Color(0xFFDC2626);

  String? _selectedIssueType;
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFB),
      appBar: AppBar(
        backgroundColor: _surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: _divider),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _primary),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'Report an issue',
          style: TextStyle(color: _primary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 120),
              children: [
                _buildHeroBanner(),
                const SizedBox(height: 24),
                _buildEmergencyButton(),
                const SizedBox(height: 32),
                _buildFormSection(),
                const SizedBox(height: 24),
                _buildInfoNote(),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildSubmitFooter()),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFEE2E2), Color(0xFFFEF3C7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.shield, color: _error, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Report a safety or emergency issue',
                  style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
                ),
                SizedBox(height: 4),
                Text(
                  'For urgent help, call our 24/7 helpline.',
                  style: TextStyle(color: _textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
        icon: const Icon(Icons.call),
        label: const Text('Call emergency helpline'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _error,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: _error.withValues(alpha: 0.3),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      spacing: 16,
      children: [
        _buildDropdownCard(
          label: 'ISSUE TYPE',
          hint: 'Select an issue',
          value: _selectedIssueType,
          items: const ['Damaged item', 'Missing item', 'Rude staff', 'Safety concern'],
          onChanged: (val) => setState(() => _selectedIssueType = val),
        ),
        _buildInfoCard(
          label: 'RELATED ORDER',
          content: Row(
            children: const [
              Icon(Icons.local_laundry_service, color: _primary),
              SizedBox(width: 8),
              Text('#VOSHIFY1042', style: TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: _buildTextFieldCard(
                label: 'YOUR NAME',
                initialValue: 'Aarav Kumar',
                readOnly: true,
              ),
            ),
            Expanded(
              child: _buildTextFieldCard(
                label: 'PHONE',
                initialValue: '+91 98765 43210',
                readOnly: true,
              ),
            ),
          ],
        ),
        _buildTextFieldCard(
          label: 'EMAIL ADDRESS',
          hintText: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        _buildTextAreaCard(),
        _buildPhotosCard(),
      ],
    );
  }

  Widget _buildDropdownCard({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return _buildCardBase(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: _surfaceAlt, borderRadius: BorderRadius.circular(8)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            hint: Text(hint, style: const TextStyle(color: _textSecondary, fontSize: 16)),
            icon: const Icon(Icons.expand_more, color: _textSecondary),
            items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, style: const TextStyle(color: _textPrimary, fontSize: 16)))).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String label, required Widget content}) {
    return _buildCardBase(
      label: label,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: _surfaceAlt, borderRadius: BorderRadius.circular(8)),
        child: content,
      ),
    );
  }

  Widget _buildTextFieldCard({
    required String label,
    String? initialValue,
    String? hintText,
    bool readOnly = false,
    TextInputType? keyboardType,
  }) {
    return _buildCardBase(
      label: label,
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        keyboardType: keyboardType,
        style: TextStyle(color: readOnly ? _textSecondary : _textPrimary, fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: _textSecondary),
          filled: true,
          fillColor: _surfaceAlt,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildTextAreaCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _divider),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('DESCRIBE WHAT HAPPENED', style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              AnimatedBuilder(
                animation: _descController,
                builder: (context, _) {
                  final count = _descController.text.length;
                  final isError = count > 450;
                  return Text(
                    '$count / 500',
                    style: TextStyle(color: isError ? _error : _textSecondary, fontSize: 10, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descController,
            maxLength: 500,
            maxLines: 4,
            style: const TextStyle(color: _textPrimary, fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Please provide details of the incident...',
              hintStyle: const TextStyle(color: _textSecondary),
              filled: true,
              fillColor: _surfaceAlt,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.all(16),
              counterText: '', // Hide default counter
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosCard() {
    return _buildCardBase(
      label: 'ADD PHOTOS',
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          spacing: 12,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: _divider, width: 2), // dashed not natively supported without custom painter
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.add_a_photo, color: _textSecondary, size: 32),
            ),
            _buildPhotoPlaceholder('https://lh3.googleusercontent.com/aida-public/AB6AXuBQhmJW6uSA-8pQ8makikwbDOvjAfWkQPqO1NLmmMmYB7d7UfZoCOFzWKvYd233JaI96VV_11cYxLeEAvlrEt33qlMK8BTfDNlgUeybwscEViRyO0Z8jAWI52ViyRnyh0Hs9jsZg6dZJbg7jw8j0-CW52otagXTfy-TMf2ab_ZDxpPHgW_IuxwK9ftudcGJS_Iu-IPSMtIpUpizar-lghFyIcvSNwOcUgW3GOXV8cYB7XGm81Vwa9IQYiF0nUyoK-Rl4s9Xl2YYy_Ph'),
            _buildPhotoPlaceholder('https://lh3.googleusercontent.com/aida-public/AB6AXuASOTZ0xkxL5bMD6pnvced4lHw6KElpQz0STTsJmm7gzQMgxpDpzhiax00L8yrE0ic7GtodYqlcHbRYvJg7_F4JAImy7fZ8vSkGiq4WGUH4tI6QgHprl-bpqCq5Yh_5tR-Nw0849-zthya1yrHs1Reg7pMzVRVR_10yJOJNxZ3zXkpvgKRMnivD7nXCV-wXmeJkzuYKCeBwl8OvKl8gdhlT7Q1dl5j__LJnai4HenDEX7dzvaOB3Vw5fhjzYwICBi0O9GwUXHC8_Wcr'),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoPlaceholder(String url) {
    return Container(
      width: 80, height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: _divider),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildCardBase({required String label, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _divider),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.info_outline, color: _textSecondary, size: 16),
        SizedBox(width: 8),
        Text('Our safety team responds within 30 minutes.', style: TextStyle(color: _textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildSubmitFooter() {
    return Container(
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.95),
        border: const Border(top: BorderSide(color: _divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
              icon: const Text('Submit report'),
              label: const Icon(Icons.send),
              style: ElevatedButton.styleFrom(
                backgroundColor: _error,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: _error.withValues(alpha: 0.3),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
