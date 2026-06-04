import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/Aboutmedical.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/Medical_cards.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/VideoWidget.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/buildHeaderSection.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/conect_us.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/daily_schedule.dart';
import 'package:forsan_eltafe/features/MedicalUnit/widget/vision_section.dart';

class MedicalUnitPage extends StatefulWidget {
  @override
  State<MedicalUnitPage> createState() => _MedicalUnitPageState();
}

class _MedicalUnitPageState extends State<MedicalUnitPage>
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
    double horizontalPadding = screenWidth > 500 ? 30 : 20;

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
                  SizedBox(height: 10),
                  VideoWidget(),
                  SizedBox(height: 20),
                  buildHeaderSection(),

                  SizedBox(height: 20),
                  MedicalCards(),
                  SizedBox(height: 20),
                  Aboutmedical(),
                  SizedBox(height: 20),
                  ConnectUs(),
                  SizedBox(height: 20),
                  TaskTimelineWidget(),
                  SizedBox(height: 20),
                  VisionSection(),
                SizedBox(height: 110),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
