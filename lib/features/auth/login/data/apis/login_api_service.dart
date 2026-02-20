import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/helpers/functions.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';

class LoginApiService {
  final SendEmailOtp sendEmailOtp;

  LoginApiService({required this.sendEmailOtp});

  Future<bool> checkIfEmailExist(String email) async {
    final doc = await getEmailRef(email).get();
    return doc.exists;
  }

  Future<void> saveOtpToDatabase(String email, String otp) async {
    final expiresAt = DateTime.now().add(const Duration(minutes: 1));
    await getEmailRef(email).set({
      'otp': otp,
      "expiresAt": Timestamp.fromDate(expiresAt),
    }, SetOptions(merge: true));
  }

  Future<void> login(String email) async {
    final bool isUserHasAccount = await checkIfEmailExist(email);
    if (!isUserHasAccount) throw Exception("Email doesn't Exist");
    final String otp = await sendEmailOtp.sendEmailOtp(email);
    await saveOtpToDatabase(email, otp);
  }
}
