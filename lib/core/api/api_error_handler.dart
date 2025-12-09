import 'package:flutter/material.dart';
import 'package:student_assistant/core/api/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    debugPrint(error.toString());
    switch (error.toString()) {
      case '[firebase_auth/invalid-email] The email address is badly formatted.':
        return ApiErrorModel(message: 'Please Enter a valid Email');
      default:
        return ApiErrorModel(message: 'Somthing went Wrong');
    }
  }
}
