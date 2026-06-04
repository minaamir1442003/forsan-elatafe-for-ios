import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/Profile/widget/guest_banner.dart';
import 'package:forsan_eltafe/features/Profile/widget/guest_info_section.dart';
import 'package:forsan_eltafe/features/Profile/widget/guest_login_prompt.dart';
import 'package:forsan_eltafe/features/Profile/widget/guest_record_card.dart';
import '../data/guest_data.dart';


class GuestProfileScreen extends StatelessWidget {
  const GuestProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;

    // تحديد قيمة الـ padding بناءً على عرض الشاشة
    double horizontalPadding = screenWidth > 500 ? 20 : 5;
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.visibility_rounded, color: Appcolors.accentColorNew, size: 25.sp),
            const SizedBox(width: 14),
             Text(
              'وضع الضيف',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Appcolors.cardBackground,
        elevation: 0,
        toolbarHeight: 35.w,
        foregroundColor: Appcolors.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 32),
          onPressed: () => Navigator.pop(context)
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              const GuestBanner(),
              const SizedBox(height: 20),
              const GuestInfoSection(),
              const SizedBox(height: 30),
              // عنوان السجلات
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Appcolors.accentColorNew,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      '📋 نماذج السجلات الطبية',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Appcolors.accentColorNew.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        '${GuestData.records.length} نموذج',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Appcolors.accentColorNew,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // السجلات
              // ignore: unnecessary_to_list_in_spreads
              ...GuestData.records.map((record) => GuestRecordCard(record: record)).toList(),
              const SizedBox(height: 10),
              const GuestLoginPrompt(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}