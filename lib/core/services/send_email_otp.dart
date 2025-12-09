import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SendEmailOtp {
  static Future<String?> checkEmailProvider(String email) async {
    final domain = email.split('@').last;
    final url = Uri.parse("https://dns.google/resolve?name=$domain&type=MX");

    final response = await http.get(url);
    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);

    if (data["Answer"] == null) return null;

    final answers = (data["Answer"] as List)
        .map((e) => e["data"].toString())
        .toList();

    if (answers.any((r) => r.contains("google.com"))) {
      return "Google";
    } else if (answers.any(
      (r) => r.contains("outlook.com") || r.contains("microsoft.com"),
    )) {
      return "Microsoft";
    }

    return null;
  }

  Future<String> sendEmailOtp(String email) async {
    final provider = await checkEmailProvider(email);

    if (provider == null) {
      throw Exception('Not Supported Email');
    }

    final serviceId = provider == 'Google'
        ? 'service_zbm0vb8'
        : 'service_s4p7bdl';

    final String fromEmail = provider == 'Google'
        ? '01221316865m@gmail.com'
        : 'es-mohamedlotfy2025@alexu.edu.eg';

    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");

    final otp = (1000 + Random().nextInt(9000)).toString();

    final formattedTime = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());

    await http.post(
      url,
      headers: {
        'origin': 'http:/localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "service_id": serviceId,
        "template_id": "template_npctz7r",
        "user_id": "EvujsAAehpMxYQef_",
        "template_params": {
          "passcode": otp,
          "time": formattedTime,
          "to_email": email,
          "from_email": fromEmail,
          'app_name': 'Student Assistant App',
        },
      }),
    );

    return otp;
  }
}
