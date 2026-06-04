import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class HeroImageSection extends StatelessWidget {
  const HeroImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: Image.asset(
              "assets/montaga/montaga1.jpeg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient محسن
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.4, 0.7, 1.0],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "منتجع فرسان التعافي للطب النفسي و علاج الادمان و التاهيل السلوكي",
                  style: TextStyle(
                    color: Colors.white,
                  
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  textAlign:TextAlign.right ,
                ),
                SizedBox(height: 5.h),
                Text(
                  "تجربة استثنائية للراحة النفسية",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: 50.w,
                  height: 2.h,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
