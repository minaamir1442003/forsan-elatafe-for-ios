import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class hafeofrow extends StatelessWidget {
  final IconData icon;
  final Color iconcolor;
  final String text1;
  final String text2;
  
  const hafeofrow({
    super.key,
    required this.icon,
    required this.iconcolor,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.95),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Appcolors.greycolor.withOpacity(0.5),
                    Appcolors.greycolor.withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Icon(
                icon,
                color: iconcolor,
                size: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              text1,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              text2,
              style: TextStyle(
                fontSize: 13.sp,
                color: Appcolors.bluecolor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}