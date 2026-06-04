import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:forsan_eltafe/features/Profile/screen/ProfilePage.dart';
import 'package:forsan_eltafe/features/Profile/widget/AnimatedEgyptFlagGlass.dart';
import 'package:forsan_eltafe/features/Profile/widget/profile_header.dart';
import 'package:forsan_eltafe/features/Profile/widget/record_card.dart';
import 'package:forsan_eltafe/features/navigation_bar/navigation_bar.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class ShowprofileScreen extends StatelessWidget {
  final String token;
  final String patientName;

  const ShowprofileScreen({
    super.key,
    required this.token,
    required this.patientName,
  });

  Future<void> _logout(BuildContext context) async {
    final cubit = context.read<HomeCubit>();

    final success = await cubit.logout(token);

    if (context.mounted) {
      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                const CustomBottomNavigationBar(initialIndex: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تسجيل الخروج بنجاح'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..getAllData(token),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Appcolors.background,
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.health_and_safety_rounded,
                    color: Appcolors.accentColorNew,
                    size: 28,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'فرسان التعافي',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              leading: Container(
                padding: const EdgeInsets.only(left: 1),

                child: Animatedegyptflagglass(),
              ),
              centerTitle: true,
              backgroundColor: Appcolors.cardBackground,
              elevation: 0,
              toolbarHeight: 80,
              foregroundColor: Appcolors.primaryColor,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: GestureDetector(
                    onTap: () => _logout(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.red, width: 1.2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "حذف الحساب",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 4,
                          color: Appcolors.accentColorNew,
                        ),
                        SizedBox(height: 24),
                        Text(
                          'جاري تحميل ملفك الطبي...',
                          style: TextStyle(
                            fontSize: 18,
                            color: Appcolors.textLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is HomeSuccess) {
                  // --- فلترة السجلات حسب الرتبة ---
                  return _FilteredRecordsView(
                    token: token,
                    allRecords: state.records,
                    profile: state.profile,
                    patientName: patientName,
                  );
                }

                if (state is HomeError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off_rounded,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'عذراً، حدث خطأ',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Appcolors.textDark,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            state.message,
                            style: TextStyle(
                              fontSize: 16,
                              color: Appcolors.textLight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        GestureDetector(
                          onTap: () {
                            context.read<HomeCubit>().getAllData(token);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Appcolors.accentColorNew,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.refresh_rounded,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'إعادة المحاولة',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}

// ✅ واجهة جديدة للفلترة والحفاظ على الكود نظيف
class _FilteredRecordsView extends StatefulWidget {
  final String token;
  final List<dynamic> allRecords;
  final Map<String, dynamic> profile;
  final String patientName;

  const _FilteredRecordsView({
    required this.token,
    required this.allRecords,
    required this.profile,
    required this.patientName,
  });

  @override
  State<_FilteredRecordsView> createState() => _FilteredRecordsViewState();
}

class _FilteredRecordsViewState extends State<_FilteredRecordsView> {
  String _selectedRole =
      'all'; // 'all', 'doctor', 'specialist', 'supervisor', 'nurse'

  // الحصول على قائمة فريدة من الرتب الموجودة فعلاً في السجلات
  List<String> get _availableRoles {
    final roles = <String>{};
    for (final record in widget.allRecords) {
      final createdBy = record['createdBy'] as Map<String, dynamic>?;
      final role = createdBy?['role'] as String?;
      if (role != null && role.isNotEmpty) {
        roles.add(role);
      }
    }
    return roles.toList();
  }

  // فلترة السجلات حسب الرتبة المختارة
  List<dynamic> get _filteredRecords {
    if (_selectedRole == 'all') {
      return widget.allRecords;
    }
    return widget.allRecords.where((record) {
      final createdBy = record['createdBy'] as Map<String, dynamic>?;
      final role = createdBy?['role'] as String?;
      return role == _selectedRole;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<HomeCubit>().getAllData(widget.token);
      },
      color: Appcolors.accentColorNew,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            ProfileHeader(
              patientName: widget.patientName,
              profile: widget.profile,
            ),

            // عنوان السجلات + أزرار الفلتر
            Container(
              margin: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Appcolors.accentColorNew,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '📋 السجلات الطبية',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Appcolors.primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolors.accentColorNew.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      '${_filteredRecords.length} سجل',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Appcolors.accentColorNew,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ✅ أزرار الفلتر (Chips) بشكل جميل
            if (_availableRoles.isNotEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                height: 48,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterChip('الكل', 'all'),
                    if (_availableRoles.contains('doctor'))
                      _buildFilterChip('🩺 دكتور', 'doctor'),
                    if (_availableRoles.contains('specialist'))
                      _buildFilterChip('🧠 أخصائي', 'specialist'),
                    if (_availableRoles.contains('supervisor'))
                      _buildFilterChip('🛡️ مشرف', 'supervisor'),
                    if (_availableRoles.contains('nurse'))
                      _buildFilterChip('💉 تمريض', 'nurse'),
                  ],
                ),
              ),

            // السجلات المفلترة
            if (_filteredRecords.isEmpty)
              Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  color: Appcolors.cardBackground,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.filter_alt_off_rounded,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'لا توجد سجلات لهذا التصنيف',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Appcolors.textLight,
                      ),
                    ),
                  ],
                ),
              )
            else
              ..._filteredRecords
                  .map((record) => RecordCard(record: record))
                  .toList(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ويدجت حبة الفلتر (Chip) الجميلة
  Widget _buildFilterChip(String label, String roleValue) {
    final isSelected = _selectedRole == roleValue;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = roleValue;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    Appcolors.accentColorNew,
                    Appcolors.accentColorNew.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Appcolors.cardBackground,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Appcolors.accentColorNew.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Appcolors.accentColorNew.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                size: 18,
                color: Colors.white,
              ),
            if (isSelected) const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : Appcolors.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
