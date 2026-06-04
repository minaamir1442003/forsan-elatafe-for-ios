import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class ResortVisionSection extends StatelessWidget {
  const ResortVisionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Appcolors.bluecolor,
            const Color(0xFF0B314F),
          ],
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Appcolors.accentColor.withOpacity(.25),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 30,
      ),
      child: Column(
        children: [

          /// الصورة
          Stack(
            clipBehavior: Clip.none,
            children: [

              Container(
                width: 170,
                height: 170,
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/image/montageno back.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              Positioned(
                bottom: -10,
                right: -10,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Appcolors.accentColor,
                    boxShadow: [
                      BoxShadow(
                        color: Appcolors.accentColor.withOpacity(.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.spa,
                    color: Appcolors.bluecolor,
                    size: 22.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 25),

          /// العنوان
          Text(
            "رحلة نحو التعافي والراحة النفسية",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.5,
            ),
          ),

          SizedBox(height: 14),

          /// الوصف
          Text(
            "نوفر بيئة علاجية متكاملة تجمع بين الراحة، الخصوصية، والرعاية الطبية المتخصصة لمساعدتك على استعادة التوازن النفسي والجسدي.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(.9),
              height: 1.8,
            ),
          ),

          SizedBox(height: 20),

          /// الإحصائيات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              _item(
                icon: Icons.workspace_premium,
                value: "15+",
                title: "سنة خبرة",
              ),

              _item(
                icon: Icons.medical_services,
                value: "24/7",
                title: "إشراف طبي",
              ),

              _item(
                icon: Icons.groups,
                value: "100%",
                title: "رعاية كاملة",
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Container(
            width: 90,
            height: 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Appcolors.accentColor,
                  Appcolors.accentColor.withOpacity(.2),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required String value,
    required String title,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Appcolors.accentColor,
          size: 24.sp,
        ),

        SizedBox(height: 8),

        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),

        SizedBox(height: 4),

        Text(
          title,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }
}