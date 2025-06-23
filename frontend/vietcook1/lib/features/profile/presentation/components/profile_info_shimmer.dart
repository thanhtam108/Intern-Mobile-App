import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileInfoShimmer extends StatelessWidget {
  const ProfileInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          const CircleAvatar(radius: 40, backgroundColor: Colors.white),
          const SizedBox(height: 12),
          Container(height: 16, width: 120, color: Colors.white),
          const SizedBox(height: 8),
          Container(height: 12, width: 180, color: Colors.white),
        ],
      ),
    );
  }
}
