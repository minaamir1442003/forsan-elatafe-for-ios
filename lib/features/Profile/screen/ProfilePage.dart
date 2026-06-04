import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/Profile/screen/ShowprofileScreen.dart';
import 'package:forsan_eltafe/features/Profile/screen/guest_profile_screen.dart';
import 'package:forsan_eltafe/features/Profile/widget/login_button.dart';
import 'package:forsan_eltafe/features/Profile/widget/security.dart';
import 'package:forsan_eltafe/features/add%20acount/screen/request_status_screen.dart';
import 'package:forsan_eltafe/features/auth/cubit/login_cubit.dart';
import 'package:forsan_eltafe/features/auth/cubit/login_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    nationalIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Appcolors.greycolor,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => LoginCubit(),
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ShowprofileScreen(
                        token: state.token,
                        patientName: state.patientName, // 👈 أضف هذا
                      ),
                    ),
                  );
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.message,
                        style: const TextStyle(
                          fontSize: 18, // حجم الخط
                          fontWeight: FontWeight.w600, // عريض شوية
                        ),
                      ),
                      backgroundColor: Colors.red,
                      duration: const Duration(
                        seconds: 3,
                      ), // المدة اللي هتظهر فيها
                      behavior: SnackBarBehavior.floating, // يظهر فوق مش تحت
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // زوايا دائرية
                      ),
                      margin: const EdgeInsets.all(16), // مسافة من الحواف
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ), // padding كبير
                    ),
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        Icon(Icons.lock, size: 40.sp),
                        SizedBox(height: 20),
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: nationalIdController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: "رقم الهوية",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return "ادخل الرقم";
                            if (v.length != 14) return "الرقم القومي 14 رقم";
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isPasswordHidden,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: "كلمة المرور",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return "ادخل الباسورد";
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return LoginButton(
                              formKey: _formKey,
                              nationalIdController: nationalIdController,
                              passwordController: passwordController,
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: Text(
                                "او",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const GuestProfileScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Appcolors.greycolor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "تسجيل الدخول كضيف ",
                                  style: TextStyle(
                                    color: Color(0xff0F4B80),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        const Security(),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RequestStatusScreen(
                                    onSuccess: () {
                                      // يمكنك تحديث SharedPreferences هنا إذا أردت
                                      // لكن البيانات بالفعل محفوظة من createRequest
                                    },
                                  ),
                                ),
                              );

                              if (result == true) {
                                _showSuccessSnackBar('✅ تم إرسال طلبك بنجاح!');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20),
                            ),
                            child: Text(
                              "إنشاء حساب جديد",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 150.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }
}
