import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';
import 'package:intl/intl.dart';

class ProfileHeader extends StatelessWidget {
  final String patientName;
  final Map<String, dynamic> profile;

  const ProfileHeader({
    super.key,
    required this.patientName,
    required this.profile,
  });

  String _getFormattedDate(dynamic dateValue) {
    if (dateValue == null) return '--';
    final dateString = dateValue.toString();
    if (dateString.length >= 10) {
      return dateString.substring(5, 10);
    }
    return dateString;
  }

  String _formatDateTime(String dateTimeString) {
    try {
      final date = DateTime.parse(dateTimeString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateTimeString;
    }
  }

  // ========== معلومات المراحل العلاجية بالعربي ==========
  Map<String, Map<String, String>> get _stageInfo => {
    'acute': {
      'name': 'المرحلة الحادة',
      'icon': '⚠️',
      'description': 'يتم التركيز على استقرار الحالة وتقليل الأعراض الحادة',
      'color': '#E74C3C', // أحمر
    },
    'transitional': {
      'name': 'المرحلة الانتقالية',
      'icon': '🔄',
      'description':
          'يتم تعليم الفرد مهارات التعامل مع الأعراض والضغوط النفسية',
      'color': '#F39C12', // برتقالي
    },
    'rehabilitative': {
      'name': 'المرحلة التأهيلية',
      'icon': '🏋️',
      'description':
          'يتم تعليم الفرد مهارات حياتية واجتماعية ضرورية للعيش المستقل',
      'color': '#3498DB', // أزرق
    },
    'supportive': {
      'name': 'المرحلة الداعمة',
      'icon': '🌟',
      'description':
          'يتم تقديم الدعم المستمر للفرد لمساعدته في الحفاظ على التقدم المحرز',
      'color': '#27AE60', // أخضر
    },
    'preventive': {
      'name': 'المرحلة الوقائية',
      'icon': '🛡️',
      'description':
          'يتم تعليم الفرد استراتيجيات الوقاية من الانتكاسة والتعامل مع الضغوط النفسية',
      'color': '#9B59B6', // بنفسجي
    },
    'monitoring': {
      'name': 'المتابعة والتقييم المستمر',
      'icon': '📊',
      'description':
          'يتم متابعة الحالة وتقييمها بشكل مستمر لضمان استمرار التقدم والتحسن',
      'color': '#1ABC9C', // تركواز
    },
  };

  String _getStageName(String stageId) {
    return _stageInfo[stageId]?['name'] ?? stageId;
  }

  String _getStageIcon(String stageId) {
    return _stageInfo[stageId]?['icon'] ?? '📌';
  }

  String _getStageDescription(String stageId) {
    return _stageInfo[stageId]?['description'] ?? '';
  }

  Color _getStageColor(String stageId) {
    final colorHex = _stageInfo[stageId]?['color'] ?? '#C6A75E';
    return Color(int.parse('0xFF${colorHex.substring(1)}'));
  }

  int _getStageProgress(String stageId) {
    switch (stageId) {
      case 'acute':
        return 20;
      case 'transitional':
        return 40;
      case 'rehabilitative':
        return 65;
      case 'supportive':
        return 85;
      case 'preventive':
        return 95;
      case 'monitoring':
        return 100;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final therapeuticHistory = profile['therapeuticHistory'] as List? ?? [];

    // عكس الترتيب عشان الأحدث يظهر أولاً
    final reversedHistory = therapeuticHistory.reversed.toList();

    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Welcome Card
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Appcolors.primaryColor,
                  Appcolors.primaryColor.withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.primaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, // 👈 توسيط عمودي
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min, // 👈 ياخد أقل حجم ممكن
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Appcolors.accentColorNew.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: Appcolors.accentColorNew,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: profile['status'] == 'resident'
                            ? Appcolors.successColor.withOpacity(0.15)
                            : Appcolors.warningColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: profile['status'] == 'resident'
                              ? Appcolors.successColor
                              : Appcolors.warningColor,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            profile['status'] == 'resident'
                                ? Icons.check_circle_rounded
                                : Icons.remove_circle_rounded,
                            size: 18,
                            color: profile['status'] == 'resident'
                                ? Appcolors.successColor
                                : Appcolors.warningColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            profile['status'] == 'resident'
                                ? 'مقيم'
                                : 'غير مقيم',
                            style: TextStyle(
                              color: profile['status'] == 'resident'
                                  ? Appcolors.successColor
                                  : Appcolors.warningColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  // 👈 مهم: يسمح للعمود الأيمن بأخذ المساحة المتبقية
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'مرحباً بك',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade300,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        patientName,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.end,
                        maxLines: 2, // 👈 يسمح بسطرين
                        overflow:
                            TextOverflow.ellipsis, // 👈 لو أكبر يتقطع بـ ...
                        softWrap: true, // 👈 يسمح بالتفاف النص
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          // ========== رحلة التعافي (المراحل العلاجية) ==========
          if (reversedHistory.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Appcolors.cardBackground, Appcolors.cardBackground],
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Appcolors.accentColorNew,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '🌟 رحلة التعافي',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Appcolors.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Appcolors.successColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.rocket_rounded,
                              size: 16,
                              color: Appcolors.successColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'قيد التقدم',
                              style: TextStyle(
                                fontSize: 12,
                                color: Appcolors.successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // خط زمني متدرج
                  ...reversedHistory.asMap().entries.map((entry) {
                    final index = entry.key;
                    final history = entry.value;
                    final stageId = history['stage'] ?? '';
                    final changedBy = history['changedBy'] as Map?;
                    final name = changedBy?['name'] ?? '';
                    final role = changedBy?['role'] ?? '';
                    final changedAt = history['changedAt'] ?? '';
                    final isLast = index == reversedHistory.length - 1;
                    final isLastStage =
                        stageId == 'supportive' || stageId == 'monitoring';

                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // العمود الأيمن (الخط الزمني)
                            SizedBox(
                              width: 30,
                              child: Column(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          _getStageColor(stageId),
                                          _getStageColor(
                                            stageId,
                                          ).withOpacity(0.7),
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: _getStageColor(
                                            stageId,
                                          ).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getStageIcon(stageId),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  if (!isLast)
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      width: 2,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            _getStageColor(stageId),
                                            _getStageColor(
                                              reversedHistory[index +
                                                      1]['stage'] ??
                                                  '',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // العمود الأيسر (المحتوى)
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: isLast ? 0 : 16,
                                ),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: _getStageColor(
                                    stageId,
                                  ).withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _getStageColor(
                                      stageId,
                                    ).withOpacity(0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          _getStageName(stageId),
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                            color: _getStageColor(stageId),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getStageColor(
                                              stageId,
                                            ).withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            _formatDateTime(changedAt),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: _getStageColor(stageId),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _getStageDescription(stageId),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.shade600,
                                        height: 1.4,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person_outline,
                                          size: 14,
                                          color: Colors.grey.shade500,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            '$name - $role',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // شريط التقدم
                                    const SizedBox(height: 12),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: _getStageProgress(stageId) / 100,
                                        backgroundColor: Colors.grey.shade200,
                                        color: _getStageColor(stageId),
                                        minHeight: 6,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '${_getStageProgress(stageId)}% مكتمل',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: _getStageColor(stageId),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ] else ...[
            // لو مفيش تاريخ علاجي
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Appcolors.cardBackground,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.timeline_outlined,
                    size: 48,
                    color: Appcolors.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لم يتم تحديد رحلة التعافي حتى الآن',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Appcolors.textLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'سيتم تحديث رحلة التعافي الخاصة بك قريباً',
                    style: TextStyle(
                      fontSize: 14,
                      color: Appcolors.textLight.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Stats Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Appcolors.cardBackground,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  Icons.cake_rounded,
                  "${profile['age'] ?? '--'}",
                  "العمر",
                ),
                Container(width: 1.5, height: 50, color: Colors.grey.shade200),
                _buildStatItem(
                  Icons.work_rounded,
                  profile['occupation']?.isNotEmpty == true
                      ? profile['occupation']
                      : 'غير محدد',
                  "المهنة",
                ),
                Container(width: 1.5, height: 50, color: Colors.grey.shade200),
                _buildStatItem(
                  Icons.calendar_today_rounded,
                  _getFormattedDate(profile['entryDate']),
                  "تاريخ الدخول",
                ),
              ],
            ),
          ),

          // المرفقات
          if (profile['images'] != null &&
              (profile['images'] as List).isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appcolors.cardBackground,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.image_rounded,
                        size: 28,
                        color: Appcolors.accentColorNew,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'المرفقات',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Appcolors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (profile['images'] as List).length,
                      itemBuilder: (context, i) {
                        final img = profile['images'][i];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => Dialog(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(img['url']),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(img['url']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Appcolors.accentColorNew),
        const SizedBox(height: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Appcolors.primaryColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: Appcolors.textLight,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
