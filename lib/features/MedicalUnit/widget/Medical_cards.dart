import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicalCards extends StatefulWidget {
  const MedicalCards({super.key});

  @override
  State<MedicalCards> createState() => _ResortCardsState();
}

class _ResortCardsState extends State<MedicalCards> {
  final PageController _pageController = PageController(viewportFraction: 0.75);

  // صور وأسماء مناسبة لمستشفى فرسان التعافي للعلاج النفسي وعلاج الإدمان
  final List<Map<String, String>> items = const [
    {
      "image": "assets/wehda/wehda1.jpeg",
      "title": "رحلة التعافي",
      "tag": "برنامج الإقامة الكاملة",
      "subtitle": "دعم نفسي متكاصل 24/7",
    },
    {
      "image": "assets/wehda/wehda2.jpeg",
      "title": "العلاج الجماعي",
      "tag": "جلسات دعم نفسي",
      "subtitle": "نتعافى معاً",
    },
    {
      "image": "assets/wehda/wehda3.jpeg",
      "title": "استشارات فردية",
      "tag": "جلسات خاصة",
      "subtitle": "مع نخبة من الأطباء",
    },
    {
      "image": "assets/wehda/wehda4.jpeg",
      "title": "التأمل والاسترخاء",
      "tag": "علاج تكميلي",
      "subtitle": "للسكينة والطمأنينة",
    },
    {
      "image": "assets/wehda/wehda5.jpeg",
      "title": "الدعم العائلي",
      "tag": "برنامج العائلة",
      "subtitle": "معاً للشفاء",
    },
    {
      "image": "assets/wehda/wehda6.jpeg",
      "title": "رحلة التعافي",
      "tag": "برنامج الإقامة الكاملة",
      "subtitle": "دعم نفسي متكاصل 24/7",
    },
    {
      "image": "assets/wehda/wehda7.jpeg",
      "title": "العلاج الجماعي",
      "tag": "جلسات دعم نفسي",
      "subtitle": "نتعافى معاً",
    },
    {
      "image": "assets/wehda/wehda8.jpeg",
      "title": "استشارات فردية",
      "tag": "جلسات خاصة",
      "subtitle": "مع نخبة من الأطباء",
    },
    {
      "image": "assets/wehda/wehda9.jpeg",
      "title": "التأمل والاسترخاء",
      "tag": "علاج تكميلي",
      "subtitle": "للسكينة والطمأنينة",
    },
    {
      "image": "assets/wehda/wehda10.jpeg",
      "title": "الدعم العائلي",
      "tag": "برنامج العائلة",
      "subtitle": "معاً للشفاء",
    },
    {
      "image": "assets/wehda/wehda11.jpeg",
      "title": "رحلة التعافي",
      "tag": "برنامج الإقامة الكاملة",
      "subtitle": "دعم نفسي متكاصل 24/7",
    },
    {
      "image": "assets/wehda/wehda12.jpeg",
      "title": "العلاج الجماعي",
      "tag": "جلسات دعم نفسي",
      "subtitle": "نتعافى معاً",
    },
    {
      "image": "assets/wehda/wehda13.jpeg",
      "title": "استشارات فردية",
      "tag": "جلسات خاصة",
      "subtitle": "مع نخبة من الأطباء",
    },
    {
      "image": "assets/wehda/wehda14.jpeg",
      "title": "التأمل والاسترخاء",
      "tag": "علاج تكميلي",
      "subtitle": "للسكينة والطمأنينة",
    },
    {
      "image": "assets/wehda/wehda15.jpeg",
      "title": "الدعم العائلي",
      "tag": "برنامج العائلة",
      "subtitle": "معاً للشفاء",
    },
    {
      "image": "assets/wehda/wehda16.jpeg",
      "title": "رحلة التعافي",
      "tag": "برنامج الإقامة الكاملة",
      "subtitle": "دعم نفسي متكاصل 24/7",
    },
    {
      "image": "assets/wehda/wehda17.jpeg",
      "title": "العلاج الجماعي",
      "tag": "جلسات دعم نفسي",
      "subtitle": "نتعافى معاً",
    },
    {
      "image": "assets/wehda/wehda18.jpeg",
      "title": "استشارات فردية",
      "tag": "جلسات خاصة",
      "subtitle": "مع نخبة من الأطباء",
    },
    {
      "image": "assets/wehda/wehda19.jpeg",
      "title": "التأمل والاسترخاء",
      "tag": "علاج تكميلي",
      "subtitle": "للسكينة والطمأنينة",
    },
    {
      "image": "assets/wehda/wehda20.jpeg",
      "title": "الدعم العائلي",
      "tag": "برنامج العائلة",
      "subtitle": "معاً للشفاء",
    },
    {
      "image": "assets/wehda/wehda21.jpeg",
      "title": "استشارات فردية",
      "tag": "جلسات خاصة",
      "subtitle": "مع نخبة من الأطباء",
    },
    {
      "image": "assets/wehda/wehda22.jpeg",
      "title": "التأمل والاسترخاء",
      "tag": "علاج تكميلي",
      "subtitle": "للسكينة والطمأنينة",
    },
    {
      "image": "assets/wehda/wehda23.jpeg",
      "title": "الدعم العائلي",
      "tag": "برنامج العائلة",
      "subtitle": "معاً للشفاء",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350, // زودت شوية الارتفاع عشان يناسب النصوص الإضافية
      child: PageView.builder(
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double scale = 1.0;
              if (_pageController.hasClients) {
                final page = _pageController.page ?? _pageController.initialPage;
                final difference = (page - index).abs();
                scale = 1 - (difference * 0.1); // تأثير تصغير للكروت الجانبية
              }
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: _buildCard(items[index]),
          );
        },
      ),
    );
  }

  Widget _buildCard(Map<String, String> item) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // الصورة من الشبكة
                ClipRRect(
                  borderRadius: BorderRadius.circular(28.r),
                  child: Image.asset(
                    item["image"]!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    
                    // في حالة فشل تحميل الصورة
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                // overlay خفيف لتحسين قراءة النص (أغمق شوية عشان وضوح النص)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28.r),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                          stops: const [0.5, 1.0], // التدرج يبدأ من النص
                        ),
                      ),
                    ),
                  ),
                ),

                // Tag محسّن (البرنامج)
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E88E5).withOpacity(0.9), // أزرق مميز
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      item["tag"]!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // عنوان رئيسي وتفاصيل إضافية في الأسفل
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["title"]!,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item["subtitle"]!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white.withOpacity(0.95),
                          fontWeight: FontWeight.w500,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 6,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // إضافة أيقونة صغيرة (اختياري - علامة طبية)
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
                    ),
                    child: const Icon(
                      Icons.healing_rounded, // أيقونة طبية
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}