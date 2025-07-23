import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vietcook1/features/profile/presentation/controller/profile_controller.dart';

class ProfileInfo extends GetView<ProfileController> {
  final String username;
  final String bio;
  final String profileImageUrl;

  const ProfileInfo({
    super.key,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<ProfileController>(
            id: 'profile_info',
            builder: (context) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(profileImageUrl),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildStat('0', 'Followers')),
                        _buildDivider(),
                        Expanded(child: _buildStat('0', 'Following')),
                        _buildDivider(),
                        Expanded(
                          child: _buildStat(
                            controller.userRecipes.length.toString(),
                            'Recipes',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
        const SizedBox(height: 16),
        // Name & Bio
        Text(
          username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.left,
        ),
        Text(
          bio,
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4), // Giảm padding cho divider
      child: SizedBox(
        height: 24,
        child: VerticalDivider(color: Colors.grey),
      ),
    );
  }
}
