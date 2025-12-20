import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';

class OtpApiService {
  OtpApiService();

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

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
  }
}
