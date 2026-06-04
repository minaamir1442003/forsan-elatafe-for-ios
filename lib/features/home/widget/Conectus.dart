import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:url_launcher/url_launcher.dart';

class Conectus extends StatelessWidget {
  const Conectus({super.key});

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
            Appcolors.bluecolor.withOpacity(.95),
            const Color(0xFF1A3A55),
          ],
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Appcolors.accentColor.withOpacity(.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            /// TITLE
            Center(
              child: Text(
                "تواصل معنا",
                style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 25.h),

            /// WHATSAPP CARD
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: Colors.green.withOpacity(.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(.4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(Icons.chat, color: Colors.white),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "تواصل عبر واتساب",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "اضغط على أيقونة القسم للتواصل المباشر",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 18),

                  /// الأقسام الثلاثة بتصميم محسن
                  Column(
                    children: [
                      _contactCard(
                        icon: Icons.account_balance_rounded,
                        title: "المؤسسة",
                        subtitle: "للتواصل مع إدارة المؤسسة",
                        phone: "01105445839",
                        internationalPhone: "201105445839",
                        color: const Color(0xFF4CAF50),
                      ),
                      SizedBox(height: 12.h),
                      _contactCard(
                        icon: Icons.local_hospital_rounded,
                        title: "الوحدة",
                        subtitle: "للتواصل مع الوحدة  بابو زعبل",
                        phone: "01105445838",
                        internationalPhone: "201105445838",
                        color: const Color(0xFF2196F3),
                      ),
                      SizedBox(height: 12.h),
                      _contactCard(
                        icon: Icons.spa,
                        title: "المنتجع",
                        subtitle: "للتواصل مع المنتجع بسقارة",
                        phone: "01155665660",
                        internationalPhone: "201155665660",
                        color: const Color(0xFFFF9800),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 18),

            /// WEBSITE CARD
            GestureDetector(
              onTap: () => _launchWebsite("https://recovery-knights.vercel.app/"),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.1),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: Appcolors.accentColor.withOpacity(.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Appcolors.accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.public,
                        color: Appcolors.bluecolor,
                        size: 18.sp,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "الموقع الإلكتروني",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "اضغط لزيارة الموقع",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 كارد كل قسم بشكل منفصل وجذاب
  Widget _contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String phone,
    required String internationalPhone,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _openWhatsApp(internationalPhone),
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: color.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // أيقونة القسم
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.7)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),
            
            // الرقم ومعلوماته
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        phone,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.chat_bubble_outline,
                        color: color,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openWhatsApp(String phone) async {
    final Uri uri = Uri.parse("https://wa.me/$phone");
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}