import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoSwitch
import 'package:laundry/presentation/screens/booking/add_photos_screen.dart';

class CareInstructionsScreen extends StatefulWidget {
  const CareInstructionsScreen({super.key});

  @override
  State<CareInstructionsScreen> createState() => _CareInstructionsScreenState();
}

class _CareInstructionsScreenState extends State<CareInstructionsScreen> {
  final TextEditingController _notesController = TextEditingController();
  int _charCount = 0;
  bool _isFolding = true; // true = Fold, false = Hang
  bool _isHandleWithCare = false;

  final List<String> _quickNotes = [
    'Remove coffee stain',
    'Do not bleach',
    'Separate white clothes',
    'Fold shirts',
    'Hang trousers',
    'Gentle wash only',
    'Extra starch',
    'No fabric softener',
  ];

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() {
      setState(() {
        _charCount = _notesController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _addQuickNote(String note) {
    final currentText = _notesController.text;
    if (currentText.isEmpty) {
      _notesController.text = note;
    } else {
      _notesController.text = '$currentText, $note';
    }
    // Move cursor to end
    _notesController.selection = TextSelection.fromPosition(TextPosition(offset: _notesController.text.length));
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
              padding: EdgeInsets.only(top: topPadding + 64, bottom: 120),
              children: [
                _buildHeroText(),
                _buildInputArea(),
                _buildQuickAdd(),
                _buildPreferences(),
                _buildHelperNote(),
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
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
                  splashRadius: 24,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                const Text('Care Instructions', style: TextStyle(color: Color(0xFF0EA5A4), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
              ],
            ),
          ),
          // Progress Bar (Step 4 - 66%)
          Container(
            height: 4,
            width: double.infinity,
            decoration: const BoxDecoration(color: Color(0xFFEFF6F6)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.66,
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

  Widget _buildHeroText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Tell us how to treat your clothes',
            style: TextStyle(color: Color(0xFF0F172A), fontSize: 28, fontWeight: FontWeight.w800, height: 1.2, letterSpacing: -0.5),
          ),
          SizedBox(height: 8),
          Text(
            'We want to make sure your items get the care they deserve.',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8E9)),
          boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 16, offset: Offset(0, 4))],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _notesController,
              maxLines: 5,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText: 'Add any fabric care notes, stain details or handling requests…',
                hintStyle: TextStyle(color: Color(0x8064748B), fontSize: 16, height: 1.5),
                border: InputBorder.none,
                counterText: '', // Hide default counter
              ),
              style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.only(top: 8),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0x80E2E8E9))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$_charCount/500', style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, fontWeight: FontWeight.w600)),
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(color: const Color(0xFFEFF6F6), shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.mic, color: Color(0xFF0EA5A4), size: 20),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      splashRadius: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAdd() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Quick add', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Container(width: 4, height: 4, decoration: const BoxDecoration(color: Color(0xFF0EA5A4), shape: BoxShape.circle)),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: _quickNotes.map((note) => _buildQuickNoteChip(note)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickNoteChip(String note) {
    return InkWell(
      onTap: () => _addQuickNote(note),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6F6),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0x1A0EA5A4)),
        ),
        child: Text(note, style: const TextStyle(color: Color(0xFF0EA5A4), fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildPreferences() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Folding preference', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          // Segmented Control
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6F6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8E9)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isFolding = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: _isFolding ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: _isFolding ? const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 8, offset: Offset(0, 2))] : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.local_laundry_service, color: _isFolding ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 18),
                          const SizedBox(width: 8),
                          Text('Fold', style: TextStyle(color: _isFolding ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isFolding = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: !_isFolding ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: !_isFolding ? const [BoxShadow(color: Color(0x1A0F172A), blurRadius: 8, offset: Offset(0, 2))] : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.checkroom, color: !_isFolding ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), size: 18),
                          const SizedBox(width: 8),
                          Text('Hang', style: TextStyle(color: !_isFolding ? const Color(0xFF0EA5A4) : const Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Handle with care toggle
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8E9)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(color: const Color(0x1A7C3AED), borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.auto_awesome, color: Color(0xFF7C3AED), size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Handle with care', style: TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 2),
                      Text('Extra delicate treatment', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                    ],
                  ),
                ),
                CupertinoSwitch(
                  value: _isHandleWithCare,
                  activeTrackColor: const Color(0xFF0EA5A4),
                  onChanged: (val) => setState(() => _isHandleWithCare = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelperNote() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x80EFF6F6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0x4DE2E8E9)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.info_outline, color: Color(0xFF64748B), size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'These notes are shared with your laundry expert to ensure the highest quality service.',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 14, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Color(0x1A0F172A), blurRadius: 24, offset: Offset(0, -8))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPhotosScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEFF6F6),
                  foregroundColor: const Color(0xFF64748B),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.close, size: 20),
                    SizedBox(width: 8),
                    Text('Skip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPhotosScreen()));
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
                    Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
