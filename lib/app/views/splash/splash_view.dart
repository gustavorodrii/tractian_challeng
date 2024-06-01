import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/utils/colors/colors.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgTractianColor,
      body: Center(
        child: Image.asset('assets/icons/tractian_logo_icon.png'),
      ),
    );
  }
}
