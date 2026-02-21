import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/helpers/functions.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';
import 'package:student_assistant/core/models/student_model.dart';

class SignupApiService {
  final SendEmailOtp sendEmailOtp;

  SignupApiService({required this.sendEmailOtp});

  Future<bool> checkIfEmailExist(String email) async {
    final doc = await getEmailRef(email).get();
    return doc.exists;
  }

  Future<void> saveOtpToDatabase(String email, String otp) async {
    final expiresAt = DateTime.now().add(const Duration(minutes: 1));
    await getEmailRef(
      email,
    ).set({'otp': otp, "expiresAt": Timestamp.fromDate(expiresAt)});
  }

  Future<void> saveStudentToDatabase(String email, String username) async {
    final student = StudentModel(
      name: username,
      scales: {AppConstants.defaultScale.title: AppConstants.defaultScale},
    );
    // firebase database
    await getEmailRef(email).set({
      ...student.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    // local database
    final box = AppConstants.box;
    await box.put(email, student);
  }

  Future<void> signup(String email, String username) async {
    final bool isUserHasAccount = await checkIfEmailExist(email);
    if (isUserHasAccount) throw Exception('Email already Exist');
    final String otp = await sendEmailOtp.sendEmailOtp(email);
    await saveOtpToDatabase(email, otp);
    await saveStudentToDatabase(email, username);
  }
}
