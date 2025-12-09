import 'package:student_assistant/core/api/api_error_model.dart';

sealed class ApiResult<T> {
  const ApiResult();
  factory ApiResult.success(T data, {bool hasMore}) = Success<T>;
  factory ApiResult.failure(ApiErrorModel apiErrorModel) = Failure<T>;
}

class Success<T> extends ApiResult<T> {
  final T data;
  final bool hasMore;
  const Success(this.data, {this.hasMore = false});
}

class Failure<T> extends ApiResult<T> {
  final ApiErrorModel apiErrorModel;
  const Failure(this.apiErrorModel);
}
