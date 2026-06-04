
class GuestData {
  static const Map<String, dynamic> profile = {
    'name': 'ضيف فرسان التعافي',
    'age': '--',
    'occupation': 'زائر',
    'residence': '--',
    'status': 'visitor',
    'entryDate': '--',
    'therapeuticHistory': [],
  };

  static const List<Map<String, dynamic>> records = [
    {
      'createdBy': {'name': 'الدكتور أحمد', 'role': 'doctor'},
      'date': '2024-03-15T10:00:00.000Z',
      'data': {
        'generalStatus': 'مستقر',
        'mood': 'جيد',
        'sleep': 'جيد',
        'appetite': 'طبيعي',
        'socialInteraction': 'متفاعل',
        'psychoticFeatures': 'لا يوجد',
        'medicalComplaints': 'لا شكاوى',
        'plan': 'متابعة دورية',
        'response': 'جيدة',
      },
      'images': [],
    },
    {
      'createdBy': {'name': 'الأخصائية سارة', 'role': 'specialist'},
      'date': '2024-03-10T10:00:00.000Z',
      'data': {
        'severity': 'خفيفة',
        'mainProblem': 'قلق متوسط',
        'insight': 'جيد',
        'response': 'متحسن',
        'progress': 'مستمر',
        'workDone': 'جلسات استرخاء',
        'plan': 'تمارين تنفس',
        'notes': 'استجابة إيجابية',
      },
      'images': [],
    },
    {
      'createdBy': {'name': 'الممرض محمد', 'role': 'nurse'},
      'date': '2024-03-05T10:00:00.000Z',
      'data': {
        'vitals': 'مستقر',
        'symptoms': 'لا يوجد أعراض',
        'medicationGiven': 'جرعات منتظمة',
      },
      'images': [],
    },
    {
      'createdBy': {'name': 'المشرف خالد', 'role': 'supervisor'},
      'date': '2024-03-01T10:00:00.000Z',
      'data': {
        'sessionType': 'متابعة',
        'statusBehavior': 'متعاون',
        'eventsRisks': 'لا يوجد',
        'action': 'متابعة',
        'notes': 'ملتزم بالبرنامج',
        'tracking': 'ممتاز',
      },
      'images': [],
    },
  ];
}