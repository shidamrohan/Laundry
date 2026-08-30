import 'package:laundry/presentation/screens/placeholder_screen.dart';
import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  // Master
  bool _allNotifications = true;

  // Laundry Updates
  bool _pickupReminders = true;
  bool _orderStatus = true;
  bool _outForDelivery = true;
  bool _orderCompleted = true;

  // Payments & Wallet
  bool _walletActivity = true;
  bool _paymentConfirmations = true;

  // Offers
  bool _promotions = false;
  bool _couponsOffers = true;

  // Channels
  bool _push = true;
  bool _email = true;
  bool _sms = false;
  bool _whatsApp = true;

  static const _primary = Color(0xFF0EA5A4);

  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _divider = Color(0xFFE2E8E9);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  void _toggleAll(bool value) {
    setState(() {
      _allNotifications = value;
      _pickupReminders = value;
      _orderStatus = value;
      _outForDelivery = value;
      _orderCompleted = value;
      _walletActivity = value;
      _paymentConfirmations = value;
      _promotions = value;
      _couponsOffers = value;
      _push = value;
      _email = value;
      _sms = value;
      _whatsApp = value;
    });
  }

  bool get _anyEnabled =>
      _pickupReminders || _orderStatus || _outForDelivery || _orderCompleted ||
      _walletActivity || _paymentConfirmations || _promotions || _couponsOffers ||
      _push || _email || _sms || _whatsApp;

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
          icon: const Icon(Icons.arrow_back, color: _textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMasterToggleCard(),
                  const SizedBox(height: 24),
                  _buildSection('LAUNDRY UPDATES', [
                    _NotifRow(
                      icon: Icons.calendar_today,
                      title: 'Pickup reminders',
                      subtitle: 'Get alerted before your pickup',
                      value: _pickupReminders,
                      onChanged: (v) => setState(() { _pickupReminders = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.receipt_long,
                      title: 'Order status',
                      subtitle: 'Live updates on your cleaning progress',
                      value: _orderStatus,
                      onChanged: (v) => setState(() { _orderStatus = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.local_shipping,
                      title: 'Out for delivery',
                      subtitle: 'Know when your laundry is on the way',
                      value: _outForDelivery,
                      onChanged: (v) => setState(() { _outForDelivery = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.check_circle,
                      title: 'Order completed',
                      subtitle: 'Confirmations and delivery reports',
                      value: _orderCompleted,
                      onChanged: (v) => setState(() { _orderCompleted = v; _syncMaster(); }),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSection('PAYMENTS & WALLET', [
                    _NotifRow(
                      icon: Icons.account_balance_wallet,
                      title: 'Wallet activity',
                      subtitle: 'Add money and balance updates',
                      value: _walletActivity,
                      onChanged: (v) => setState(() { _walletActivity = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.payments,
                      title: 'Payment confirmations',
                      subtitle: 'Receipts and transaction alerts',
                      value: _paymentConfirmations,
                      onChanged: (v) => setState(() { _paymentConfirmations = v; _syncMaster(); }),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSection('OFFERS', [
                    _NotifRow(
                      icon: Icons.campaign,
                      title: 'Promotions',
                      subtitle: 'Seasonal sales and brand updates',
                      value: _promotions,
                      onChanged: (v) => setState(() { _promotions = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.sell,
                      title: 'Coupons & offers',
                      subtitle: 'Exclusive discounts for you',
                      value: _couponsOffers,
                      onChanged: (v) => setState(() { _couponsOffers = v; _syncMaster(); }),
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSection('CHANNELS', [
                    _NotifRow(
                      icon: Icons.notifications,
                      title: 'Push',
                      value: _push,
                      onChanged: (v) => setState(() { _push = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.mail,
                      title: 'Email',
                      value: _email,
                      onChanged: (v) => setState(() { _email = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.sms,
                      title: 'SMS',
                      value: _sms,
                      onChanged: (v) => setState(() { _sms = v; _syncMaster(); }),
                    ),
                    _NotifRow(
                      icon: Icons.chat,
                      title: 'WhatsApp',
                      value: _whatsApp,
                      onChanged: (v) => setState(() { _whatsApp = v; _syncMaster(); }),
                    ),
                  ]),
                ],
              ),
            ),
          ),

          // Sticky Bottom
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildSaveButton(),
          ),
        ],
      ),
    );
  }

  void _syncMaster() {
    _allNotifications = _anyEnabled;
  }

  Widget _buildMasterToggleCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('All notifications', style: TextStyle(color: _textPrimary, fontSize: 17, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Turn off to pause everything', style: TextStyle(color: _textSecondary, fontSize: 14)),
              ],
            ),
          ),
          Switch(
            value: _allNotifications,
            onChanged: _toggleAll,
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

  Widget _buildSection(String title, List<_NotifRow> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(title, style: const TextStyle(color: _textSecondary, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        ),
        Container(
          decoration: BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Color(0x0F0F172A), blurRadius: 8, offset: Offset(0, 2))],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: rows.asMap().entries.map((entry) {
              final isLast = entry.key == rows.length - 1;
              return Column(
                children: [
                  _buildToggleRow(entry.value),
                  if (!isLast) const Divider(color: _divider, height: 1),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow(_NotifRow row) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: _surfaceAlt,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(row.icon, color: _primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(row.title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                if (row.subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(row.subtitle!, style: const TextStyle(color: _textSecondary, fontSize: 13)),
                ],
              ],
            ),
          ),
          Switch(
            value: row.value,
            onChanged: row.onChanged,
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

  Widget _buildSaveButton() {
    return Container(
      decoration: const BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [BoxShadow(color: Color(0x140F172A), blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderScreen())); },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: _primary.withValues(alpha: 0.3),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Save changes'),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotifRow {
  const _NotifRow({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
}
