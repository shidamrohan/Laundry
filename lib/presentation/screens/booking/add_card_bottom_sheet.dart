import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void showAddCardBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const AddCardBottomSheet(),
  );
}

class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  
  bool _saveCard = true;
  String _cardName = 'AARAV KUMAR';
  String _cardNumber = '•••• •••• •••• 4242';

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _cardName = _nameController.text.isNotEmpty ? _nameController.text.toUpperCase() : 'YOUR NAME';
      });
    });
    _numberController.addListener(() {
      setState(() {
        String digitsOnly = _numberController.text.replaceAll(RegExp(r'\D'), '');
        if (digitsOnly.isNotEmpty) {
          // Format with spaces
          StringBuffer formatted = StringBuffer();
          for (int i = 0; i < digitsOnly.length; i++) {
            if (i > 0 && i % 4 == 0) formatted.write(' ');
            formatted.write(digitsOnly[i]);
          }
          _cardNumber = formatted.toString();
        } else {
          _cardNumber = '•••• •••• •••• 4242';
        }
      });
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    _nameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // Use max height constraint but allow it to size to content if keyboard is up
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 48, height: 6,
                  decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(3)),
                ),
              ),
              Flexible(
                child: ListView(
                  padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset > 0 ? bottomInset + 24 : 120),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildCardPreview(),
                    const SizedBox(height: 32),
                    _buildForm(),
                    const SizedBox(height: 24),
                    _buildTrustIndicators(),
                  ],
                ),
              ),
            ],
          ),
          
          // Sticky CTA Button
          if (bottomInset == 0) // Hide sticky button if keyboard is up
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0x00FFFFFF)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                      Icon(Icons.add_card, size: 20),
                      SizedBox(width: 8),
                      Text('Add card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Add card', style: TextStyle(color: Color(0xFF0F172A), fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
            SizedBox(width: 8),
            Icon(Icons.lock, color: Color(0xFF0EA5A4), size: 20),
          ],
        ),
        const SizedBox(height: 4),
        const Text('Secured by 256-bit encryption', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
      ],
    );
  }

  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF0EA5A4), Color(0xFF7C3AED)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x330F172A), blurRadius: 16, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chip simulation
              Container(
                width: 48, height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xCCFBBF24),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 4)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: double.infinity, height: 1, color: const Color(0x33000000)),
                    Container(width: double.infinity, height: 1, color: const Color(0x33000000)),
                    Container(width: double.infinity, height: 1, color: const Color(0x33000000)),
                  ],
                ),
              ),
              const Text('Orio', style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, letterSpacing: -0.5)),
            ],
          ),
          const SizedBox(height: 32),
          Text(_cardNumber, style: const TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'monospace', letterSpacing: 3.0, shadows: [Shadow(color: Color(0x40000000), offset: Offset(0, 2), blurRadius: 4)])),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CARD HOLDER', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  const SizedBox(height: 2),
                  Text(_cardName, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.0)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('EXPIRES', style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                      SizedBox(height: 2),
                      Text('12/28', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.0)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Master card style logo
                  Container(
                    width: 32, height: 32,
                    decoration: const BoxDecoration(color: Color(0x33FFFFFF), shape: BoxShape.circle),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(left: 4, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Color(0xCCEF4444), shape: BoxShape.circle))),
                        Positioned(right: 4, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: Color(0xCCEAB308), shape: BoxShape.circle))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildTextField(
          controller: _numberController,
          hintText: 'Card number',
          icon: Icons.credit_card,
          suffixIcon: Icons.contactless,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _nameController,
          hintText: 'Cardholder name',
          icon: Icons.person,
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _expiryController,
                hintText: 'MM/YY',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.datetime,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _cvvController,
                hintText: 'CVV',
                icon: Icons.lock,
                suffixIcon: Icons.help_outline,
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Save this card securely', style: TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 2),
                Text('For faster payments next time', style: TextStyle(color: Color(0xFF64748B), fontSize: 12)),
              ],
            ),
            CupertinoSwitch(
              value: _saveCard,
              activeColor: const Color(0xFF0EA5A4),
              onChanged: (val) => setState(() => _saveCard = val),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6F6), // surface-alt
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textCapitalization: textCapitalization,
        style: const TextStyle(color: Color(0xFF0F172A), fontSize: 16, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0x8064748B), fontSize: 16),
          prefixIcon: Icon(icon, color: const Color(0xFF64748B), size: 20),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: const Color(0xFF64748B), size: 20) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }

  Widget _buildTrustIndicators() {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE2E8E9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _buildTrustLogo('https://lh3.googleusercontent.com/aida-public/AB6AXuB6Y8x7DCLXtbwDP79IEFi5ljeb-M1GtNJZ0pm1QzBYFFsMbW4AxEq82IO5D3jD6usCgck51TNk_4drblUYzchwGIaJeXUseQh7lu5HhRQMuYimffyYxkcruvDRNMPQnMva2Y_UxzNLUyQ6Uxg87epGuczR6DgJ9huRUpAcOeSWSVJbqGnvGF-ev4A7kt5aiRUchh8mxC3FLQTSXsxWko4YmpFszi8k-GPgPzM8I6bqnZUJglsUqL2jWLxzOV6kIcNy3vZRG9Qok67u', 12),
              const SizedBox(width: 12),
              _buildTrustLogo('https://lh3.googleusercontent.com/aida-public/AB6AXuB6849_vZlaOyy_rqKWNIDETc-8vNicpAGCKe38QIGAARp8XvSEi7uHCLCzMhZZnAK2v2kCBwyIjhfqMTzSPxIjiL_Sx63od5Af5m6K44XODV4Kdn5N1Oui6UUfPRxpSTHRHaHLX9WsFwlrja2kCIPNCDCJTOWp-ADsOpGJGg9P5Uqzz6IJLUQfqX5vqugSpK0H79E56BMHFF7UhLcd9iOo9VeCxRlYGrVPQ2FjktvG4SIc5uybQfZYEV4MBBBjugy57Vr0zCCkRvBp', 20),
              const SizedBox(width: 12),
              _buildTrustLogo('https://lh3.googleusercontent.com/aida-public/AB6AXuBETYUs_H655ScmN2Y9ZKGKzjaLCDSwhwQSMA7hvchTQDhPQP_Vt6xYCLc4qVtotQA0r_7O3Pq5U9hRxuvSo7rY7oaB0bG501QPuPtJUy8k3_e0NSUm8tsoLoXK1SqaYijxlAUXuLeIMwcQD6cEjOlVO1EcT-dYjbxskQpJMSMOdHkFPtvkLCnnN6I3UuBwZw6wLd5ZWdnJnZ79Npv7-tTWKaAy7TwIQUtQF3rN56yIGqtpY4qF9tbjhGUpCJlKhzr4p1FKsrvCRTVv', 12),
              const SizedBox(width: 12),
              _buildTrustLogo('https://lh3.googleusercontent.com/aida-public/AB6AXuCvMHn6v8wa-sJxbYvsbLqVfnOROI-SYXFiTi3rksvV2_CYYoySg3LG_7zg8wKlN4SbJd7j2MhvLCj6dxoPrUY_nIA-B5vYzt1mNRM6jJZf6Yt-KU-kc277T1ctDQQvNh6PqrmqixM9Y9kl0ccCx59kW_7hz6PpsRsqg3nnAvh5KFSiIeDXA2_7v3gqq2cnTl4hb309Y29ajzT6tWH4ZXiaDPeIFExQ5lLDgXCjL_HwTWK6Yl4ZIY5I_bvMAUDm8TFCJ53kz8-ZIQVb', 16),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0x4D16A34A)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: const [
                Icon(Icons.verified_user, color: Color(0xFF16A34A), size: 12),
                SizedBox(width: 4),
                Text('PCI-DSS', style: TextStyle(color: Color(0xFF16A34A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustLogo(String url, double height) {
    return Image.network(
      url,
      height: height,
      color: Colors.grey, // Grayscale effect
      colorBlendMode: BlendMode.saturation,
    );
  }
}
