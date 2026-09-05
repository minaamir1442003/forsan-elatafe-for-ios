import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/features/auth/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nationalIdController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nationalIdController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          context.read<LoginCubit>().login(
            nationalId: nationalIdController.text,
            password: passwordController.text,
          );
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff0F4B80),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Padding(
                                padding: const EdgeInsets.all(10.0),
            child: Text(
              "تسجيل الدخول",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}