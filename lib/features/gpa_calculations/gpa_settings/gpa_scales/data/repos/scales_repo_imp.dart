import 'package:student_assistant/core/api/api_error_handler.dart';
import 'package:student_assistant/core/api/api_result.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/data/apis/scales_api_service.dart';
import 'package:student_assistant/core/models/scale_model.dart';

class ScalesRepoImp {
  final ScalesApiService scalesApiService;

  ScalesRepoImp({required this.scalesApiService});

  final String email = SharedPrefs.getUserEmail();

  Future<ApiResult<void>> saveScale({
    required String title,
    required List<List<String>> rows,
    String? oldTitle,
  }) async {
    try {
      // convert rows and title to scale model
      final Map<String, Map<String, double>> grades = {};
      for (var row in rows) {
        final String grade = row[0];
        final String range = row[1];
        final double points = double.parse(row[2]);
        grades[range] = {grade: points};
      }
      final scale = ScaleModel(title: title, grades: grades, isSelected: false);
      //pass the scale model to api
      final response = await scalesApiService.saveScale(email, scale, oldTitle);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteScale(String title) async {
    try {
      final response = await scalesApiService.deleteScale(email, title);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> changeScale(String title) async {
    try {
      final response = await scalesApiService.changeScale(email, title);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
