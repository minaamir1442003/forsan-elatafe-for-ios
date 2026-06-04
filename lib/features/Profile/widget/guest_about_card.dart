import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class GuestAboutCard extends StatelessWidget {
  const GuestAboutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Appcolors.cardBackground,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: Appcolors.accentColorNew,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '🏥 عن المركز',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'مركز فرسان التعافي هو مركز متخصص في الطب النفسي وعلاج الإدمان، يقدم خدمات علاجية متكاملة تحت إشراف أفضل الأطباء والمعالجين النفسيين.',
            style: TextStyle(fontSize: 15, height: 1.5),
          ),
        ],
      ),
    );
  }
}
