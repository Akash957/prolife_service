import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:prolife_service/provider/address_provider.dart';
import 'package:prolife_service/provider/auth_provider.dart';
import 'package:prolife_service/provider/location_provider.dart';
import 'package:prolife_service/provider/profile_provider.dart';
import 'package:prolife_service/view/screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'getx_service/language_service.dart';
import 'notification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0x00ffffff),
    statusBarBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp(
    name: 'image-uplode-4d545',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(LanguageService());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider(),)
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProLife Service',
      home: SplashScreen(),
    );
  }
}

