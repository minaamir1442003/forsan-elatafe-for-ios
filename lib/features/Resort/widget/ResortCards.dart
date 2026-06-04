import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResortCards extends StatefulWidget {
  const ResortCards({super.key});

  @override
  State<ResortCards> createState() => _ResortCardsState();
}

class _ResortCardsState extends State<ResortCards> {
  final PageController _pageController = PageController(viewportFraction: 0.75);

  // استخدام روابط صور حقيقية ومناسبة من Unsplash
  final List<Map<String, String>> items = const [
    {
      "image": "assets/montaga/montaga1.jpeg",
      "title": "مسبح المنتجع الخاص",
      "tag": "استرخاء و هدوء",
    },
    {
      "image": "assets/montaga/montaga2.jpeg",
      "title": "مرحباً بكم في منتجعنا",
      "tag": "البوابة الرئيسية",
    },
    {
      "image": "assets/montaga/montaga3.jpeg",
      "title": "المبنى الرئيسي والاستقبال",
      "tag": "خدمة ٢٤ ساعة",
    },
    {
      "image": "assets/montaga/montaga4.jpeg",
      "title": "صالة الاستقبال والانتظار",
      "tag": "أهلاً بك",
    },
    {
      "image": "assets/montaga/montaga5.jpeg",
      "title": "مكتب الاستشارات والإدارة",
      "tag": "خصوصية تامة",
    },
    {
      "image": "assets/montaga/montaga6.jpeg",
      "title": "أجنحة وصالات الإقامة المريحة",
      "tag": "بيئة دافئة",
    },
    {
      "image": "assets/montaga/montaga7.jpeg",
      "title": "مرافق ومرفقات خدمية متكاملة",
      "tag": "مرافق عامة",
    },
    {
      "image": "assets/montaga/montaga8.jpeg",
      "title": "وجبات غذائية صحية ومتكاملة",
      "tag": "تغذية متوازنة",
    },
    {
      "image": "assets/montaga/montaga9.jpeg",
      "title": "خيارات متنوعة من الإفطار الشهي",
      "tag": "وجبات يومية",
    },
    {
      "image": "assets/montaga/montaga10.jpeg",
      "title": "وجبات غداء شهية ومتنوعة يومياً",
      "tag": "بوفيه متكامل",
    },
    {
      "image": "assets/montaga/montaga11.jpeg",
      "title": "غرفة نوم خاصة مجهزة",
      "tag": 'غرفة نوم مريحة',
    },
    {
      "image": "assets/montaga/montaga12.jpeg",
      "title": "أجنحة إقامة ومساحات شخصية دافئة",
      "tag": "خصوصية وراحة",
    },
    {
      "image": "assets/montaga/montaga13.jpeg",
      "title": "أثاث مريح وتجهيزات غرف متكاملة",
      "tag": "غرف إقامة",
    },
    {
      "image": "assets/montaga/montaga14.jpeg",
      "title": "قاعة المحاضرات واللقاءات الجماعية",
      "tag": "جلسات التوعية",
    },
    {
      "image": "assets/montaga/montaga15.jpeg",
      "title": "توفير كافة وسائل الراحة والخصوصية",
      "tag": "إقامة هادئة",
    },
    {
      "image": "assets/montaga/montaga16.jpeg",
      "title": "منتجع فرسان التعافي",
      "tag": "تأهيل سلوكي",
    },
    {
      "image": "assets/montaga/montaga17.jpeg",
      "title": "ممرات واسعة ومحاطة بالأشجار",
      "tag": "أجواء نقية",
    },
    {
      "image": "assets/montaga/montaga18.jpeg",
      "title": "قاعات الضيافة واللاونج",
      "tag": "أجواء دافئة ومريحة",
    },
    {
      "image": "assets/montaga/montaga19.jpeg",
      "title": "أجنحة الإقامة الفاخرة",
      "tag": "خصوصية وتصميم مريح",
    },
    {
      "image": "assets/montaga/montaga20.jpeg",
      "title": "إطلالة جبلية ساحرة",
      "tag": "طبيعة خلابة ونقاء",
    },
    {
      "image": "assets/montaga/montaga21.jpeg",
      "title": "الصالة الرياضية والترفيهية",
      "tag": "أنشطة وتفريغ طاقة",
    },
  
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      child: PageView.builder(
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double scale = 1.0;
              if (_pageController.hasClients) {
                final page =
                    _pageController.page ?? _pageController.initialPage;
                final difference = (page - index).abs();
                scale = 1 - (difference * 0.1); // تأثير تصغير للكروت الجانبية
              }
              return Transform.scale(scale: scale, child: child);
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
                    // إضافة loading indicator

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

                // overlay خفيف لتحسين قراءة النص
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
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Tag محسّن
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      item["tag"]!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF1E4D7B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // عنوان صغير أسفل الصورة (كبديل)
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    item["title"]!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(height: 12.h), // مش لازم因为我们 نقلنا العنوان للصورة
          // Text(           // ممكن نشيل العنوان من هنا عشان متكررش
          //   item["title"]!,
          //   style: TextStyle(...),
          // ),
        ],
      ),
    );
  }
}
