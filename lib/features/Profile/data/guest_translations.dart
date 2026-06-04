class GuestTranslations {
  static const Map<String, String> translations = {
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
    'symptoms': '🤒 الأعراض',
    'medicationGiven': '💊 الأدوية المعطاة',
    'sessionType': '📌 نوع الجلسة',
    'statusBehavior': '👤 الحالة والسلوك',
    'eventsRisks': '⚠️ الأحداث والمخاطر',
    'action': '🛠️ الإجراء المتخذ',
    'tracking': '📊 المتابعة',
  };

  static String translate(String key) {
    return translations[key] ?? key;
  }
}