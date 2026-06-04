import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class VisionSection extends StatelessWidget {
  const VisionSection({super.key});

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
            const Color(0xFF0A2A45),
          ],
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Appcolors.accentColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 190,
                height: 150,
                padding: EdgeInsets.all(18.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                
                ),
                child: Image.asset("assets/image/wehdano back.png",fit: BoxFit.cover,width: 150,height: 150,)
              ),
              Positioned(
                bottom: 7,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Appcolors.accentColor,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 16.sp,
                    color: Appcolors.bluecolor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            "هدفنا هو توفير بيئة استشفائية متكاملة",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            "نرافقكم في كل خطوة نحو التعافي النفسي المستدام والنمو الشخصي",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15.h),
          Container(
            width: 60.w,
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
    );
  }
}