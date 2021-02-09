import 'package:flutter/material.dart';
import 'package:flutter_group_chat_application/constant_widgets/constant_widgets.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstantWidgets().loadingWidgdet,
    );
  }
}
