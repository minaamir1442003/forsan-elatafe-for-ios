import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:url_launcher/url_launcher.dart';

class Infoelmontage extends StatelessWidget {
  const Infoelmontage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
            const Color(0xFFF8F9FA),
          ],
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Appcolors.accentColor.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "الإقامة الفندقية",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Appcolors.bluecolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Container(
                height: 30,
                width: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.accentColor,
                      Appcolors.accentColor.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // الوصف
          Text(
            "إقامة فاخرة تجمع بين الراحة والخصوصية، مصممة لدعم رحلتك نحو التعافي النفسي في بيئة هادئة ومريحة",
            style: TextStyle(
              fontSize: 14.sp,
              color: Appcolors.bluecolor.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 20),

          // المميزات
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: const [
              FeatureItem(
                icon: Icons.watch_later_outlined,
                text: "خدمة ٢٤ ساعة",
              ),
              FeatureItem(icon: Icons.wifi, text: "إنترنت سريع"),
              FeatureItem(icon: Icons.bed_outlined, text: "مراتب طبية"),
              FeatureItem(icon: Icons.spa_outlined, text: "مستحضرات عضوية"),
            ],
          ),

          SizedBox(height: 24),

          _buildMedicalSection(),
        ],
      ),
    );
  }

  Widget _buildMedicalSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.bluecolor.withOpacity(0.08),
            Appcolors.accentColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: Appcolors.accentColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Appcolors.accentColor.withOpacity(.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "الرعاية الطبية والإشراف",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Appcolors.bluecolor,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.health_and_safety, color: Appcolors.accentColor),
            ],
          ),

          SizedBox(height: 15),

          _infoRow(Icons.verified_user, "مرخص من وزارة الصحة والسكان المصرية"),

          _infoRow(Icons.medical_services, "إشراف طبي كامل على مدار الساعة"),

          _infoRow(
            Icons.psychology_alt,
            "فريق من الأطباء والأخصائيين النفسيين والمعالجين السلوكيين",
          ),

          _infoRow(Icons.workspace_premium, "خبرة تمتد لأكثر من 15 عاماً"),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13.sp,
                color: Appcolors.bluecolor,
                height: 1.5,
              ),
            ),
          ),

          SizedBox(width: 10),

          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Appcolors.accentColor.withOpacity(.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18.sp, color: Appcolors.accentColor),
          ),
        ],
      ),
    );
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const FeatureItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // ignore: deprecated_member_use
            Appcolors.greycolor.withOpacity(0.3),
            // ignore: deprecated_member_use
            Appcolors.greycolor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Appcolors.accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: Appcolors.bluecolor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, color: Appcolors.accentColor, size: 18.r),
        ],
      ),
    );
  }
}
