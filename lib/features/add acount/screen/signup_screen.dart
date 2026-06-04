import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/request_cubit.dart';
import '../models/request_model.dart';
import 'request_status_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController childrenCountController = TextEditingController();

  // Dropdown values
  String? maritalStatus;
  String? preferredTreatmentPlace;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<String> maritalOptions = [
    "أعزب / عزباء",
    "متزوج / متزوجة",
    "مطلق / مطلقة",
    "أرمل / أرملة",
  ];
  final List<String> treatmentOptions = ['الوحدة', 'المنتجع'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    nationalIdController.dispose();
    phoneController.dispose();
    jobController.dispose();
    addressController.dispose();
    childrenCountController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void submitSignup() {
    if (_formKey.currentState!.validate()) {
      String locationEn = preferredTreatmentPlace == 'المنتجع' ? 'resort' : 'unit';
      String maritalStatusEn = _convertMaritalStatus(maritalStatus!);

      final request = RequestModel(
        name: nameController.text,
        age: int.parse(ageController.text),
        nationalId: nationalIdController.text,
        phoneNumber: phoneController.text,
        location: locationEn,
        occupation: jobController.text,
        maritalStatus: maritalStatusEn,
        childrenCount: int.parse(
          childrenCountController.text.isEmpty ? '0' : childrenCountController.text,
        ),
        residence: addressController.text,
      );

      context.read<RequestCubit>().createRequest(request);
    }
  }

  String _convertMaritalStatus(String arabicStatus) {
    switch (arabicStatus) {
      case "أعزب / عزباء":
        return "single";
      case "متزوج / متزوجة":
        return "married";
      case "مطلق / مطلقة":
        return "divorced";
      case "أرمل / أرملة":
        return "widowed";
      default:
        return "single";
    }
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 74.w,
                height: 74.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  color: const Color(0xFFD32F2F),
                  size: 40.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'خطأ!',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFFD32F2F)),
              ),
              SizedBox(height: 10.h),
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00796B),
                  minimumSize: Size(double.infinity, 48.h),
                ),
                child: Text('حسناً', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestCubit, RequestState>(
      listener: (context, state) {
        if (state is RequestCreatedSuccess) {
          // عند نجاح الإنشاء، ننتقل مباشرة لصفحة حالة الطلب (بدون pop)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RequestStatusScreen(
                showSuccessSnackBar: true,
                successMessage: 'تم إرسال طلبك بنجاح، سيتم مراجعته قريباً',
              ),
            ),
          );
        } else if (state is RequestCreatedFailure) {
          _showErrorDialog(state.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is RequestLoading;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFE0F2F1), Color(0xFFF5F7FA)],
                  ),
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 550.w),
                          child: Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 88.w,
                                        height: 88.w,
                                        padding: EdgeInsets.all(4.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF00796B).withOpacity(0.12),
                                              blurRadius: 20,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                          border: Border.all(color: const Color(0xFFB2DFDB), width: 2),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(44.r),
                                          child: Image.asset(
                                            'assets/image/appIcon.png',
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.local_hospital_rounded, color: const Color(0xFF00796B), size: 42.sp);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 14.h),
                                      Text(
                                        'مستشفى فرسان التعافي',
                                        style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900, color: const Color(0xFF004D40), letterSpacing: 0.3),
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        'أدخل بياناتك بدقة لنتمكن من تقديم أفضل خدمة رعاية',
                                        style: TextStyle(fontSize: 12.5.sp, color: const Color(0xFF558B2F), fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 26.h),

                                _buildSectionHeader('البيانات الشخصية الأساسية'),
                                _buildGroupContainer([
                                  _buildModernField(
                                    controller: nameController,
                                    label: 'الاسم رباعي كما في البطاقة',
                                    icon: Icons.person_rounded,
                                    iconColor: const Color(0xFF00897B),
                                    validator: (v) => v == null || v.trim().isEmpty ? 'الاسم مطلوب' : null,
                                  ),
                                  SizedBox(height: 14.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: _buildModernField(
                                          controller: ageController,
                                          label: 'العمر',
                                          icon: Icons.cake_rounded,
                                          iconColor: const Color(0xFFD81B60),
                                          keyboardType: TextInputType.number,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) return 'مطلوب';
                                            int? age = int.tryParse(v);
                                            if (age == null || age < 1 || age > 120) return 'غير صحيح';
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        flex: 6,
                                        child: _buildModernField(
                                          controller: phoneController,
                                          label: 'رقم الهاتف المحمول',
                                          icon: Icons.phone_android_rounded,
                                          iconColor: const Color(0xFF1E88E5),
                                          keyboardType: TextInputType.phone,
                                          isDirectionLTR: true,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) return 'رقم التليفون مطلوب';
                                            if (v.length < 11) return 'رقم غير صحيح';
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 14.h),
                                  _buildModernField(
                                    controller: nationalIdController,
                                    label: 'الرقم القومي (14 رقم)',
                                    icon: Icons.badge_rounded,
                                    iconColor: const Color(0xFF5E35B1),
                                    keyboardType: TextInputType.number,
                                    isDirectionLTR: true,
                                    validator: (v) {
                                      if (v == null || v.isEmpty) return 'الرقم القومي مطلوب';
                                      if (v.length != 14) return 'يجب أن يكون 14 رقم';
                                      return null;
                                    },
                                  ),
                                ]),
                                SizedBox(height: 20.h),

                                _buildSectionHeader('الوضع الاجتماعي والمهني'),
                                _buildGroupContainer([
                                  _buildModernField(
                                    controller: jobController,
                                    label: 'المهنة الحالية',
                                    icon: Icons.work_rounded,
                                    iconColor: const Color(0xFFF4511E),
                                    validator: (v) => v == null || v.trim().isEmpty ? 'المهنة مطلوبة' : null,
                                  ),
                                  SizedBox(height: 14.h),
                                  _buildModernDropdown(
                                    value: maritalStatus,
                                    hint: 'الحالة الاجتماعية',
                                    icon: Icons.favorite_rounded,
                                    iconColor: const Color(0xFFE53935),
                                    items: maritalOptions,
                                    onChanged: (value) => setState(() => maritalStatus = value),
                                    validator: (v) => v == null ? 'اختر الحالة الاجتماعية' : null,
                                  ),
                                  if (maritalStatus == 'متزوج / متزوجة') ...[
                                    SizedBox(height: 14.h),
                                    _buildModernField(
                                      controller: childrenCountController,
                                      label: 'عدد الأبناء المعالين',
                                      icon: Icons.child_care_rounded,
                                      iconColor: const Color(0xFF00ACC1),
                                      keyboardType: TextInputType.number,
                                      validator: (v) => v == null || v.isEmpty ? 'عدد الأطفال مطلوب' : null,
                                    ),
                                  ],
                                ]),
                                SizedBox(height: 20.h),

                                _buildSectionHeader('تفاصيل الإقامة والرعاية المفضلة'),
                                _buildGroupContainer([
                                  _buildModernField(
                                    controller: addressController,
                                    label: 'العنوان الحالي بالتفصيل',
                                    icon: Icons.location_on_rounded,
                                    iconColor: const Color(0xFF43A047),
                                    validator: (v) => v == null || v.trim().isEmpty ? 'العنوان مطلوب' : null,
                                  ),
                                  SizedBox(height: 14.h),
                                  _buildModernDropdown(
                                    value: preferredTreatmentPlace,
                                    hint: 'مكان الرعاية / العلاج المفضل',
                                    icon: Icons.local_hospital_rounded,
                                    iconColor: const Color(0xFF00796B),
                                    items: treatmentOptions,
                                    onChanged: (value) => setState(() => preferredTreatmentPlace = value),
                                    validator: (v) => v == null ? 'اختر مكان العلاج' : null,
                                  ),
                                ]),
                                SizedBox(height: 36.h),

                                GestureDetector(
                                  onTap: isLoading ? null : submitSignup,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: double.infinity,
                                    height: 54.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      gradient: isLoading
                                          ? LinearGradient(colors: [Colors.grey.shade400, Colors.grey.shade500])
                                          : const LinearGradient(
                                              colors: [Color(0xFF00796B), Color(0xFF004D40)],
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                            ),
                                      boxShadow: [
                                        if (!isLoading)
                                          BoxShadow(
                                            color: const Color(0xFF004D40).withOpacity(0.3),
                                            blurRadius: 14,
                                            offset: const Offset(0, 6),
                                          ),
                                      ],
                                    ),
                                    alignment: Alignment.center,
                                    child: isLoading
                                        ? SizedBox(width: 22.w, height: 22.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                                        : Text(
                                            'تقديم الطلب الآن',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [Shadow(color: Colors.black.withOpacity(0.15), offset: const Offset(0, 1), blurRadius: 2)],
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroupContainer(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(18.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE0F2F1), width: 1.2),
        boxShadow: [
          BoxShadow(color: const Color(0xFF004D40).withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, right: 6.w),
      child: Row(
        children: [
          Container(width: 4.w, height: 16.h, decoration: BoxDecoration(color: const Color(0xFF00796B), borderRadius: BorderRadius.circular(2.r))),
          SizedBox(width: 8.w),
          Text(title, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: const Color(0xFF00796B))),
        ],
      ),
    );
  }

  Widget _buildModernField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color iconColor,
    TextInputType keyboardType = TextInputType.text,
    bool isDirectionLTR = false,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textDirection: isDirectionLTR ? TextDirection.ltr : TextDirection.rtl,
      style: TextStyle(fontSize: 14.sp, color: const Color(0xFF263238), fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: const Color(0xFF78909C), fontSize: 13.sp),
        prefixIcon: Icon(icon, color: iconColor.withOpacity(0.85), size: 19.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFCFD8DC), width: 1)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF00796B), width: 1.8)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.8)),
        errorStyle: TextStyle(fontSize: 11.sp, color: const Color(0xFFD32F2F)),
      ),
      validator: validator,
    );
  }

  Widget _buildModernDropdown({
    required String? value,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required List<String> items,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(hint, style: TextStyle(color: const Color(0xFF78909C), fontSize: 13.sp)),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: iconColor.withOpacity(0.85), size: 19.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFCFD8DC), width: 1)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFF00796B), width: 1.8)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1)),
        errorStyle: TextStyle(fontSize: 11.sp, color: const Color(0xFFD32F2F)),
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF263238))))).toList(),
      onChanged: onChanged,
      validator: validator,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF78909C)),
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}