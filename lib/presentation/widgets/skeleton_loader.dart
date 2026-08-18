import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  const SkeletonContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12.0,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    // We try to detect dark mode to adjust the shimmer colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        margin: margin,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class HomeSkeletonLoader extends StatelessWidget {
  const HomeSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header / Location
          const SkeletonContainer(width: 200, height: 24),
          const SizedBox(height: 8),
          const SkeletonContainer(width: 150, height: 16),
          const SizedBox(height: 24),

          // Search Bar
          const SkeletonContainer(width: double.infinity, height: 50, borderRadius: 25),
          const SizedBox(height: 24),

          // Categories Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) => const Column(
              children: [
                SkeletonContainer(width: 60, height: 60, borderRadius: 30),
                SizedBox(height: 8),
                SkeletonContainer(width: 40, height: 12),
              ],
            )),
          ),
          const SizedBox(height: 32),

          // Banner
          const SkeletonContainer(width: double.infinity, height: 140, borderRadius: 20),
          const SizedBox(height: 32),

          // Recent Orders
          const SkeletonContainer(width: 120, height: 20),
          const SizedBox(height: 16),
          const SkeletonContainer(width: double.infinity, height: 100, borderRadius: 16),
          const SizedBox(height: 12),
          const SkeletonContainer(width: double.infinity, height: 100, borderRadius: 16),
        ],
      ),
    );
  }
}
