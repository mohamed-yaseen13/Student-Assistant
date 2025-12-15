import 'package:student_assistant/core/database/database.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';

class OtpApiService {
  final Database database;

  OtpApiService({required this.database});

  Future<void> verifyOtp(String email, String otp) async {
    final bool isCorrect = await database.isOtpCorrect(email, otp);
    if (!isCorrect) throw Exception('OTP is incorrect');
    database.deleteOtp(email);
    await SharedPrefs.setIsUserLoggedIn();
    await SharedPrefs.setUserEmail(email);
  }
}
