import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class image_and_service extends StatelessWidget {
  const image_and_service({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        image: DecorationImage(
          image: AssetImage("assets/image/image mix in home.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// 🔹 Badge with gradient
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Appcolors.accentColor,
                    Appcolors.accentColor.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(40.r),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.accentColor.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Text(
                "طريقك الي السلام و التعافي",
                style: TextStyle(
                  color: Appcolors.bluecolor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            SizedBox(height: 20.h),
            
            /// 🔹 Main Title
            Text(
              "نحن هنا لدعم رحلتك\nنحو التعافي",
              textAlign: TextAlign.right,
              style: TextStyle(
                height: 1.2,
                fontSize: 28.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 15.h),
            
            /// 🔹 Subtitle
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Text(
                "بيئة هادئة وآمنة للشفاء بإطلالات طبيعية خلابة\nوخدمات فندقية متكاملة و اشراف طبي كامل",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            
            SizedBox(height: 25.h),
            
            /// 🔹 Decorative element
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 50.w,
                height: 3.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.accentColor,
                      Appcolors.accentColor.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}