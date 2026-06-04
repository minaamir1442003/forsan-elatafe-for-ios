import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class GuestInfoSection extends StatelessWidget {
  const GuestInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Appcolors.infoColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Appcolors.infoColor.withOpacity(0.2), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '📌 ماذا ستجد في ملفك الطبي؟',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: Appcolors.infoColor,
            ),
          ),
          const SizedBox(height: 28),
          _buildInfoCard(
            icon: Icons.medical_information_rounded,
            title: '📋 التقارير الطبية',
            color: Appcolors.infoColor,
            description: 'تشمل حالتك العامة، المزاج، النوم، الشهية، الأعراض الذهانية، والشكاوى الطبية. يساعدك هذا القسم على متابعة حالتك الصحية اليومية.',
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            icon: Icons.psychology_rounded,
            title: '🧠 تقارير الأخصائي النفسي',
            color: Appcolors.successColor,
            description: 'يشمل شدة الأعراض، المشكلة الأساسية، مدى البصيرة، الاستجابة للعلاج، التقدم المحرز، والخطة العلاجية القادمة.',
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            icon: Icons.shield_rounded,
            title: '🛡️ تقارير المشرف',
            color: Appcolors.warningColor,
            description: 'يتضمن نوع الجلسة، سلوكك وتفاعلك، الأحداث والمخاطر إن وجدت، والإجراءات المتخذة.',
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            icon: Icons.health_and_safety_rounded,
            title: '💉 التقارير التمريضية',
            color: const Color(0xFFE74C3C),
            description: 'يظهر العلامات الحيوية (ضغط، نبض، حرارة)، الأعراض الجسدية، والأدوية التي تم إعطاؤها.',
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Appcolors.accentColorNew.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb_rounded, color: Appcolors.accentColorNew, size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '💡 هذه البيانات تساعدك على متابعة تقدمك في رحلة التعافي، وتتيح لك التواصل بشكل أفضل مع فريق العلاج.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Appcolors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required Color color,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.2), width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30.sp, color: color),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.right,
                  style:  TextStyle(
                    fontSize: 13.sp,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}