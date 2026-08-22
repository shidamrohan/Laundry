/// app_widgets.dart
/// ─────────────────────────────────────────────────────────────────────────────
/// Global shared widget library for VOSHIFY.
///
/// Import once per screen:
///   import 'package:laundry/presentation/widgets/app_widgets.dart';
///
/// Contents:
///   - AppColors       : Brand-safe static color tokens
///   - VoshifyAppBar   : Standard back-button app bar
///   - VoshifyCTAButton: Full-width primary action button
///   - VoshifySection  : Section header with optional badge
///   - VoshifyInfoRow  : Icon + label + value row
///   - VoshifyTagChip  : Selectable chip (tag selector)
///   - VoshifySettingTile: Settings row with leading icon and chevron
///   - VoshifyEmptyState : Centred empty-state placeholder
///   - BottomSheetHandle : Standard drag handle for bottom sheets
///   - VoshifyDivider  : Thin divider with standard color
///   - VoshifyBadge    : Colored pill badge
/// ─────────────────────────────────────────────────────────────────────────────

library;

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// COLOR TOKENS
// ─────────────────────────────────────────────────────────────────────────────

/// Brand color palette. Use these instead of hardcoded hex values.
class AppColors {
  AppColors._();

  // Brand
  static const primary   = Color(0xFF0EA5A4);
  static const secondary = Color(0xFF2563EB);
  static const purple    = Color(0xFF7C3AED);

  // Surfaces
  static const surface        = Color(0xFFFFFFFF);
  static const surfaceAlt     = Color(0xFFEFF6F6);
  static const background     = Color(0xFFF7FAFB);
  static const cardBorder     = Color(0xFFE2E8E9);

  // Text
  static const textPrimary    = Color(0xFF0F172A);
  static const textSecondary  = Color(0xFF64748B);
  static const textMuted      = Color(0xFF94A3B8);

  // Semantic
  static const success = Color(0xFF16A34A);
  static const warning = Color(0xFFF59E0B);
  static const error   = Color(0xFFDC2626);

  // Dark surface variants (used in dark-themed screens)
  static const darkSurface    = Color(0xFF0B1220);
  static const darkSurfaceAlt = Color(0xFF0F172A);
  static const darkCard       = Color(0xFF1E293B);
}

// ─────────────────────────────────────────────────────────────────────────────
// APP BAR
// ─────────────────────────────────────────────────────────────────────────────

/// Standard VOSHIFY app bar.
///
/// ```dart
/// Scaffold(
///   appBar: VoshifyAppBar(title: 'Settings'),
/// )
/// ```
class VoshifyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VoshifyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.onBack,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
  });

  final String title;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.surface;
    final fg = foregroundColor ?? AppColors.primary;

    return AppBar(
      backgroundColor: bg,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: fg),
        onPressed: onBack ?? () => Navigator.pop(context),
        splashRadius: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: fg,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.3,
        ),
      ),
      actions: actions,
      bottom: bottom ?? PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: AppColors.cardBorder),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CTA BUTTON
// ─────────────────────────────────────────────────────────────────────────────

/// Full-width primary action button used across all screens.
///
/// ```dart
/// VoshifyCTAButton(label: 'Save address', onPressed: _save)
/// ```
class VoshifyCTAButton extends StatelessWidget {
  const VoshifyCTAButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.color,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool enabled;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? AppColors.primary;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: (enabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          disabledBackgroundColor: bg.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: bg.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22, height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM CTA FOOTER
// ─────────────────────────────────────────────────────────────────────────────

/// Sticky bottom footer wrapping a [VoshifyCTAButton].
///
/// ```dart
/// Scaffold(
///   bottomNavigationBar: VoshifyBottomCTA(
///     label: 'Proceed', onPressed: _next,
///   ),
/// )
/// ```
class VoshifyBottomCTA extends StatelessWidget {
  const VoshifyBottomCTA({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.enabled = true,
    this.color,
    this.child,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool enabled;
  final Color? color;

  /// Optionally replace the entire CTA area with a custom widget.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: const Border(top: BorderSide(color: AppColors.cardBorder)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: child ??
            VoshifyCTAButton(
              label: label,
              onPressed: onPressed,
              icon: icon,
              isLoading: isLoading,
              enabled: enabled,
              color: color,
            ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION HEADER
// ─────────────────────────────────────────────────────────────────────────────

/// A section title with optional pill badge.
///
/// ```dart
/// VoshifySection(title: 'Upcoming deliveries')
/// VoshifySection(title: 'Milestones', badge: '3/5 Complete')
/// ```
class VoshifySection extends StatelessWidget {
  const VoshifySection({
    super.key,
    required this.title,
    this.badge,
    this.trailing,
    this.titleStyle,
  });

  final String title;
  final String? badge;
  final Widget? trailing;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: titleStyle ??
                const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
          ),
        ),
        if (badge != null) VoshifyBadge(label: badge!),
        ?trailing,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INFO ROW
// ─────────────────────────────────────────────────────────────────────────────

/// Icon + label + value row used in summary cards.
///
/// ```dart
/// VoshifyInfoRow(icon: Icons.calendar_today, label: 'PICKUP', value: 'Mon & Thu')
/// ```
class VoshifyInfoRow extends StatelessWidget {
  const VoshifyInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceAlt,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor ?? AppColors.textSecondary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TAG CHIP
// ─────────────────────────────────────────────────────────────────────────────

/// Selectable chip used for tag pickers (Home / Work / Favorite…).
///
/// ```dart
/// VoshifyTagChip(label: 'Home', icon: Icons.home, isSelected: true, onTap: …)
/// ```
class VoshifyTagChip extends StatelessWidget {
  const VoshifyTagChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final sc = selectedColor ?? AppColors.primary;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? sc : AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? sc : AppColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : AppColors.textPrimary,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SETTINGS TILE
// ─────────────────────────────────────────────────────────────────────────────

/// A settings list row with icon, title, optional subtitle and chevron.
///
/// ```dart
/// VoshifySettingTile(
///   icon: Icons.notifications,
///   title: 'Notifications',
///   subtitle: 'Manage alerts',
///   onTap: () => Navigator.push(…),
/// )
/// ```
class VoshifySettingTile extends StatelessWidget {
  const VoshifySettingTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconColor,
    this.titleColor,
    this.trailing,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Widget? trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final ic = iconColor ?? AppColors.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ic.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(icon, color: ic, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor ?? AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              trailing ??
                  Icon(
                    Icons.chevron_right,
                    color: (titleColor ?? AppColors.textSecondary)
                        .withValues(alpha: 0.6),
                    size: 20,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// EMPTY STATE
// ─────────────────────────────────────────────────────────────────────────────

/// Generic empty-state widget with icon, title, subtitle and optional CTA.
///
/// ```dart
/// VoshifyEmptyState(
///   icon: Icons.inbox,
///   title: 'No orders yet',
///   subtitle: 'Your first order is just a tap away.',
///   cta: 'Browse services',
///   onCta: () => …,
/// )
/// ```
class VoshifyEmptyState extends StatelessWidget {
  const VoshifyEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.cta,
    this.onCta,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? cta;
  final VoidCallback? onCta;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.surfaceAlt,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ],
            if (cta != null) ...[
              const SizedBox(height: 24),
              VoshifyCTAButton(label: cta!, onPressed: onCta),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOTTOM SHEET HANDLE
// ─────────────────────────────────────────────────────────────────────────────

/// Standard drag handle at the top of bottom sheets.
class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key, this.topPadding = 12});
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: 4),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.cardBorder,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DIVIDER
// ─────────────────────────────────────────────────────────────────────────────

/// Thin divider using the standard border color.
class VoshifyDivider extends StatelessWidget {
  const VoshifyDivider({super.key, this.indent = 0, this.endIndent = 0});
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.cardBorder,
      height: 1,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BADGE
// ─────────────────────────────────────────────────────────────────────────────

/// Colored pill badge.
///
/// ```dart
/// VoshifyBadge(label: '3/5 Complete')
/// VoshifyBadge(label: 'DEFAULT', color: AppColors.primary)
/// ```
class VoshifyBadge extends StatelessWidget {
  const VoshifyBadge({
    super.key,
    required this.label,
    this.color,
    this.textColor,
  });

  final String label;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? AppColors.primary;
    final fg = textColor ?? bg;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: fg.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FORM FIELD
// ─────────────────────────────────────────────────────────────────────────────

/// Standard text form field used across address and profile forms.
///
/// ```dart
/// VoshifyFormField(
///   label: 'Flat / House no. *',
///   icon: Icons.apartment,
///   controller: _flatController,
///   required: true,
/// )
/// ```
class VoshifyFormField extends StatelessWidget {
  const VoshifyFormField({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.required = false,
    this.maxLines = 1,
    this.hintText,
    this.prefixWidget,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.initialValue,
  });

  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool required;
  final int maxLines;
  final String? hintText;
  final Widget? prefixWidget;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        keyboardType: keyboardType,
        readOnly: readOnly,
        maxLines: maxLines,
        onChanged: onChanged,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        validator: validator ??
            (required
                ? (val) {
                    if (val == null || val.trim().isEmpty) {
                      return '${label.replaceAll(' *', '')} is required';
                    }
                    return null;
                  }
                : null),
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
          labelStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: const TextStyle(
            color: AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: prefixWidget ?? Icon(icon, color: AppColors.textSecondary),
          border: InputBorder.none,
          errorStyle: const TextStyle(fontSize: 10),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
