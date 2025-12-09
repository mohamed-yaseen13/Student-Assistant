import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';
import 'package:student_assistant/core/services/send_email_otp.dart';

class AuthApiService {
  final Database database;
  final SendEmailOtp sendEmailOtp;

  AuthApiService({required this.database, required this.sendEmailOtp});

  Future<bool> firstStepOfAuth(String email) async {
    final bool isUserHasAccount = await database.checkIfEmailExist(email);
    final String otp = await sendEmailOtp.sendEmailOtp(email);
    await database.saveOtpToDatabase(email, otp);
    return isUserHasAccount;
  }

  Future<void> secondStepOfAuth(String email, String otp) async {
    final bool isCorrect = await database.isOtpCorrect(email, otp);
    if (isCorrect) database.deleteOtp(email);
    await SharedPrefs.setIsUserLoggedIn();
  }
}
