import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/request_cubit.dart';
import '../models/request_model.dart';
import 'signup_screen.dart';

class RequestStatusScreen extends StatefulWidget {
  final bool showSuccessSnackBar;
  final String? successMessage;
  final VoidCallback? onSuccess;

  const RequestStatusScreen({
    super.key,
    this.showSuccessSnackBar = false,
    this.successMessage,
    this.onSuccess,
  });

  @override
  State<RequestStatusScreen> createState() => _RequestStatusScreenState();
}

class _RequestStatusScreenState extends State<RequestStatusScreen> {
  bool _hasShownSnackBar = false;
  bool _hasShownRejectedSnackBar = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    
    // عرض SnackBar النجاح إذا كان مطلوباً
    if (widget.showSuccessSnackBar && !_hasShownSnackBar) {
      _hasShownSnackBar = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSuccessSnackBar();
      });
    }
    
    // التحقق من وجود طلب سابق عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isNavigating) {
        context.read<RequestCubit>().checkForExistingRequest();
      }
    });
  }

  void _showSuccessSnackBar() {
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
              child: Icon(Icons.check_rounded, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'تم الإرسال بنجاح!',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.successMessage ?? 'سيتم مراجعة طلبك قريباً',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
    
    // بعد 2 ثانية، نقفل الشاشة ونرجع للـ ProfilePage
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && !_isNavigating) {
        _isNavigating = true;
        if (widget.onSuccess != null) {
          widget.onSuccess!();
        }
        Navigator.pop(context, true);
      }
    });
  }

  void _showRejectedSnackBar() {
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
              child: Icon(Icons.close_rounded, color: Colors.white, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'تم رفض الطلب!',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'يمكنك الضغط على "إعادة التقديم" لتقديم طلب جديد',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFD32F2F),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RequestCubit, RequestState>(
        listener: (context, state) {
          if (state is RequestStatusRejected) {
            // عرض SnackBar الرفض فقط (بدون انتقال تلقائي)
            if (!_hasShownRejectedSnackBar) {
              _hasShownRejectedSnackBar = true;
              _showRejectedSnackBar();
            }
          } else if (state is RequestStatusNotFound) {
            _showNotFoundDialog(context);
          } else if (state is RequestStatusFailure) {
            _showErrorDialog(context, state.error);
          } else if (state is RequestCreatedFailure) {
            _showErrorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is RequestStatusLoading) {
            return _buildLoadingView();
          } else if (state is RequestStatusPending) {
            return _buildPendingContent(context, state.status);
          } else if (state is RequestStatusApproved) {
            return _buildApprovedContent(context, state.status);
          } else if (state is RequestStatusSuccess) {
            return _buildStatusContent(context, state.status);
          } else if (state is RequestStatusRejected) {
            return _buildRejectedContent(context, state.statusModel);
          } else if (state is RequestStatusNotFound) {
            return _buildNotFoundContent(context);
          } else if (state is RequestStatusFailure) {
            return _buildErrorContent(context, state.error);
          } else if (state is RequestCreatedFailure) {
            return _buildErrorContent(context, state.error);
          } else if (state is RequestLoading) {
            return _buildLoadingView();
          } else if (state is RequestCreatedSuccess) {
            // بعد إنشاء الطلب بنجاح، نعرض الـ Loading وجلب الحالة
            return _buildLoadingView();
          } else {
            // لو مفيش طلب، نعرض واجهة تقديم طلب جديد
            return _buildNoRequestContent(context);
          }
        },
      ),
    );
  }

  // ==================== Loading Views ====================

  Widget _buildLoadingView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE0F2F1), Color(0xFFF5F7FA)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.8, end: 1.2),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00796B), Color(0xFF004D40)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00796B).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
            Text(
              'جاري تحميل حالة طلبك...',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF004D40),
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'يرجى الانتظار قليلاً',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== Pending Status Views ====================

  Widget _buildPendingContent(BuildContext context, RequestStatusModel status) {
    const statusColor = Color(0xFFF57C00);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [statusColor.withOpacity(0.08), Colors.white],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _buildStatusHeader(
                icon: Icons.pending_rounded,
                title: '⏳ قيد المراجعة',
                subtitle: 'طلبك قيد المراجعة من قبل الفريق',
                statusColor: statusColor,
              ),
              _buildInfoCard(status, statusColor),
              SizedBox(height: 20,),
              _buildPendingMessage(statusColor),
              SizedBox(height: 24),
              _buildPendingButtons(context, statusColor),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Approved Status Views ====================

  Widget _buildApprovedContent(BuildContext context, RequestStatusModel status) {
    const statusColor = Color(0xFF2E7D32);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [statusColor.withOpacity(0.08), Colors.white],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _buildStatusHeader(
                icon: Icons.check_circle_rounded,
                title: '✅ تم القبول!',
                subtitle: 'تهانينا! لقد تم قبول طلبك',
                statusColor: statusColor,
              ),
              _buildInfoCard(status, statusColor),
              SizedBox(height: 25,),
              _buildApprovedMessage(statusColor),

            ],
          ),
        ),
      ),
    );
  }

  // ==================== General Status Views ====================

  Widget _buildStatusContent(BuildContext context, RequestStatusModel status) {
    // دعم accepted و approved
    final isAccepted = status.status.toLowerCase() == 'accepted' || 
                       status.status.toLowerCase() == 'approved';
    final isPending = status.status.toLowerCase() == 'pending';
    
    Color statusColor;
    IconData statusIcon;
    String statusText;
    String statusSubText;
    
    if (isAccepted) {
      statusColor = const Color(0xFF2E7D32);
      statusIcon = Icons.check_circle_rounded;
      statusText = '✅ تم القبول!';
      statusSubText = 'تهانينا! لقد تم قبول طلبك';
    } else {
      statusColor = const Color(0xFFF57C00);
      statusIcon = Icons.pending_rounded;
      statusText = '⏳ قيد المراجعة';
      statusSubText = 'طلبك قيد المراجعة من قبل الفريق';
    }
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [statusColor.withOpacity(0.08), Colors.white],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              _buildStatusHeader(
                icon: statusIcon,
                title: statusText,
                subtitle: statusSubText,
                statusColor: statusColor,
              ),
              _buildInfoCard(status, statusColor),
              if (isPending) _buildPendingMessage(statusColor),
              if (isAccepted) _buildApprovedMessage(statusColor),
              SizedBox(height: 24.h),
              if (isPending) _buildPendingButtons(context, statusColor),
              if (isAccepted) _buildApprovedButtons(context, statusColor),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHeader({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color statusColor,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Column(
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [statusColor, statusColor.withOpacity(0.7)],
              ),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 60.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: statusColor,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildInfoCard(RequestStatusModel status, Color statusColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: statusColor.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: statusColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اسم مقدم الطلب',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Text(
                      status.name,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF004D40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.grey.shade200, height: 1),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: statusColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تاريخ التقديم',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Text(
                      _formatDate(status.createdAt),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF004D40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPendingMessage(Color statusColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor.withOpacity(0.1), statusColor.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: statusColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.access_time_rounded, color: statusColor, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'متوسط وقت المراجعة',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'سيتم التواصل معك خلال 24 ساعة كحد أقصى',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovedMessage(Color statusColor) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [statusColor.withOpacity(0.1), Colors.white],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.celebration_rounded, color: statusColor, size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'تهانينا! تم قبول طلبك',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'سيتم التواصل معك خلال 48 ساعة لترتيب إجراءات الدخول والتنسيق مع فريق الرعاية',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPendingButtons(BuildContext context, Color statusColor) {
    final cubit = context.read<RequestCubit>();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                if (cubit.savedNationalId != null) {
                  cubit.getRequestStatus(cubit.savedNationalId!);
                }
              },
              icon: Icon(Icons.refresh_rounded, size: 20.sp),
              label: Text('تحديث', style: TextStyle(fontSize: 13.sp)),
              style: ElevatedButton.styleFrom(
                backgroundColor: statusColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovedButtons(BuildContext context, Color statusColor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () => _showNextStepsDialog(context),
            icon: Icon(Icons.info_outline_rounded, size: 20.sp),
            label: Text(
              'الخطوات القادمة',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== Rejected Views ====================

  Widget _buildRejectedContent(BuildContext context, RequestStatusModel? status) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFEBEE), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  builder: (context, double value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEF5350), Color(0xFFC62828)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC62828).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 70.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  '😔 عذراً، تم رفض طلبك',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFC62828),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'لم يتم قبول طلبك للعلاج في الوقت الحالي',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),

                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: const Color(0xFFFFCDD2), width: 1.5),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade100, blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: const Color(0xFFC62828), size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'أسباب محتملة للرفض:',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFC62828),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      _buildReasonItem('❌ عدم تطابق البيانات مع متطلبات القبول'),
                      _buildReasonItem('❌ اكتمال العدد المحدد للمتقدمين'),
                      _buildReasonItem('❌ عدم استيفاء بعض الشروط'),
                      SizedBox(height: 8.h),
                      Text(
                        'يمكنك التقدم بطلب جديد بعد مراجعة البيانات',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // مسح البيانات
                          await context.read<RequestCubit>().resetAndGoToForm();
                          if (mounted) {
                            // الانتقال لصفحة التسجيل
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const SignupScreen()),
                            );
                          }
                        },
                        icon: Icon(Icons.refresh_rounded, size: 20.sp),
                        label: Text('إعادة التقديم'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC62828),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== No Request Views ====================

  Widget _buildNoRequestContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFE3F2FD), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, double value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF78909C).withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.file_copy_rounded,
                      size: 80.sp,
                      color: const Color(0xFF78909C),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  'لا يوجد طلب سابق',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF455A64),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'لم يتم العثور على طلب مسجل، يمكنك تقديم طلب جديد',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                ElevatedButton.icon(
                  onPressed: () async {
                    await context.read<RequestCubit>().resetAndGoToForm();
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    }
                  },
                  icon: Icon(Icons.add_circle_rounded, size: 22.sp),
                  label: Text(
                    'تقديم طلب جديد',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 52.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== Not Found Views ====================

  Widget _buildNotFoundContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFE3F2FD), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  builder: (context, double value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    width: 140.w,
                    height: 140.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF78909C).withOpacity(0.2),
                    ),
                    child: Icon(
                      Icons.search_off_rounded,
                      size: 80.sp,
                      color: const Color(0xFF78909C),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  'لا يوجد طلب بهذا الرقم',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF455A64),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'لم يتم العثور على طلب مسجل بهذا الرقم القومي',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                ElevatedButton.icon(
                  onPressed: () async {
                    await context.read<RequestCubit>().resetAndGoToForm();
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    }
                  },
                  icon: Icon(Icons.add_circle_rounded, size: 22.sp),
                  label: Text(
                    'تقديم طلب جديد',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 52.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== Error Views ====================

  Widget _buildErrorContent(BuildContext context, String error) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF5F7FA), Color(0xFFF5F7FA)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(
                    Icons.wifi_off_rounded,
                    size: 50.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'حدث خطأ في الاتصال',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  error,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const SignupScreen()),
                          );
                        },
                        icon: Icon(Icons.arrow_back_rounded, size: 20.sp),
                        label: Text('رجوع'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final cubit = context.read<RequestCubit>();
                          if (cubit.savedNationalId != null) {
                            cubit.getRequestStatus(cubit.savedNationalId!);
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const SignupScreen()),
                            );
                          }
                        },
                        icon: Icon(Icons.refresh_rounded, size: 20.sp),
                        label: Text('إعادة المحاولة'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00796B),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== Helper Methods ====================

  Widget _buildReasonItem(String reason) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Text(reason, style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // ==================== Dialogs ====================

  void _showNotFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text('لم يتم العثور على طلب'),
        content: Text('لا يوجد طلب مسجل بهذا الرقم القومي. يرجى تقديم طلب جديد.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<RequestCubit>().resetAndGoToForm();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignupScreen()),
              );
            },
            child: const Text('تقديم طلب جديد'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text('خطأ', style: TextStyle(color: const Color(0xFFD32F2F))),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  

  void _showNextStepsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text('الخطوات القادمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepItem('1', 'سيتم التواصل معك خلال 48 ساعة'),
            _buildStepItem('2', 'تجهيز الأوراق المطلوبة'),
            _buildStepItem('3', 'تحديد موعد للمقابلة الشخصية'),
            _buildStepItem('4', 'إجراءات الدخول والاستقبال'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('فهمت'),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(String number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: const Color(0xFF00796B),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(child: Text(text, style: TextStyle(fontSize: 13.sp))),
        ],
      ),
    );
  }
}