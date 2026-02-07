import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/features/gpa_calculations/gpa_settings/gpa_scales/models/scale_model.dart';

class ScalesApiService {
  ScalesApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

  Future<List<ScaleModel>> getAllScales(String email) async {
    final doc = await getEmailRef(email).get();
    final scalesRaw = doc.data()?['scales'];
    if (scalesRaw == null || scalesRaw is! Map) return [];

    return scalesRaw.values
        .map((e) => ScaleModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveScale(
    String email,
    ScaleModel scale,
    String? oldTitle,
  ) async {
    final docRef = getEmailRef(email);
    if (oldTitle != null) {
      await docRef.update({'scales.$oldTitle': FieldValue.delete()});
    }
    await docRef.update({'scales.${scale.title}': scale.toMap()});
  }

  Future<void> deleteScale(String email, String title) async {
    await getEmailRef(email).update({'scales.$title': FieldValue.delete()});
  }

  Future<void> changeScale(String email, String title) async {
    final scales = await getAllScales(email);
    final selectedScale = scales.firstWhere((s) => s.isSelected);
    await getEmailRef(
      email,
    ).update({'scales.${selectedScale.title}.isSelected': false});
    await getEmailRef(email).update({'scales.$title.isSelected': true});
  }
}
