import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';
import 'package:student_assistant/features/auth/signup/models/student_model.dart';

class SignupApiService {
  final SendEmailOtp sendEmailOtp;

  SignupApiService({required this.sendEmailOtp});

  DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
      FirebaseFirestore.instance
          .collection(DatabaseConstants.emailsCollection)
          .doc(email);

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

  Future<void> saveStudentToDatabase(String email, String username) async {
    final studentMap = {
      ...StudentModel(
        name: username,
        scales: {AppConstants.defaultScale.title: AppConstants.defaultScale},
      ).toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    };
    await getEmailRef(email).set(studentMap, SetOptions(merge: true));
  }

  Future<void> signup(String email, String username) async {
    final bool isUserHasAccount = await checkIfEmailExist(email);
    if (isUserHasAccount) throw Exception('Email already Exist');
    final String otp = await sendEmailOtp.sendEmailOtp(email);
    await saveOtpToDatabase(email, otp);
    await saveStudentToDatabase(email, username);
  }
}
