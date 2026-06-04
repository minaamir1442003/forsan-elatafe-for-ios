part of 'request_cubit.dart';

abstract class RequestState extends Equatable {
  const RequestState();
  
  @override
  List<Object?> get props => [];
}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestStatusLoading extends RequestState {}

class RequestCreatedSuccess extends RequestState {
  final String message;
  final String requestId;
  
  const RequestCreatedSuccess({
    required this.message,
    required this.requestId,
  });
  
  @override
  List<Object?> get props => [message, requestId];
}

// حالة نجاح جلب حالة الطلب (عامة)
class RequestStatusSuccess extends RequestState {
  final RequestStatusModel status;
  
  const RequestStatusSuccess({required this.status});
  
  @override
  List<Object?> get props => [status];
}

// حالة الطلب قيد المراجعة
class RequestStatusPending extends RequestState {
  final RequestStatusModel status;
  
  const RequestStatusPending({required this.status});
  
  @override
  List<Object?> get props => [status];
}

// حالة الطلب مقبول
class RequestStatusApproved extends RequestState {
  final RequestStatusModel status;
  
  const RequestStatusApproved({required this.status});
  
  @override
  List<Object?> get props => [status];
}

// حالة رفض الطلب
class RequestStatusRejected extends RequestState {
  final String message;
  final RequestStatusModel? statusModel;
  
  const RequestStatusRejected({this.message = 'تم رفض الطلب', this.statusModel});
  
  @override
  List<Object?> get props => [message, statusModel];
}

// حالة عدم العثور على الطلب
class RequestStatusNotFound extends RequestState {
  final String message;
  
  const RequestStatusNotFound({this.message = 'لم يتم العثور على الطلب'});
  
  @override
  List<Object?> get props => [message];
}

// حالة فشل إنشاء الطلب
class RequestCreatedFailure extends RequestState {
  final String error;
  
  const RequestCreatedFailure({required this.error});
  
  @override
  List<Object?> get props => [error];
}

// حالة فشل عام
class RequestStatusFailure extends RequestState {
  final String error;
  
  const RequestStatusFailure({required this.error});
  
  @override
  List<Object?> get props => [error];
}

// حالة خطأ عام
class RequestError extends RequestState {
  final String message;
  
  const RequestError({required this.message});
  
  @override
  List<Object?> get props => [message];
}