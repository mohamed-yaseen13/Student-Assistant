import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';

class LoginApiService {
  final Database database;
  final SendEmailOtp sendEmailOtp;

  LoginApiService({required this.database, required this.sendEmailOtp});

  Future<void> login(String email) async {
    final bool isUserHasAccount = await database.checkIfEmailExist(email);
    if (!isUserHasAccount) throw Exception("Email doesn't Exist");
    final String otp = await sendEmailOtp.sendEmailOtp(email);
    await database.saveOtpToDatabase(email, otp);
  }
}
