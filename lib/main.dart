import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prolife_service/profile_screen/app_translations.dart';
import 'package:prolife_service/provider/location_provider.dart';
import 'package:prolife_service/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:prolife_service/provider/auth_provider.dart';
import 'package:prolife_service/view/screen/splash_screen.dart';
import 'firebase_options.dart';
import 'getx_service/language_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => LanguageService().init());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Firebase.initializeApp(
    name: 'image-uplode-4d545',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
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

      translationsKeys: AppTranslations.translations,
      locale: Locale(LanguageService.to.currentLocale),
      fallbackLocale: const Locale('en'),
      title: 'ProLife Service',
      home: const SplashScreen(),
    );
  }
}
