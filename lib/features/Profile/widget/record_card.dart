import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:forsan_eltafe/core/appcolors.dart';

class RecordCard extends StatelessWidget {
  final Map<String, dynamic> record;

  const RecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final data = record['data'] as Map<String, dynamic>? ?? {};
    final createdBy = record['createdBy'] as Map<String, dynamic>? ?? {};
    final role = createdBy['role'] ?? '';

    String formattedDate = '';
    if (record['date'] != null) {
      try {
        final date = DateTime.parse(record['date']);
        formattedDate = DateFormat('dd/MM/yyyy').format(date);
      } catch (e) {
        formattedDate = record['date'].toString();
      }
    }

    // ✅ فلترة الحقول الفاضية فقط
    final filteredData = Map.fromEntries(
        data.entries.where((entry) {
      final value = entry.value;
      if (value == null) return false;
      if (value is List && value.isEmpty) return false;
      if (value is String && value.trim().isEmpty) return false;
      if (value is Map && value.isEmpty) return false;
      return true;
    }));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            childrenPadding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            leading: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _getRoleColor(role).withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getRoleIcon(role),
                color: _getRoleColor(role),
                size: 30,
              ),
            ),
            title: Text(
              _getRoleTitle(role),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: Appcolors.primaryColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 20,
                runSpacing: 4,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_outline, size: 16, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.5),
                        child: Text(
                          createdBy['name'] ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 28,
                color: Appcolors.accentColorNew,
              ),
            ),
            children: [
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  // ✅ استخدام data المفلترة بدل الأصلية
                  if (filteredData.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          'لا توجد بيانات إضافية',
                          style: TextStyle(
                            fontSize: 16,
                            color: Appcolors.textLight,
                          ),
                        ),
                      ),
                    );
                  }

                  // تجميع الحقول في عمود واحد مرن
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...filteredData.entries.map((entry) {
                        return _buildInfoRow(entry.key, entry.value);
                      }).toList(),
                      if (record['images'] != null && record['images'].isNotEmpty)
                        _buildAttachmentsSection(record['images'], context),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ قسم المرفقات بشكل منفصل ومرن
  Widget _buildAttachmentsSection(List images, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Appcolors.greycolorNew,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.image_rounded, size: 24, color: Appcolors.accentColorNew),
                const SizedBox(width: 10),
                Text(
                  'المرفقات (${images.length})',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Appcolors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, i) {
                  final img = images[i];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              img['url'],
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.broken_image,
                                      size: 50, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[100],
                        image: DecorationImage(
                          image: NetworkImage(img['url']),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => null,
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
    );
  }

  Widget _buildInfoRow(String key, dynamic value) {
    String displayValue;
    if (value is List) {
      displayValue = value.join(' • ');
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _translateKey(key),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Appcolors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Appcolors.greycolorNew,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Text(
              displayValue,
              style: const TextStyle(
                fontSize: 15,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String _translateKey(String key) {
    const translations = {
      'severity': '⚡ الشدة',
      'mainProblem': '🎯 المشكلة الأساسية',
      'insight': '🧠 البصيرة',
      'response': '📊 الاستجابة',
      'progress': '📈 التقدم',
      'workDone': '✍️ ما تم العمل عليه',
      'plan': '📋 الخطة القادمة',
      'notes': '📝 ملاحظات',
      'behavioralPattern': '🔄 النمط السلوكي',
      'generalStatus': '🏥 الحالة العامة',
      'mood': '😊 المزاج',
      'sleep': '😴 النوم',
      'appetite': '🍽️ الشهية',
      'socialInteraction': '👥 التفاعل الاجتماعي',
      'psychoticFeatures': '🧩 الأعراض الذهانية',
      'medicalComplaints': '🩺 الشكاوى الطبية',
      'sideEffects': '⚠️ الأعراض الجانبية',
      'currentMedications': '💊 الأدوية الحالية',
      'treatmentResponse': '📈 الاستجابة للعلاج',
      'vitals': '❤️ العلامات الحيوية',
      'reasonInstability': '📌 سبب عدم الاستقرار',
      'symptoms': '🤒 الأعراض',
      'medicationGiven': '💊 الأدوية المعطاة',
      'primaryDiagnosis': '📋 التشخيص الرئيسي',
      'secondaryDiagnoses': '📑 التشخيصات الثانوية',
      'hpiSummary': '📖 ملخص المرض الحالي',
      'impulsivity': '⚡ الاندفاعية',
      'substanceCraving': '🎯 الرغبة في المواد',
      'suicideRisk': '⚠️ خطر الانتحار',
      'violenceRisk': '⚠️ خطر العنف',
      'overallRisk': '📊 الخطر العام',
      'overallPrognosis': '🔮 التكهن العام',
      'clinicalNotes': '📝 ملاحظات إكلينيكية',
      'familySupport': '👨‍👩‍👧‍👦 الدعم الأسري',
      'environmentalStress': '🌍 الضغوط البيئية',
      'generalImpression': '💭 الانطباع العام',
      'sessionType': '📋 نوع الجلسة',
      'statusBehavior': '🎭 السلوك',
      'eventsRisks': '⚠️ الأحداث/المخاطر',
      'action': '⚡ الإجراء',
      'goal': '🎯 الهدف',
      'tracking': '📊 المتابعة',
    };
    return translations[key] ?? key;
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'doctor':
        return Icons.medical_information_rounded;
      case 'specialist':
        return Icons.psychology_rounded;
      case 'supervisor':
        return Icons.shield_rounded;
      case 'nurse':
        return Icons.health_and_safety_rounded;
      default:
        return Icons.description_rounded;
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'doctor':
        return Appcolors.infoColor;
      case 'specialist':
        return Appcolors.successColor;
      case 'supervisor':
        return Appcolors.warningColor;
      case 'nurse':
        return const Color(0xFFE74C3C);
      default:
        return Appcolors.accentColorNew;
    }
  }

  String _getRoleTitle(String role) {
    switch (role) {
      case 'doctor':
        return '🩺 كشف طبي';
      case 'specialist':
        return '🧠 جلسة أخصائي نفسي';
      case 'supervisor':
        return '🛡️ تقرير مشرف';
      case 'nurse':
        return '💉 تقرير تمريض';
      default:
        return '📄 سجل طبي';
    }
  }
}