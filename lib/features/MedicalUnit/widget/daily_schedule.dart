import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class TaskTimelineWidget extends StatelessWidget {
  const TaskTimelineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [

        /// الأنشطة الصباحية
        _TimelineSection(
          title: "الأنشطة الصباحية",
          icon: Icons.wb_sunny_outlined,
          tasks: [
            {"time": "10:00 ص", "task": "الاستيقاظ"},
            {
              "time": "11:00 ص",
              "task": "التأمل (تحسين العلاقة مع الله وتعلم صفاء الذهن)"
            },
            {"time": "12:30 ظ", "task": "وجبة الإفطار"},
          ],
        ),

        /// الأنشطة اليومية
        _TimelineSection(
          title: "الأنشطة اليومية",
          icon: Icons.light_mode_outlined,
          tasks: [
            {"time": "02:00 م", "task": "القراءات (برنامج التعافي)"},
            {"time": "03:00 - 04:00 م", "task": "وقت الراحة"},
            {
              "time": "04:00 - 05:00 م",
              "task": "مجموعة توعية (مسببات المرض أو طرق التعافي)",
              "highlight": true
            },
            {"time": "05:00 م", "task": "وجبة الغداء"},
            {
              "time": "06:00 - 07:00 م",
              "task": "وقت ترفيهي (البلايستيشن، الرياضة، البينج بونج)"
            },
          ],
        ),

        /// الأنشطة المسائية
        _TimelineSection(
          title: "الأنشطة المسائية",
          icon: Icons.nightlight_round_outlined,
          isLast: true,
          tasks: [
            {"time": "07:00 - 08:00 م", "task": "اجتماع (دعم ومشاركة)"},
            {
              "time": "بعد الاجتماع",
              "task": "وقت المشاركات الدعم وتفريغ المشاعر"
            },
            {"time": "11:00 م", "task": "وجبة العشاء"},
            {
              "time": "12:00 ص",
              "task": "رفلكشن (انعكاس اليوم، برنامج الماتركس)"
            },
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

          /// عمود التايم لاين
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
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),

          SizedBox(width: 16.w),

          /// المحتوى
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                /// عنوان القسم
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.bluecolor,
                  ),
                ),

                SizedBox(height: 12.h),

                /// الكارت
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
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [

          /// النص
          Expanded(
            child: Text(
              task['task'],
              textAlign: TextAlign.right,
              style: TextStyle(
                height: 1.4,
                color: isHighlighted
                    ? Appcolors.accentColor
                    : const Color(0xFF2D3142),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(width: 10.w),

          /// نقطة التايم لاين
          Container(
            width: 8.w,
            height: 8.w,
            margin: EdgeInsets.only(top: 6.h),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? Appcolors.accentColor
                  : Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),

          SizedBox(width: 10.w),

          /// الوقت
          Container(
            width: 85.w,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: isHighlighted
                  ? Appcolors.accentColor.withOpacity(0.1)
                  : Colors.grey[100],
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              task['time'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    isHighlighted ? Appcolors.accentColor : Colors.grey[700],
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
