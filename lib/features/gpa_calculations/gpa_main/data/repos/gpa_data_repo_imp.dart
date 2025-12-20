import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/data/apis/gpa_data_api_service.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_main/models/gpa_data_model.dart';

class GpaDataRepoImp {
  final GpaDataApiService gpaDataApiService;

  GpaDataRepoImp({required this.gpaDataApiService});

  Future<ApiResult<GpaDataModel>> getGpaData() async {
    final String email = SharedPrefs.getUserEmail();
    try {
      final response = await gpaDataApiService.getGpaData(email);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
