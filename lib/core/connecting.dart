import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            // ignore: deprecated_member_use
            Appcolors.bluecolor.withOpacity(0.95),
            const Color(0xFF1A3A55),
          ],
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Appcolors.accentColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // العنوان
            Center(
              child: Text(
                    "تواصل معنا",
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
            ),
            SizedBox(height: 20),

            // العنوان
            _buildInfoRow(
              icon: Icons.location_on_sharp,
              title: "العنوان",
              value: "أبو صير، الجيزة، مصر",
              showMap: true,
            ),

            SizedBox(height: 15),

            // الخريطة
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse(
                  "https://maps.app.goo.gl/DCCNSGndsEV7i5o47",
                );
                if (!await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                )) {
                  debugPrint("Could not open map");
                }
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        "assets/image/Map location of Abu Sir.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        // height: double.infinity,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.accentColor,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.location_on,
                          size: 30.sp,
                          color: Appcolors.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // رقم الهاتف
            _buildContactRow(
              icon: Icons.phone_in_talk_outlined,
              title: "اتصال بنا",
              value: "01145150842",
              onTap: () => _callNumber("01145150842"),
              isPhone: true,
            ),

            SizedBox(height: 15),

            // الموقع الإلكتروني
            _buildContactRow(
              icon: Icons.public,
              title: "الموقع الإلكتروني",
              value: "www.resort-name.com",
              onTap: () => _launchWebsite("https://recovery-knights.vercel.app/"),
              isPhone: false,
            ),

            SizedBox(height: 20),

            // الفاصل
            Divider(
              thickness: 1.5,
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.3),
              height: 1,
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(
                  icon: Icons.facebook,
                  url: "https://www.facebook.com/recoveryknightsunits/",
                  color: Colors.blue.shade700,
                ),
                SizedBox(width: 15.w),
                _buildSocialIcon(
                  icon: FontAwesomeIcons.instagram,
                  url: "https://www.instagram.com/recoveryknightsunit/",
                  color: Colors.purple.shade300,
                ),
                SizedBox(width: 15.w),
                _buildSocialIcon(
                  icon: FontAwesomeIcons.tiktok,
                  url: "https://www.tiktok.com/@recoveryknightsunit",
                  color: Colors.black,
                ),
                SizedBox(width: 15.w),
                _buildSocialIcon(
                  icon: FontAwesomeIcons.youtube,
                  url: "https://www.youtube.com/@recoveryknightsunit",
                  color: Colors.red.shade700,
                ),
                SizedBox(width: 15.w),
                _buildSocialIcon(
                  icon: FontAwesomeIcons.snapchat,
                  url: "https://www.snapchat.com/add/recoveryknight",
                  color: Colors.yellow.shade700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
    bool showMap = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // ignore: deprecated_member_use
                Appcolors.greycolor.withOpacity(0.3),
                // ignore: deprecated_member_use
                Appcolors.greycolor.withOpacity(0.1),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Appcolors.accentColor.withOpacity(0.3),
                blurRadius: 5,
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 24.sp,
            color: Appcolors.accentColor,
          ),
        ),
      ],
    );
  }

  // Widget لعرض معلومات التواصل (هاتف أو موقع)
  Widget _buildContactRow({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
    required bool isPhone,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: isPhone
          ? () {
              // نسخ الرقم عند الضغط المطول
              // يمكن إضافة Snackbar للإشعار
            }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            // ignore: deprecated_member_use
            color: Appcolors.accentColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Appcolors.accentColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Appcolors.accentColor.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 22.sp,
                color: Appcolors.bluecolor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget لأيقونات السوشيال ميديا
  Widget _buildSocialIcon({
    required IconData icon,
    required String url,
    required Color color,
  }) {
    return InkWell(
      onTap: () => launchSocial(url),
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // ignore: deprecated_member_use
              Colors.white.withOpacity(0.15),
              Colors.white.withOpacity(0.05),
            ],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: Appcolors.accentColor.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Appcolors.accentColor,
          size: 20.sp,
        ),
      ),
    );
  }

  void _callNumber(String number) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    debugPrint("Call result: $res");
  }

  Future<void> _launchWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      debugPrint('Could not launch $url');
    }
  }
}

Future<void> launchSocial(String url) async {
  final Uri uri = Uri.parse(url);

  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}