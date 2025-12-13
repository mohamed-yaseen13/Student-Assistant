import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';

class SignupApiService {
  final Database database;
  final SendEmailOtp sendEmailOtp;

  SignupApiService({required this.database, required this.sendEmailOtp});

  Future<void> signup(String email, String username) async {
    final bool isUserHasAccount = await database.checkIfEmailExist(email);
    if (isUserHasAccount) throw Exception('Email already Exist');
    final String otp = await sendEmailOtp.sendEmailOtp(email);
    await database.saveOtpToDatabase(email, otp);
    await database.saveUsernameToDatabase(email, username);
  }
}
