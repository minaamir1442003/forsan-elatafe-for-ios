import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/Resort/widget/conectustomontage.dart';
import 'package:forsan_eltafe/features/Resort/widget/infoelmontage.dart';
import 'package:forsan_eltafe/features/Resort/widget/HeroImageSection.dart';
import 'package:forsan_eltafe/features/Resort/widget/ResortCards.dart';
import 'package:forsan_eltafe/features/Resort/widget/ResortHeaderSection.dart';
import 'package:forsan_eltafe/features/Resort/widget/ResortVideoPage.dart';
import 'package:forsan_eltafe/features/Resort/widget/ResortVisionSection.dart';
import 'package:forsan_eltafe/features/Resort/widget/TaskTimeline.dart';

class ResortPage extends StatefulWidget {
  const ResortPage({super.key});

  @override
  State<ResortPage> createState() => _ResortPageState();
}

class _ResortPageState extends State<ResortPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth > 500 ? 30.w : 20.w;

    return Scaffold(
      backgroundColor: Appcolors.greycolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12),

                  const HeroImageSection(),

                  SizedBox(height: 20),

                  const ResortHeaderSection(),
                  

                  SizedBox(height: 20),

                  const ResortVideoWidget(),
                  SizedBox(height: 28),
                  ResortCards(),
                  SizedBox(height: 28),
                  const Infoelmontage(),
                  SizedBox(height: 28),
                  Conectustomontage(),
                  SizedBox(height: 25,),
                  _buildSectionHeader(
                    title: "البرنامج اليومي العلاجي",
                    color: Appcolors.bluecolor,
                  ),
                  SizedBox(height: 20),
                  const TaskTimelineWidget(),
                  SizedBox(height: 20,),
                  ResortVisionSection(),
                SizedBox(height: 110),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          height: 28.h,
          width: 4.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Appcolors.accentColor,
                Appcolors.accentColor.withOpacity(0.5),
              ],
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }
}
