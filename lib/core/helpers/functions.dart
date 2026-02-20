import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_assistant/core/constants/app_constants.dart';
import 'package:student_assistant/core/constants/database_constants.dart';
import 'package:student_assistant/core/helpers/shared_prefs.dart';

DocumentReference<Map<String, dynamic>> getEmailRef(String email) =>
    FirebaseFirestore.instance
        .collection(DatabaseConstants.emailsCollection)
        .doc(email);

Future<void> printStudentDataFromFirestore() async {
  final email = SharedPrefs.getUserEmail();
  final doc = await getEmailRef(email).get();
  final data = doc.data();
  try {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');

    final Map<String, dynamic> printableData = {
      for (final entry in data!.entries)
        if (entry.value is! Timestamp) entry.key: entry.value,
    };

    debugPrint(encoder.convert(printableData), wrapWidth: 1024);
  } catch (e, stackTrace) {
    debugPrint("JSON PRINT ERROR: $e");
    debugPrint(stackTrace.toString());
  }
}

void printStudentDataFromHive() {
  final box = AppConstants.box;
  final student = box.values.first;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  debugPrint(encoder.convert(student.toJson()));
}
