import 'package:flutter/material.dart';
import '../models/app_theme.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int? reviews;
  final double size;
  final Color color;

  const RatingWidget({
    super.key,
    required this.rating,
    this.reviews,
    this.size = 14,
    this.color = AppTheme.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: color, size: size),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: size - 1,
            fontWeight: FontWeight.w600,
            color: color == AppTheme.gold ? Colors.white : AppTheme.textPrimary,
          ),
        ),
        if (reviews != null) ...[
          const SizedBox(width: 3),
          Text(
            '(${_formatReviews(reviews!)})',
            style: TextStyle(
              fontSize: size - 2,
              color: color == AppTheme.gold ? Colors.white70 : AppTheme.textLight,
            ),
          ),
        ],
      ],
    );
  }

  String _formatReviews(int count) =>
      count >= 1000 ? '${(count / 1000).toStringAsFixed(1)}k' : count.toString();
}
