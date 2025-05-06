import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Widget getCircularProgressIndicator() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

void handleErrors(BuildContext context, dynamic error) {
  if (!context.mounted) return;

  String errorMessage = "An unknown error occurred";
  String errorTitle = "Error";
  IconData errorIcon = Icons.error_outline;
  Color errorColor = Colors.red;

  if (error is String) {
    errorMessage = error;
    if (error.toLowerCase().contains("warning")) {
      errorTitle = "Warning";
      errorIcon = Icons.warning_amber_rounded;
      errorColor = Colors.orange;
    }
  } else if (error is FirebaseAuthException) {
    // Firebase Authentication errors
    errorTitle = "Authentication Error";
    errorIcon = Icons.lock_outline;
    errorColor = Colors.deepOrange;

    errorMessage = error.message ?? "An authentication error occurred.";
  } else if (error is FirebaseException) {
    // General Firebase errors
    errorTitle = "Firebase Error";
    errorIcon = Icons.cloud_off;
    errorColor = Colors.purple;

    errorMessage = error.message ?? "A Firebase error occurred: ${error.code}";
  } else if (error is Exception) {
    errorMessage = error.toString().replaceFirst("Exception: ", "");
  } else if (error is Error) {
    errorTitle = "Application Error";
    errorIcon = Icons.bug_report;
    errorMessage = "Application error: ${error.toString()}";
  }

  // Log the error
  print("Error handled: $error");

  // Show error dialog
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(errorIcon, color: errorColor, size: 24),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              errorTitle,
              style: TextStyle(
                color: errorColor,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                errorMessage,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                "Please try again or contact support if the issue persists.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "OK",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

void getGreenSnackBar({
  required BuildContext context,
  dynamic message,
  Color backgroundColor = Colors.green,
  Duration duration = const Duration(seconds: 3),
}) {
  if (!context.mounted) return;

  String displayMessage = "Action completed successfully";

  if (message is String) {
    displayMessage = message;
  } else if (message != null) {
    displayMessage = message.toString();
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(displayMessage),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: duration,
    ),
  );
}

void showProgressDialogEasyLoading() {
  EasyLoading.show(
    status: 'Please Wait...',
    maskType: EasyLoadingMaskType.black,
  );
}

void dismissProgressEasyLoading() {
  EasyLoading.dismiss();
}
