import 'dart:async';
import 'package:flutter/material.dart';
import 'package:final_project/services/auth/auth_gate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../config/images.dart';
import '../../config/string.dart'; // Import the page you want to navigate to

class SplacePage extends StatefulWidget {
  const SplacePage({Key? key}) : super(key: key);

  @override
  _SplacePageState createState() => _SplacePageState();
}

class _SplacePageState extends State<SplacePage> {
  @override
  void initState() {
    super.initState();
    // Start a timer for 3 seconds
    Timer(
      const Duration(seconds: 3),
          () {
        // After 3 seconds, navigate to the AuthGate page
        Get.offAllNamed("/authGate");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsImage.appIcon,
                width: 180, // Set the width
                height: 180, // Set the height
                color: Colors.purpleAccent,
              ),
              Text(
                AppString.appName,
                style: Theme.of(context).textTheme.headlineLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
