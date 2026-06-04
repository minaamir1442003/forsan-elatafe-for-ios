import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/Profile/data/guest_translations.dart';

class GuestRecordCard extends StatelessWidget {
  final Map<String, dynamic> record;

  const GuestRecordCard({super.key, required this.record});

  (Color, IconData, String) _getRoleInfo(String role) {
    switch (role) {
      case 'doctor':
        return (Appcolors.infoColor, Icons.medical_information_rounded, '🩺 كشف طبي');
      case 'specialist':
        return (Appcolors.successColor, Icons.psychology_rounded, '🧠 جلسة أخصائي نفسي');
      case 'supervisor':
        return (Appcolors.warningColor, Icons.shield_rounded, '🛡️ تقرير مشرف');
      case 'nurse':
        return (const Color(0xFFE74C3C), Icons.health_and_safety_rounded, '💉 تقرير تمريض');
      default:
        return (Appcolors.accentColorNew, Icons.description_rounded, '📄 سجل طبي');
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}/${date.month}/${date.day}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = record['data'] as Map<String, dynamic>;
    final createdBy = record['createdBy'] as Map<String, dynamic>;
    final role = createdBy['role'] ?? '';
    final (roleColor, roleIcon, roleTitle) = _getRoleInfo(role);
    final formattedDate = _formatDate(record['date'] ?? '');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: roleColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(roleIcon, color: roleColor, size: 32.sp),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      roleTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18.sp,
                        color: Appcolors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'بواسطة: ${createdBy['name']} • $formattedDate',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 30, thickness: 1),
          ...data.entries.map((entry) {
            if (entry.value == null || entry.value.toString().isEmpty) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140.w,
                    child: Text(
                      GuestTranslations.translate(entry.key),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: roleColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: roleColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: roleColor.withOpacity(0.12), width: 1),
                      ),
                      child: Text(
                        entry.value.toString(),
                        style:  TextStyle(fontSize: 13.sp, height: 1.4),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}