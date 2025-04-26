import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import for SystemChrome
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prolife_service/view/screen/splash_screen.dart';
import 'firebase_options.dart';
import 'home_page_view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0x00ffffff), statusBarBrightness: Brightness.dark));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProLife Service',
      home: const SplashScreen());
  }
}
