import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/navigation_bar/navigation_bar.dart';

class GuestLoginPrompt extends StatelessWidget {
  const GuestLoginPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.accentColorNew.withOpacity(0.12),
            Appcolors.accentColorNew.withOpacity(0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: Appcolors.accentColorNew.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
           Icon(
            Icons.favorite_rounded,
            size: 60.sp,
            color: Appcolors.accentColorNew,
          ),
          const SizedBox(height: 7),
           Text(
            '🌟 هل تريد معرفة المزيد؟',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'سجل دخولك الآن لمشاهدة جميع تفاصيل ملفك الطبي\nالحقيقي والمتابعة مع فريق العلاج',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
            
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigationBar(initialIndex: 3),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
              decoration: BoxDecoration(
                color: Appcolors.accentColorNew,
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.accentColorNew.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.login_rounded, size: 20.sp, color: Colors.white),
                  SizedBox(width: 13),
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}