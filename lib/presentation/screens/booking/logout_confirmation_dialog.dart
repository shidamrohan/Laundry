import 'package:flutter/material.dart';
import 'dart:ui';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  static const _primary = Color(0xFF0EA5A4);
  static const _surface = Color(0xFFFFFFFF);
  static const _surfaceAlt = Color(0xFFEFF6F6);
  static const _textPrimary = Color(0xFF0F172A);
  static const _textSecondary = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 0,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(color: Color(0x260F172A), blurRadius: 40, offset: Offset(0, 20), spreadRadius: -12),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 64, height: 64,
              decoration: const BoxDecoration(color: _surfaceAlt, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: _primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: const Icon(Icons.logout, color: _primary, size: 28),
              ),
            ),
            const SizedBox(height: 24),
            // Content
            const Text(
              'Log out of VOSHIFY?',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
            ),
            const SizedBox(height: 8),
            const Text(
              'You can always log back in with your number.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 14, height: 1.4),
            ),
            const SizedBox(height: 32),
            // Buttons Stack
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Perform logout action
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: _primary.withValues(alpha: 0.3),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                ),
                child: const Text('Log out'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Perform logout all devices action
                  Navigator.pop(context, true);
                },
                icon: const Icon(Icons.devices, size: 18),
                label: const Text('Log out of all devices'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _surfaceAlt,
                  foregroundColor: _textPrimary,
                  elevation: 0,
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextButton(
                onPressed: () => Navigator.pop(context, false),
                style: TextButton.styleFrom(
                  foregroundColor: _textSecondary,
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Helper function to show the blur logout dialog
Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.4), // The BackdropFilter is applied underneath in a custom way if needed, or we just rely on barrierColor
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: const LogoutConfirmationDialog(),
      );
    },
  );
}
