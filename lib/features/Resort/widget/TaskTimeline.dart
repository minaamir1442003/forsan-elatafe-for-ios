import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class TaskTimelineWidget extends StatelessWidget {
  const TaskTimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _TimelineSection(
          title: "الفترة الصباحية",
          icon: Icons.wb_sunny_outlined,
          tasks: [
            {"time": "10:00 ص", "task": "الاستيقاظ"},
            {"time": "11:00 ص", "task": "التأمل"},
            {"time": "12:30 ظ", "task": "الإفطار"},
          ],
        ),
        _TimelineSection(
          title: "أنشطة اليوم",
          icon: Icons.light_mode_outlined,
          tasks: [
            {"time": "02:00 ظ", "task": "قراءة التعافي"},
            {"time": "03:00 - 04:00 م", "task": "وقت راحة"},
            {"time": "04:00 - 05:00 م", "task": "مجموعة التوعية", "highlight": true},
            {"time": "05:00 م", "task": "الغداء"},
            {"time": "06:00 - 07:00 م", "task": "وقت ترفيهي"},
          ],
        ),
        _TimelineSection(
          title: "الفترة المسائية",
          icon: Icons.nightlight_round_outlined,
          isLast: true,
          tasks: [
            {"time": "07:00 - 08:00 م", "task": "اجتماع الدعم"},
            {"time": "بعد الاجتماع", "task": "المشاركة والمشاعر"},
            {"time": "11:00 م", "task": "العشاء"},
            {"time": "12:00 ص", "task": "التأمل والمصفوفة"},
            {"time": "01:00 ص", "task": "النوم"},
          ],
        ),
      ],
    );
  }
}

class _TimelineSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Map<String, dynamic>> tasks;
  final bool isLast;

  const _TimelineSection({
    required this.title,
    required this.icon,
    required this.tasks,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          // عمود التايم لاين
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Appcolors.accentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Appcolors.accentColor,
                  size: 18.r,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    margin: EdgeInsets.only(top: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Appcolors.accentColor.withOpacity(0.5),
                          Colors.grey[300]!,
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          // المحتوى
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.bluecolor,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  margin: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: tasks.map(_buildTaskRow).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskRow(Map<String, dynamic> task) {
    final bool isHighlighted = task['highlight'] == true;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          // الوقت
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? Appcolors.accentColor.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              task['time'],
              style: TextStyle(
                color: isHighlighted ? Appcolors.accentColor : Colors.grey[600],
                fontSize: 12.sp,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          // اسم المهمة
          Text(
            task['task'],
            style: TextStyle(
              color: isHighlighted ? Appcolors.accentColor : const Color(0xFF2D3142),
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}