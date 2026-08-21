import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/location/add_address_screen.dart';

class AddressBookScreen extends StatefulWidget {
  const AddressBookScreen({super.key});

  @override
  State<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);
  static const _error = Color(0xFFDC2626);

  // Mutable address list — starts with two demo entries
  final List<Map<String, dynamic>> _addresses = [
    {
      'icon': Icons.home,
      'tag': 'Home',
      'isDefault': true,
      'name': 'Aarav Kumar',
      'phone': '+91 98765 43210',
      'address': '21 Brigade Road, Shanthala Nagar, Bengaluru 560025',
    },
    {
      'icon': Icons.work,
      'tag': 'Work',
      'isDefault': false,
      'name': 'Aarav Kumar',
      'phone': '+91 98765 43210',
      'address': 'Prestige Tech Park, Marathahalli, Outer Ring Rd, Bengaluru',
    },
  ];

  IconData _tagIcon(String tag) {
    switch (tag) {
      case 'Home': return Icons.home;
      case 'Work': return Icons.work;
      case 'Favorite': return Icons.favorite;
      default: return Icons.location_on;
    }
  }

  Future<void> _openAddAddress() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const AddAddressScreen()),
    );
    if (result != null && mounted) {
      setState(() {
        _addresses.add({
          'icon': _tagIcon(result['tag'] ?? 'Other'),
          'tag': result['tag'] ?? 'Other',
          'isDefault': false,
          'name': result['name'] ?? 'New Address',
          'phone': result['phone'] ?? '',
          'address': result['address'] ?? '',
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Address saved successfully!'),
          backgroundColor: _primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete address?'),
        content: const Text('Are you sure you want to remove this address?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _addresses.removeAt(index));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address deleted'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Delete', style: TextStyle(color: _error)),
          ),
        ],
      ),
    );
  }

  void _setDefault(int index) {
    setState(() {
      for (int i = 0; i < _addresses.length; i++) {
        _addresses[i]['isDefault'] = (i == index);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_addresses[index]['tag']} set as default'),
        backgroundColor: _primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
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
          'Address book',
          style: TextStyle(color: _primary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: _addresses.isEmpty
          ? _buildEmptyState()
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 40),
              children: [
                _buildAddNewAddressButton(),
                const SizedBox(height: 16),
                ...List.generate(_addresses.length, (index) {
                  final addr = _addresses[index];
                  return Column(
                    children: [
                      _buildAddressCard(
                        index: index,
                        icon: addr['icon'] as IconData,
                        title: addr['tag'] as String,
                        isDefault: addr['isDefault'] as bool,
                        nameAndPhone: '${addr['name']} · ${addr['phone']}',
                        address: addr['address'] as String,
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
                _buildFooterIllustration(),
              ],
            ),
      floatingActionButton: _addresses.isEmpty
          ? FloatingActionButton.extended(
              onPressed: _openAddAddress,
              backgroundColor: _primary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add address', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96, height: 96,
            decoration: BoxDecoration(color: _surfaceAlt, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(Icons.location_off, color: _primary, size: 48),
          ),
          const SizedBox(height: 24),
          const Text('No saved addresses', style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Add your home, work, or any other\ndelivery address here.', textAlign: TextAlign.center, style: TextStyle(color: _textSecondary, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildAddNewAddressButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openAddAddress,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _primary.withValues(alpha: 0.5), width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(color: _surfaceAlt, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Icon(Icons.add, color: _primary),
              ),
              const SizedBox(width: 12),
              const Text(
                'Add new address',
                style: TextStyle(color: _primary, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required int index,
    required IconData icon,
    required String title,
    bool isDefault = false,
    required String nameAndPhone,
    required String address,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDefault ? _primary.withValues(alpha: 0.4) : _divider),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48, height: 48,
                decoration: const BoxDecoration(color: _surfaceAlt, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(icon, color: _primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                        if (isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: const Text('DEFAULT', style: TextStyle(color: _primary, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(nameAndPhone, style: const TextStyle(color: _textSecondary, fontSize: 14)),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: _textSecondary),
                onSelected: (val) {
                  if (val == 'default') _setDefault(index);
                  if (val == 'delete') _deleteAddress(index);
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'default', child: Text('Set as default')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: _error))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            address,
            style: const TextStyle(color: _textPrimary, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 12),
          const Divider(color: _divider, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildActionButton('Set as Default', _primary, () => _setDefault(index)),
              const SizedBox(width: 16),
              _buildActionButton('Delete', _error, () => _deleteAddress(index)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildFooterIllustration() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          const Icon(Icons.location_on, color: _textSecondary, size: 48),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Save multiple addresses for home, work, and family for a faster checkout experience.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
