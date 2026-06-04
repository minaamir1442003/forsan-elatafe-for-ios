import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectUs extends StatelessWidget {
  const ConnectUs({super.key});

  final String phone = "01105445838";
  final String mapUrl = "https://maps.app.goo.gl/DCCNSGndsEV7i5o47";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
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
            color: Appcolors.accentColor.withOpacity(0.15),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          /// ================= HEADER =================
          _buildHeader(),

          SizedBox(height: 20),

          /// ================= PHONE CARD =================
          _buildPhoneCard(),

          SizedBox(height: 18),

          /// ================= MAP =================
          _buildMap(),

          SizedBox(height: 18),

          /// ================= SOCIAL =================
          Center(child: _buildSocial()),
        ],
      ),
    );
  }

  /// ================= HEADER =================
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "تواصل معنا",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Appcolors.bluecolor,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              "الرد خلال 24 ساعة - دعم مستمر",
              style: TextStyle(
                fontSize: 12.sp,
                color: Appcolors.accentColor,
              ),
            ),
          ],
        ),
        SizedBox(width: 10.w),
        Icon(
          Icons.support_agent_rounded,
          color: Appcolors.accentColor,
          size: 28.sp,
        ),
      ],
    );
  }

  /// ================= PHONE =================
  Widget _buildPhoneCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [

          Text(
            phone,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Appcolors.bluecolor,
              letterSpacing: 1,
            ),
          ),

          SizedBox(height: 12.h),

          Row(
            children: [
              Expanded(
                child: _btn(
                  title: "اتصال",
                  icon: Icons.call,
                  color: Appcolors.bluecolor,
                  onTap: () => _call(phone),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _btn(
                  title: "واتساب",
                  icon: Icons.chat,
                  color: Colors.green,
                  onTap: () => _whatsapp(phone),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// ================= MAP =================
  Widget _buildMap() {
    return GestureDetector(
      onTap: () => _openUrl(mapUrl),
      child: Container(
        height: 160.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
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
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on,
                      color: Appcolors.accentColor),
                  SizedBox(width: 6.w),
                  Text(
                    "اضغط لفتح الموقع",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= SOCIAL =================
  Widget _buildSocial() {
    return Column(
      children: [

        Text(
          "تابعنا على السوشيال ميديا",
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: 12),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _social(FontAwesomeIcons.facebook,
                "https://www.facebook.com/recoveryknightsunits/", Colors.blue),

            _social(FontAwesomeIcons.instagram,
                "https://www.instagram.com/recoveryknightsunit/", Colors.purple),

            _social(FontAwesomeIcons.tiktok,
                "https://www.tiktok.com/@recoveryknightsunit", Colors.black),

            _social(FontAwesomeIcons.youtube,
                "https://www.youtube.com/@recoveryknightsunit", Colors.red),

            _social(FontAwesomeIcons.snapchat,
                "https://www.snapchat.com/add/recoveryknight", Colors.amber),
          ],
        ),

        SizedBox(height: 8),

        Text(
          "اضغط على أي أيقونة للانتقال إلى الصفحة الرسمية",
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// ================= BUTTON =================
  Widget _btn({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.85)],
          ),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18.sp),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= SOCIAL ITEM =================
  Widget _social(IconData icon, String url, Color color) {
    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
            )
          ],
        ),
        child: Icon(icon, color: color, size: 28.sp),
      ),
    );
  }

  /// ================= FUNCTIONS =================
  void _call(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  void _whatsapp(String number) async {
    final url = Uri.parse("https://wa.me/2$number");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}