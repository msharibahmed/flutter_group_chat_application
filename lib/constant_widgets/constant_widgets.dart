import 'package:flutter/material.dart';

class ConstantWidgets {
  //Circular progress Indicator wrapped with Center Widget
  final Center loadingWidgdet = const Center(
      child: const CircularProgressIndicator(
          strokeWidth: 1, backgroundColor: Colors.black));

//SnackBar
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      BuildContext context, String text) {
    return Scaffold.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(text)));
  }
}
