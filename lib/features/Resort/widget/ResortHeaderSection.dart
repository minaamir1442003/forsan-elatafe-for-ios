import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/AnimatedEgyptFlag2.dart';

class ResortHeaderSection extends StatelessWidget {
  const ResortHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(.95),
          ],
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Appcolors.accentColor.withOpacity(.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Animatedegyptflag2(),
          SizedBox(height: 15,),

          /// اللوجوهات
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              _buildLogo(
                "assets/image/montageno back.png",
              ),

              _buildLogo(
                "assets/image/wezare el seha.png",
              ),
            ],
          ),

          SizedBox(height: 25),

          Text(
            "منتجع فرسان التعافي",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Appcolors.bluecolor,
            ),
          ),

          SizedBox(height: 8),

          Text(
            "للراحة النفسية والتأهيل السلوكي",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
              color: Appcolors.accentColor,
            ),
          ),

          SizedBox(height: 15.h),

          Container(
            width: 120,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Appcolors.accentColor,
                  Appcolors.bluecolor,
                ],
              ),
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(String image) {
    return Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}