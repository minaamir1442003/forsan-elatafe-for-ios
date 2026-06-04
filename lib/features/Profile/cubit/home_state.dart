abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Map<String, dynamic> profile;  // 👈 غير من Map إلى Map<String, dynamic>
  final List<dynamic> records;         // 👈 غير من List إلى List<dynamic>

  HomeSuccess({required this.profile, required this.records});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}