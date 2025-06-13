import '../exceptions/app_exception.dart';

enum Status { success, error }

class Result<T> {
  final Status status;
  final T? data;
  final AppException? exp;

  Result._(this.status, this.data, this.exp);

  factory Result.success(T data) => Result._(Status.success, data, null);

  factory Result.error(AppException exp, {T? data}) =>
      Result._(Status.error, data, exp);

  bool get isSuccess => status == Status.success;

  void when({
    required Function(T data) onSuccess,
    required Function(AppException exp) onError,
  }) {
    if (isSuccess && data != null) {
      onSuccess(data as T);
    } else if (!isSuccess && exp != null) {
      onError(exp!);
    }
  }
}
