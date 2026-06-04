import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/AnimatedEgyptFlag%20.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class AboutElMontage extends StatefulWidget {
  const AboutElMontage({super.key});

  @override
  State<AboutElMontage> createState() => _AboutElMontageState();
}

class _AboutElMontageState extends State<AboutElMontage> {
  bool _expanded = false;

  int _selectedTab = 0;

  final List<String> titles = ["الرسالة", "الرؤية"];

  final List<String> content = [
    "مرحبًا بكم في مؤسسة فرسان التعافي، ملاذكم للعلاج النفسي، علاج الإدمان، وإعادة التأهيل السلوكي. "
        "احصلوا على السلام والشفاء مع فريقنا المتخصص.\n\n"
        "نحن نهدف إلى تقديم خدمات طبية ونفسية وسلوكية شاملة وآمنة بأعلى معايير الجودة.",

    "أن تصبح المؤسسة صرحاً رائداً في تقديم العلاج النفسي والتأهيل السلوكي المتكامل من خلال خدمات طبية ونفسية ذات جودة عالمية، "
        "بما يساهم في تحسين وتغيير حياة النزلاء داخل مصر والوطن العربي والشرق الأوسط.",
  ];

  @override
  Widget build(BuildContext context) {
    String currentText = content[_selectedTab];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.95),
            const Color(0xFFF8F9FA),
          ],
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Appcolors.accentColor.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// 🔹 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedEgyptFlag(),

                Text(
                  "عن المؤسسة",
                  style: TextStyle(
                    color: Appcolors.bluecolor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 15.h),

            /// 🔹 IMAGE
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Appcolors.accentColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: Image.asset(
                  "assets/image/appIcon.png",
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 180.h,
                ),
              ),
            ),

            SizedBox(height: 15.h),

            /// 🔥 PREMIUM SWITCH (FIXED)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.grey.shade100,
                border: Border.all(
                  color: Appcolors.accentColor.withOpacity(0.2),
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      /// Indicator
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        alignment: _selectedTab == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          width: constraints.maxWidth / 2,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            gradient: LinearGradient(
                              colors: [
                                Appcolors.accentColor,
                                Appcolors.accentColor.withOpacity(0.7),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Appcolors.accentColor.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Tabs
                      Row(
                        children: List.generate(2, (index) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTab = index;
                                  _expanded = false;
                                });
                              },
                              child: Container(
                                height: 40.h,
                                alignment: Alignment.center,
                                child: Text(
                                  titles[index],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: _selectedTab == index
                                        ? Colors.white
                                        : Appcolors.bluecolor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: 15.h),

            /// 🔹 TEXT CONTENT
            Text(
              currentText,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                color: Appcolors.bluecolor.withOpacity(0.9),
                height: 1.6,
              ),
            ),

            SizedBox(height: 20.h),

            /// 🔹 FEATURES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFeatureItem(
                  icon: Icons.shield,
                  text: "مرخص من وزارة الصحة",
                ),
                _buildFeatureItem(
                  icon: Icons.workspace_premium,
                  text: "خصوصية تامة",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.accentColor.withOpacity(0.1),
            Appcolors.accentColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Appcolors.accentColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              color: Appcolors.bluecolor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: Appcolors.accentColor),
        ],
      ),
    );
  }
}
