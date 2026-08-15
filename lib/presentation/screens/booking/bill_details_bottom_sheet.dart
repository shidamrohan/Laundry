import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/booking/payment_screen.dart';

void showBillDetailsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const BillDetailsBottomSheet(),
  );
}

class BillDetailsBottomSheet extends StatelessWidget {
  const BillDetailsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag Handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40, height: 6,
                decoration: BoxDecoration(color: const Color(0xFFE2E8E9), borderRadius: BorderRadius.circular(3)),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bill details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Color(0xFF64748B)),
                    style: IconButton.styleFrom(backgroundColor: const Color(0xFFEFF6F6)),
                  ),
                ],
              ),
            ),
            
            // Scrollable Content
            Flexible(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildRow('Item total', '₹948'),
                  const SizedBox(height: 16),
                  _buildRow('Service charge', '₹0'),
                  const SizedBox(height: 16),
                  _buildRow('Taxes & fees', '₹47'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery fee', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                      Row(
                        children: const [
                          Text('₹40', style: TextStyle(color: Color(0xFF64748B), fontSize: 14, decoration: TextDecoration.lineThrough)),
                          SizedBox(width: 8),
                          Text('FREE', style: TextStyle(color: Color(0xFF16A34A), fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildRow('Express charges', '₹99'),
                  
                  const SizedBox(height: 24),
                  
                  _buildSavingRow(Icons.confirmation_number, 'Coupon (ORIO150)', '−₹150'),
                  const SizedBox(height: 16),
                  _buildSavingRow(Icons.account_balance_wallet, 'Wallet credit', '−₹100'),
                  
                  const SizedBox(height: 24),
                  // Dashed divider
                  CustomPaint(painter: DashedLinePainter(), size: const Size(double.infinity, 1)),
                  const SizedBox(height: 24),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('To pay', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      Text('₹844', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0x1A16A34A),
                      border: Border.all(color: const Color(0x3316A34A)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('You saved ₹250 on this order 🎉', style: TextStyle(color: Color(0xFF16A34A), fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  const Center(child: Text('Inclusive of all taxes.', style: TextStyle(color: Color(0xFF64748B), fontSize: 12))),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            
            // Footer Action
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                  // Navigate to payment if not already on it
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0EA5A4),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: const Color(0x330EA5A4),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Proceed to pay ₹844', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 12),
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

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
        Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildSavingRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF16A34A), size: 16),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Color(0xFF16A34A), fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        Text(value, style: const TextStyle(color: Color(0xFF16A34A), fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFE2E8E9)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var max = size.width;
    var dashWidth = 8.0;
    var dashSpace = 8.0;
    double startX = 0;

    while (startX < max) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
