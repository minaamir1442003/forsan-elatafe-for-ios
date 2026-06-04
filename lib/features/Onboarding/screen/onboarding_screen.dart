import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forsan_eltafe/core/shared_preferences_helper.dart';
import 'package:forsan_eltafe/features/navigation_bar/navigation_bar.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/image/6cc79e41-e205-4f31-8704-859d54e1592d.jpg",
      "title": "أهلاً بك في\nفُرسان التعافي",
      "desc": "مؤسسة متخصص في الطب النفسي وعلاج الإدمان\nوإعادة التأهيل السلوكي في بيئة آمنة.",
    },
    {
      "image": "assets/wehda/wehda14.jpeg",
      "title": "فريق طبي متخصص",
      "desc": "نخبة من أفضل الأطباء النفسيين والمعالجين\nلدعم رحلتك نحو التعافي باحترافية.",
    },
    {
      "image": "assets/montaga/montaga19.jpeg",
      "title": "إقامة فندقية فاخرة",
      "desc": "بيئة هادئة ومريحة تساعد على الاستقرار النفسي\nوتسريع عملية الشفاء.",
    },
    {
      "image": "assets/image/location to splach screen .png",
      "title": "موقع مميز في أبو صير و ابو زعبل",
      "desc": "نقع في منطقة أبو صير - البدرشين، محافظة الجيزة\nنعمل على مدار 24 ساعة لخدمتك.",
    },
  ];

  // دالة للانتقال إلى الصفحة الرئيسية وحفظ الحالة
  Future<void> _navigateToHome() async {
    // حفظ أن المستخدم شاهد الـ Onboarding
    await SharedPreferencesHelper.setHasSeenOnboarding(true);
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CustomBottomNavigationBar()),
      );
    }
  }

  void _nextPage() {
    if (_currentIndex == _pages.length - 1) {
      // إذا كانت آخر صفحة، يروح للـ Home
      _navigateToHome();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
@override
void initState() {
  super.initState();

  // تثبيت الاتجاه Portrait فقط
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

@override
void dispose() {
  // رجّع كل الاتجاهات لما تخرج من الصفحة
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE2EBF0), Color(0xFFF7FAFC)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                /// زر التخطي
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.spa,
                          color: Color(0xFF0F4C81),
                          size: 24,
                        ),
                      ),
                      TextButton(
                        onPressed: _navigateToHome,  // 👈 حفظ الحالة والانتقال
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              // ignore: deprecated_member_use
                              color: const Color(0xFF0F4C81).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "تخطي",
                            style: TextStyle(
                              color: const Color(0xFF0F4C81),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (index) =>
                        setState(() => _currentIndex = index),
                    itemBuilder: (context, index) {
                      return _buildPage(
                        _pages[index]["image"]!,
                        _pages[index]["title"]!,
                        _pages[index]["desc"]!,
                      );
                    },
                  ),
                ),

                /// Indicators & Button Section
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      // Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 8,
                            width: _currentIndex == index ? 30 : 10,
                            decoration: BoxDecoration(
                              gradient: _currentIndex == index
                                  ? const LinearGradient(
                                      colors: [Color(0xFF0F4C81), Color(0xFF1E88E5)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    )
                                  : null,
                              color: _currentIndex == index
                                  ? null
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: _currentIndex == index
                                  ? [
                                      BoxShadow(
                                        // ignore: deprecated_member_use
                                        color: const Color(0xFF0F4C81).withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      )
                                    ]
                                  : [],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Next Button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0F4C81),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            // ignore: deprecated_member_use
                            shadowColor: const Color(0xFF0F4C81).withOpacity(0.3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentIndex == _pages.length - 1
                                    ? "ابدأ الآن"
                                    : "التالي",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  // ignore: deprecated_member_use
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPage(String image, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            builder: (context, double scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 25,
                    offset: const Offset(0, 15),
                  ),
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: const Color(0xFF0F4C81).withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(
                          image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 250,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                // ignore: deprecated_member_use
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F4C81),
                      height: 1.3,
                      shadows: [
                        Shadow(
                          color: Color(0xFF0F4C81),
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      height: 1.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}