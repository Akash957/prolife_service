import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prolife_service/view/screen/singup_screen.dart';

import '../home_page_view/home_screen.dart';
import '../models/user_model.dart';
import '../notification/device_token_services.dart';
import '../view/screen/account_create_successfully.dart';
import '../view/screen/verify_screen.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? currentUser;
  UserModel? currentUserModel;
  bool isLoading = false;

  AuthProvider() {
    auth.authStateChanges().listen((user) async {
      currentUser = user;
      if (user != null) {
        await loadUserData(user.uid);
      }
      notifyListeners();
    });
  }

  Future<void> loadUserData(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        currentUserModel = UserModel.fromMap(doc.data()!);
      }
    } catch (e) {
      debugPrint("Error loading user data: $e");
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      setLoading(true);
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AccountCreateSuccessfully(),
            ));
        await checkAndCreateUser(userCredential.user!);
      }
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> checkAndCreateUser(User user) async {
    final userDoc = await firestore.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      final newUser = UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        imageUrl: user.photoURL,
        phone: '',
      );
      await firestore.collection('users').doc(user.uid).set(newUser.toMap());
      currentUserModel = newUser;
    } else {
      currentUserModel = UserModel.fromMap(userDoc.data()!);
    }
    await DeviceTokenServices().storeDeviceToken();
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      setLoading(true);
      await googleSignIn.signOut().catchError((e) {
        debugPrint("Google Sign Out Error: $e");
      });
      await auth.signOut().catchError((e) {
        debugPrint("Firebase Sign Out Error: $e");
      });
      currentUserModel = null;
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignUpScreen()),
        (route) => false,
      );

      notifyListeners();
    } catch (e) {
      debugPrint("Sign Out Error: $e");
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }



  String? _verificationId;
  bool isOtpSent = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> sendOtp(String phoneNumber, BuildContext context) async {
    _setLoading(true);

    await auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        _setLoading(false);
      },
      verificationFailed: (FirebaseAuthException e) {
        _setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Verification failed")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        isOtpSent = true;
        _setLoading(false);
        notifyListeners();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpVerifyScreen(),));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> verifyOtp(String otp, BuildContext context) async {
    _setLoading(true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,

      );
      await auth.signInWithCredential(credential);
      _setLoading(false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

    } catch (e) {
      _setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await auth.signOut();
    notifyListeners();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OtpVerifyScreen()),
          (route) => false,
    );
  }




}
