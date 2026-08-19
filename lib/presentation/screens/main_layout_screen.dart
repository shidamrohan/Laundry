import 'package:flutter/material.dart';
import 'package:laundry/presentation/screens/home/home_screen.dart';
import 'package:laundry/presentation/screens/booking/your_orders_screen.dart';
import 'package:laundry/presentation/screens/home/search_screen.dart';
import 'package:laundry/presentation/screens/home/offers_screen.dart';
import 'package:laundry/presentation/screens/booking/profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentNavIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const YourOrdersScreen(),
    const SearchScreen(), // Search is handled by FAB, but kept here for index alignment if needed
    const OffersScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentNavIndex == 2 ? 0 : _currentNavIndex, // Keep previous screen if search is tapped
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_filled, 'label': 'Home', 'filled': true},
      {'icon': Icons.receipt_long_outlined, 'label': 'Orders', 'filled': false},
      {'icon': null, 'label': 'Search', 'filled': false}, // FAB center
      {'icon': Icons.percent_outlined, 'label': 'Offers', 'filled': false},
      {'icon': Icons.person_outline, 'label': 'Profile', 'filled': false},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF0B1220) : Colors.white,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor.withValues(alpha: 0.08))),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 16, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              if (i == 2) {
                // FAB center button
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    );
                  },
                  child: Transform.translate(
                    offset: const Offset(0, -14),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0EA5A4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF0B1220) : Colors.white, 
                          width: 3
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0EA5A4).withValues(alpha: 0.4),
                            blurRadius: 16,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Icon(Icons.search, color: Colors.white, size: 26),
                    ),
                  ),
                );
              }

              final isActive = _currentNavIndex == i;
              final icon = items[i]['icon'] as IconData;
              final label = items[i]['label'] as String;
              final isDark = Theme.of(context).brightness == Brightness.dark;

              return GestureDetector(
                onTap: () {
                  setState(() => _currentNavIndex = i);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF0EA5A4).withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: isActive ? const Color(0xFF0EA5A4) : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                        size: 24,
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Color(0xFF0EA5A4),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
