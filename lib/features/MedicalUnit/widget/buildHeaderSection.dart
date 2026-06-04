import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/AnimatedEgyptFlag2.dart';

Widget buildHeaderSection() {
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

        /// اللوجوهات فوق
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            _buildLogo(
              "assets/image/wehdano back.png",
            ),

            _buildLogo(
              "assets/image/logo sekkak haded masr.png",
            ),
          ],
        ),

        SizedBox(height: 25.h),

        Text(
          "وحدة فرسان التعافي",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Appcolors.bluecolor,
          ),
        ),

        SizedBox(height: 8.h),

        Text(
          "للطب النفسي وعلاج الإدمان",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: Appcolors.accentColor,
          ),
        ),

        SizedBox(height: 15.h),

        Container(
          width: 120.w,
          height: 4.h,
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
    width: 130,
    height: 130,
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.2),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Image.asset(
      image,
      fit: BoxFit.contain, // مهم جدًا
    ),
  );
}