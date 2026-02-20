import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/functions.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/core/models/student_model.dart';

class OtpApiService {
  OtpApiService();

  Future<bool> isOtpCorrect(String email, String otp) async {
    final doc = await getEmailRef(email).get();
    final String savedOtp = doc.data()!['otp'];
    final Timestamp expiresAtTs = doc.data()!['expiresAt'];
    final DateTime expiresAt = expiresAtTs.toDate();
    return savedOtp == otp && DateTime.now().isBefore(expiresAt);
  }

  Future<void> deleteOtp(String email) async {
    await getEmailRef(
      email,
    ).update({'otp': FieldValue.delete(), 'expiresAt': FieldValue.delete()});
  }

  Future<void> verifyOtp(String email, String otp) async {
    final bool isCorrect = await isOtpCorrect(email, otp);
    if (!isCorrect) throw Exception('OTP is incorrect');
    await deleteOtp(email);
    await SharedPrefs.setIsUserLoggedIn();
    await SharedPrefs.setUserEmail(email);
    // update the hive box with firebase data in case user is loginning in
    final doc = await getEmailRef(email).get();
    final data = doc.data()!;
    final StudentModel student = StudentModel.fromJson(data);
    final box = AppConstants.box;
    await box.put(email, student);
  }
}
