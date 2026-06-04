import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/AnimatedEgyptFlag%20.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/home/widget/Conectus.dart';
import 'package:forsan_eltafe/features/home/widget/aboutelmontage.dart';
import 'package:forsan_eltafe/features/home/widget/image_and_service.dart';
import 'package:forsan_eltafe/features/home/widget/therapeutic_programs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // تحديد قيمة الـ padding بناءً على عرض الشاشة
    double horizontalPadding = screenWidth > 500 ? 30 : 20;
    return Scaffold(
      backgroundColor: Appcolors.greycolor,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                const SizedBox(height: 10),
              
                SizedBox(height: 10),
                image_and_service(),
                SizedBox(height: 15),
                // Row(
                //   children: [
                //     hafeofrow(
                //       icon: Icons.spa,
                //       iconcolor: Appcolors.accentColor,
                //       text1: "حالة البرنامج",
                //       text2: "نشط - الأسبوع 3",
                //     ),
                //     SizedBox(width: 10),
                //     hafeofrow(
                //       icon: Icons.date_range,
                //       iconcolor: Appcolors.bluecolor,
                //       text1: "الموعد القادم",
                //       text2: "غداً، 10:00 ص",
                //     ),
                //   ],
                // ),
                AboutElMontage(),
                SizedBox(height: 15),
                TherapeuticPrograms(),
                SizedBox(height: 15),
                Conectus(),
                SizedBox(height: 75.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
