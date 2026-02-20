import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/functions.dart';
import 'package:student_assistant/core/models/scale_model.dart';

class ScalesApiService {
  ScalesApiService();

  Future<void> saveScale(
    String email,
    ScaleModel scale,
    String? oldTitle,
  ) async {
    final docRef = getEmailRef(email);
    final box = AppConstants.box;
    final student = box.values.first;
    final updatedScales = Map<String, ScaleModel>.from(box.values.first.scales);
    bool isSelected = false;
    if (oldTitle != null) {
      isSelected = true;
      // local
      updatedScales.remove(oldTitle);
      // firestore
      await docRef.update({'scales.$oldTitle': FieldValue.delete()});
    }
    // local
    updatedScales[scale.title] = scale;
    updatedScales[scale.title]!.isSelected = isSelected;
    await box.put(email, student.copyWith(scales: updatedScales));
    // firestore
    await docRef.update({
      'scales.${scale.title}': scale.toJson(),
      'scales.${scale.title}.isSelected': isSelected,
    });
  }

  Future<void> deleteScale(String email, String title) async {
    // local
    final box = AppConstants.box;
    final student = box.values.first;
    final updatedScales = Map<String, ScaleModel>.from(box.values.first.scales);
    updatedScales.remove(title);
    await box.put(email, student.copyWith(scales: updatedScales));
    // firestore
    await getEmailRef(email).update({'scales.$title': FieldValue.delete()});
  }

  Future<void> changeScale(String email, String title) async {
    final box = AppConstants.box;
    final student = box.values.first;
    final updatedScales = Map<String, ScaleModel>.from(box.values.first.scales);
    final selectedScale = box.values.first.scales.values.firstWhere(
      (s) => s.isSelected,
    );
    // local
    updatedScales[selectedScale.title]!.isSelected = false;
    updatedScales[title]!.isSelected = true;
    await box.put(email, student.copyWith(scales: updatedScales));
    // firestore
    await getEmailRef(
      email,
    ).update({'scales.${selectedScale.title}.isSelected': false});
    await getEmailRef(email).update({'scales.$title.isSelected': true});
  }
}
