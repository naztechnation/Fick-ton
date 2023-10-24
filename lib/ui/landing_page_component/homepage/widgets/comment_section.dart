import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final String title;
  final String comment;

  CommentSection({required this.title, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              width: 31,
              height: 31,
              decoration: const BoxDecoration(
                color: AppColors.lightPrimary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  title.isNotEmpty ? title[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          comment,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
