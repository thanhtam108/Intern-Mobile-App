import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String username;
  final String bio;
  final String profileImageUrl;

  ProfileInfo({
    super.key,
    required this.username,
    required this.bio,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Căn trái toàn bộ
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildStat('3,990', 'Followers'),
                  _buildDivider(),
                  _buildStat('1,224', 'Following'),
                  _buildDivider(),
                  _buildStat('9,290', 'Recipes'),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Name & Bio
        Text(
          username,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.left,
        ),
        Text(
          bio,
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.left,
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Căn trái
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 24,
        child: VerticalDivider(color: Colors.grey),
      ),
    );
  }
}
