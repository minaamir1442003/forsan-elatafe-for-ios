import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/network/dio_helper.dart';
import 'package:forsan_eltafe/core/shared_preferences_helper.dart';
import 'package:forsan_eltafe/features/Onboarding/screen/onboarding_screen.dart';
import 'package:forsan_eltafe/features/splach/AnimatedSplashScreen.dart';
import 'package:forsan_eltafe/features/add%20acount/cubit/request_cubit.dart'; // أضف هذا

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SharedPreferencesHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MultiBlocProvider(
        providers: [
          // أضف RequestCubit هنا عشان يكون متاح في كل التطبيق
          BlocProvider(create: (context) => RequestCubit()),
          // لو عندك Cubits تانية زودها هنا
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'فرسان التعافي',
          theme: ThemeData(
            fontFamily: 'Cairo',
            useMaterial3: true,
          ),
          home: const AppEntryPoint(),
        
        ),
      ),
    );
  }
}

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final hasSeenOnboarding = SharedPreferencesHelper.getHasSeenOnboarding();
    
    if (hasSeenOnboarding) {
      return const AnimatedSplashScreen();
    } else {
      return const OnboardingScreen();
    }
  }
}