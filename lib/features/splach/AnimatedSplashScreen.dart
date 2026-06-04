import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/navigation_bar/navigation_bar.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _controller;
  late AnimationController _glowController;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _glowAnimation;
  
  int _currentStage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _rotateAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(  // 👈 غيرنا النهاية لـ 1.0
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.7).animate(  // 👈 غيرنا النهاية لـ 0.7
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    
    _controller.forward();
    
    _timer = Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _currentStage = 1;
        });
      }
      
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CustomBottomNavigationBar()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _glowController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: const [
              Color(0xFF0A1929),
              Color(0xFF0D2B45),
              Color(0xFF000000),
            ],
            stops: [0.2, 0.6, 1],
          ),
        ),
        child: Stack(
          children: [
            // Background stars effect
            ...List.generate(30, (index) {
              return Positioned(
                left: (index * 23) % 360,
                top: (index * 17) % 690,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 1000 + index * 100),
                  builder: (context, value, child) {
                    double opacity = (value * (0.3 + (index % 5) * 0.1)).clamp(0.0, 1.0); // 👈 clamp للتأكد
                    return Opacity(
                      opacity: opacity,
                      child: Container(
                        width: (index % 3 + 1).toDouble(),
                        height: (index % 3 + 1).toDouble(),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            
            Center(
              child: AnimatedBuilder(
                animation: Listenable.merge([_controller, _glowController]),
                builder: (context, child) {
                  return _currentStage == 0
                      ? _buildFirstStage()
                      : _buildSecondStage();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFirstStage() {
    // حساب قيمة آمنة للتوهج
    double safeGlowValue = _glowAnimation.value.clamp(0.0, 1.0);
    double safeBlur = (40 * safeGlowValue).clamp(0.0, 40.0);
    double safeSpread = (15 * safeGlowValue).clamp(0.0, 15.0);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // الشعار مع تأثير التوهج
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Appcolors.accentColor.withOpacity(safeGlowValue * 0.5), // 👈 خفضنا الـ opacity
                blurRadius: safeBlur,
                spreadRadius: safeSpread,
              ),
            ],
          ),
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value.clamp(0.0, 1.2), // 👈 clamp للتأكد
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/image/WhatsApp Image 2026-05-27 at 3.12.22 AM.jpeg',
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 40.h),
        
        FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              Text(
                'فرسان التعافي',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3,
                  shadows: [
                    Shadow(
                      color: Appcolors.accentColor.withOpacity(0.8),
                      blurRadius: 15,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolors.accentColor.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  'للطب النفسي وعلاج الإدمان',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 80.h),
        
        // Animated dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(0),
            SizedBox(width: 8),
            _buildDot(1),
            SizedBox(width: 8),
            _buildDot(2),
          ],
        ),
      ],
    );
  }
  
  Widget _buildDot(int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + index * 200),
      builder: (context, value, child) {
        double opacity = (0.5 + value * 0.5).clamp(0.0, 1.0); // 👈 clamp للتأكد
        return Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Appcolors.accentColor.withOpacity(opacity),
          ),
        );
      },
    );
  }
  
  Widget _buildSecondStage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // الحصان مع تأثير سحري
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            double safeValue = value.clamp(0.0, 1.0); // 👈 clamp للتأكد
            return Transform.scale(
              scale: safeValue,
              child: Opacity(
                opacity: safeValue,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Appcolors.accentColor.withOpacity(0.4), // 👈 خفضنا الـ opacity
                        blurRadius: 40,
                        spreadRadius: 15,
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/image/appIcon.png',
                        height: 200.w,
                        width: 200.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        
        SizedBox(height: 40),
        
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            double safeValue = value.clamp(0.0, 1.0); // 👈 clamp للتأكد
            double safeWidth = (120.w * safeValue).clamp(0.0, 120.w);
            
            return Opacity(
              opacity: safeValue,
              child: Column(
                children: [
                  Text(
                    'طريقك إلى السلام والتعافي',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.accentColor,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    width: safeWidth,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Appcolors.accentColor, Colors.white],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 20),
              
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}