enum Status { success, error }

class Result<T> {
  final Status status;
  final T? data;
  final AppException? exp;

  Result(this.status, this.data, this.exp);

  factory Result.success(T? data) {
    return Result(Status.success, data, null);
  }

  factory Result.error(
    AppException? exp, {
    T? data,
  }) {
    return Result(Status.error, data, exp);
  }
}
