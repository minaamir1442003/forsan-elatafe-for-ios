import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class Aboutmedical extends StatelessWidget {
  const Aboutmedical({super.key});

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
        children: [
          /// العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "عن صرحنا الطبي",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.bluecolor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "بيئة آمنة للتعافي المستدام",
                    style: TextStyle(
                      color: Appcolors.accentColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(width: 12),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.accentColor.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    Icons.security_rounded,
                    size: 28.sp,
                    color: Appcolors.accentColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          /// الوصف
          Text(
            "تعتبر وحدة فرسان التعافي صرحاً طبياً متخصصاً يهدف إلى تقديم أرقى مستويات الرعاية النفسية وعلاج الإدمان، مع الالتزام بتوفير بيئة آمنة ومهنية تساعد المرضى في رحلة التعافي واستعادة التوازن النفسي والاجتماعي.",
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.6,
              color: Appcolors.bluecolor.withOpacity(0.9),
            ),
            textAlign: TextAlign.right,
          ),

          SizedBox(height: 20),

          /// بروتوكول التعاون
          _buildProtocolCard(),
        ],
      ),
    );
  }

  Widget _buildProtocolCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Appcolors.bluecolor, Appcolors.bluecolor.withOpacity(.9)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Appcolors.bluecolor.withOpacity(.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.workspace_premium_rounded,
              color: Colors.white,
              size: 30.sp,
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "إنجاز وتعاون استثنائي",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  "نفخر بكونه أول بروتوكول تعاون في مصر بين مؤسسة فرسان التعافي والمركز الطبي لسكك حديد مصر، بهدف تقديم خدمات علاجية ونفسية متكاملة وفق أعلى معايير الرعاية.",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.95),
                    height: 1.6,
                    fontSize: 13.sp,
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
