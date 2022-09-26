import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/routes.dart';
import 'package:instagram/utils/sp_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SpManager sharedPreference = SpManager();
      await sharedPreference.init();
      String accessToken = await sharedPreference.getAccessToken();
      print("accessToken: $accessToken");

      Get.offAllNamed(accessToken.isNotEmpty ? mainRoute : loginRoute);
      // Get.offAllNamed(mainRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Center(child: Text('splashScreen')),
      ),
    );
  }
}
