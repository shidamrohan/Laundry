import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry/core/theme/theme_provider.dart';

class AccessibilitySettingsScreen extends StatefulWidget {
  const AccessibilitySettingsScreen({super.key});

  @override
  State<AccessibilitySettingsScreen> createState() => _AccessibilitySettingsScreenState();
}

class _AccessibilitySettingsScreenState extends State<AccessibilitySettingsScreen> {
  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);
  static const _background = Color(0xFFF7FAFB);
  static const _success = Color(0xFF16A34A);

  // Initial states to track changes
  final int _initialTextSize = 1;
  final bool _initialHighContrast = false;
  final bool _initialBoldText = false;
  final bool _initialReduceTransparency = false;
  final bool _initialReduceMotion = false;
  final bool _initialAutoPlayAnimations = true;
  final bool _initialCaptions = false;
  final bool _initialMonoAudio = false;
  final bool _initialVisualAlerts = false;
  final bool _initialLargerTouchTargets = false;
  final bool _initialLongerTapDuration = false;
  final bool _initialVoiceControl = false;

  // Current states
  late int _textSizeIndex;
  late bool _highContrast;
  late bool _boldText;
  late bool _reduceTransparency;
  late bool _reduceMotion;
  late bool _autoPlayAnimations;
  late bool _captions;
  late bool _monoAudio;
  late bool _visualAlerts;
  late bool _largerTouchTargets;
  late bool _longerTapDuration;
  late bool _voiceControl;

  @override
  void initState() {
    super.initState();
    _textSizeIndex = _initialTextSize;
    _highContrast = _initialHighContrast;
    _boldText = _initialBoldText;
    _reduceTransparency = _initialReduceTransparency;
    _reduceMotion = _initialReduceMotion;
    _autoPlayAnimations = _initialAutoPlayAnimations;
    _captions = _initialCaptions;
    _monoAudio = _initialMonoAudio;
    _visualAlerts = _initialVisualAlerts;
    _largerTouchTargets = _initialLargerTouchTargets;
    _longerTapDuration = _initialLongerTapDuration;
    _voiceControl = _initialVoiceControl;
  }

  bool get _hasChanges {
    return _textSizeIndex != _initialTextSize ||
        _highContrast != _initialHighContrast ||
        _boldText != _initialBoldText ||
        _reduceTransparency != _initialReduceTransparency ||
        _reduceMotion != _initialReduceMotion ||
        _autoPlayAnimations != _initialAutoPlayAnimations ||
        _captions != _initialCaptions ||
        _monoAudio != _initialMonoAudio ||
        _visualAlerts != _initialVisualAlerts ||
        _largerTouchTargets != _initialLargerTouchTargets ||
        _longerTapDuration != _initialLongerTapDuration ||
        _voiceControl != _initialVoiceControl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
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
          'Accessibility',
          style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 120),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Make VOSHIFY work better for you',
                    style: TextStyle(color: _textSecondary, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 24),
                _buildVisionSection(),
                const SizedBox(height: 24),
                _buildThemeSection(context),
                const SizedBox(height: 24),
                _buildMotionSection(),
                const SizedBox(height: 24),
                _buildHearingSection(),
                const SizedBox(height: 24),
                _buildInteractionSection(),
                const SizedBox(height: 24),
                _buildScreenReaderInfo(),
              ],
            ),
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildSaveButton()),
        ],
      ),
    );
  }

  // --- Sections ---

  Widget _buildVisionSection() {
    return _buildSectionCard(
      title: 'Vision',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC5rJy77OmEHsqopsZjn69pS8yHNfJyb_oVWlGGQe_zduxbJ6kl_EVA99NM0LC0DB5i0xZ8KLftgb9r6IxPao72wRyrcwWMcAsYvRWMJ9s6_eUPMt6VdtNcuO0T_DjvZ4FGJ5E22t5YhP4uTCitlELFHmfOU5Rg9iQddh95peU7R2_raQ7PQulpLkWh_KipHM_YRe0a9Lr9r4-CpQrCvkcBIgMzQVo7CmpHR7d8y5wJjXmJBDv7w6lseqrgDExZv9yLkyK0adGheqiN',
      children: [
        _buildTextSizeControl(),
        const SizedBox(height: 16),
        _buildToggleRow('High contrast', _highContrast, (v) => setState(() => _highContrast = v)),
        _buildToggleRow('Bold text', _boldText, (v) => setState(() => _boldText = v)),
        _buildToggleRow('Reduce transparency', _reduceTransparency, (v) => setState(() => _reduceTransparency = v)),
      ],
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return _buildSectionCard(
      title: 'App Theme',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDF0_0N6c9pXm5Zq1Z8QyA0Q9UvR_FwR7uD7Kq3x2k5y4O9t2ZtKx8Vn8Rj0Xb3w_fFqM5gZ5k_hG1T_wDqWz4k9TqRjWv3m6A1b9H1qR4y0_xX9v5k_fVvWn_K_n2YfVn7w9T9w6_yZ2zVqZ_fTfX9k_y3YfX_w_wX6Yv9Qy7z9yvV_yQ1k5y_R1Tq3Q=s640',
      children: [
        DropdownButtonFormField<ThemeMode>(
          initialValue: themeProvider.themeMode,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Color(0xFFE2E8E9)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: const [
            DropdownMenuItem(value: ThemeMode.system, child: Text('System Default')),
            DropdownMenuItem(value: ThemeMode.light, child: Text('Light Theme')),
            DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark Theme')),
          ],
          onChanged: (mode) {
            if (mode != null) {
              themeProvider.setThemeMode(mode);
            }
          },
        ),
      ],
    );
  }

  Widget _buildMotionSection() {
    return _buildSectionCard(
      title: 'Motion',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBbGgfh5I41SbtIir3xIrF_r3N2ijT2oD_chqJQ8QvkNkEcnnSR4GrLWQ-hVfskra8VcJS23hpCAqPMPATaOBI7ZzqhH25N7mhYdvJWxEPgLGkkVOeS-d8epIdMokIg-K00kj8Jo2C00wbLaKDIeT67ldYkM-tSDMKTtgJ4FtRI9KTyKCbpjX64AwOun_ZDPQv5zE4wgcDqbCYefXJFrsWLqIRIdz7cEUkg_VY67c9s3_gfXJkCX8P5DLyH2T-7uINvpB01D5ztv38p',
      children: [
        _buildToggleRow('Reduce motion', _reduceMotion, (v) => setState(() => _reduceMotion = v)),
        _buildToggleRow('Auto-play animations', _autoPlayAnimations, (v) => setState(() => _autoPlayAnimations = v)),
      ],
    );
  }

  Widget _buildHearingSection() {
    return _buildSectionCard(
      title: 'Hearing',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBkNQO9BIhvso2JmCiHRLRvgqE3wNtnHUjXhPptNtGrVqY-XU7sR-MyYr81mtBCulGVffUYKnabp545wrov_YBUknJ98IUmoXxkYLHBUwu1Q2oGVsJrtXO1mffcVpJ28dvvZUG_pJTtMB9g9bfaZ5gGuwCZZgug_sbNU8YQdOjdl6gKw08E2c2XASKwlGREEQlq-7XMsm_y4E1tLy5lMdTlPAaOZbaVVgFaikac9YC9c51_HVpw7PWo76ov7m611XRNYSdCMrmKgoCp',
      children: [
        _buildToggleRow('Captions', _captions, (v) => setState(() => _captions = v)),
        _buildToggleRow('Mono audio', _monoAudio, (v) => setState(() => _monoAudio = v)),
        _buildToggleRow('Visual alerts', _visualAlerts, (v) => setState(() => _visualAlerts = v)),
      ],
    );
  }

  Widget _buildInteractionSection() {
    return _buildSectionCard(
      title: 'Interaction & Motor',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD7lU2JZMemtqdNYDCKlT-rvcO7tq9Vj725mdPr-gIL_zUGA0FZNl5NjcRLT5LGQcdyd6IKCen6vS6k6Fu2_w7dNdylXGfmbYK-SAZDd6rm645bKux1ZbVx94b13fSS6hz94XmqqBXZchVFNkHfzwEV-0hqL7mBlDXm3S8Yh5A7FnQPUl0GvUFADbs0uD5Rww-ru2ECCQjez69z7q5jhcMLnOCTDmd_lWJ0FuQyQIQ8ltEzPHXotRx4yMENwiXVtIIrTXhGO59FT6JV',
      children: [
        _buildToggleRow('Larger touch targets', _largerTouchTargets, (v) => setState(() => _largerTouchTargets = v)),
        _buildToggleRow('Longer tap duration', _longerTapDuration, (v) => setState(() => _longerTapDuration = v)),
        _buildToggleRow('Voice control', _voiceControl, (v) => setState(() => _voiceControl = v)),
      ],
    );
  }

  // --- Components ---

  Widget _buildSectionCard({required String title, required String imageUrl, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 16),
              Text(title, style: const TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextSizeControl() {
    final fontSizes = [14.0, 16.0, 18.0, 20.0];
    final previewFontSize = fontSizes[_textSizeIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('TEXT SIZE', style: TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: _surfaceAlt, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: List.generate(4, (index) {
              final isSelected = index == _textSizeIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _textSizeIndex = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected ? const [BoxShadow(color: Color(0x0A0F172A), blurRadius: 4, offset: Offset(0, 2))] : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: isSelected ? _primary : _textSecondary,
                        fontSize: fontSizes[index],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _divider),
          ),
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: _textPrimary,
              fontSize: previewFontSize,
              fontWeight: _boldText ? FontWeight.bold : FontWeight.w500,
              fontFamily: 'Plus Jakarta Sans',
            ),
            child: const Text('VOSHIFY is at your service', textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow(String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.w500))),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: _primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE5E7EB),
            thumbColor: WidgetStateProperty.all(Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenReaderInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 24, height: 24,
            decoration: BoxDecoration(color: _success.withValues(alpha: 0.1), shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(Icons.check, color: _success, size: 14),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Screen reader: Works with TalkBack & VoiceOver',
              style: TextStyle(color: _textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.8),
        border: const Border(top: BorderSide(color: _divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _hasChanges ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: _primary.withValues(alpha: 0.4),
                disabledForegroundColor: Colors.white,
                elevation: _hasChanges ? 4 : 0,
                shadowColor: _primary.withValues(alpha: 0.3),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
              ),
              child: const Text('Save changes'),
            ),
          ),
        ),
      ),
    );
  }
}
