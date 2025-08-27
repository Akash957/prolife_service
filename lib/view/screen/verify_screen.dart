// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:provider/provider.dart';
//
// import '../../provider/auth_provider.dart';
//
// class OtpVerifyScreen extends StatefulWidget {
//   const OtpVerifyScreen({super.key});
//
//   @override
//   State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
// }
//
// class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
//   late final TextEditingController otpCode = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     // Responsive pin size
//     final pinWidth = screenWidth * 0.12; // 12% of screen width
//     final pinHeight = screenHeight * 0.07; // 7% of screen height
//
//     final defaultTheme = PinTheme(
//       width: pinWidth.clamp(40, 60), // min 40, max 60
//       height: pinHeight.clamp(50, 65), // min 50, max 65
//       textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.blue),
//       ),
//     );
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height:screenHeight * 0.06,),
//                 Center(
//                   child: Image.asset(
//                     'assets/logo.png',
//                     width: 150,
//                   ),
//                 ),
//                 SizedBox(height:screenHeight * 0.08,),
//                 const Text(
//                   "Enter Phone number for verification",
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: screenHeight * 0.04),
//                 Pinput(
//                   length: 6,
//                   onChanged: (value) {
//                     setState(() {
//                       otpCode = value;
//                     });
//                   },
//                   defaultPinTheme: defaultTheme,
//                   focusedPinTheme: defaultTheme.copyWith(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.blue, width: 2),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: screenHeight * 0.06),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: otpCode.length == 6 ? () => authProvider.verifyOtp(otpCode as String, context)
//                         : null,
//                     child: const Text(
//                       "Verify",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final pinWidth = screenWidth * 0.12;
    final pinHeight = screenHeight * 0.07;

    final defaultTheme = PinTheme(
      width: pinWidth.clamp(40, 60),
      height: pinHeight.clamp(50, 65),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.06),
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                ),
                SizedBox(height: screenHeight * 0.08),
                const Text(
                  "Enter OTP for verification",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.04),

                // ✅ Pinput with controller
                Pinput(
                  length: 6,
                  controller: otpController,
                  defaultPinTheme: defaultTheme,
                  focusedPinTheme: defaultTheme.copyWith(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.06),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: otpController.text.length == 6
                        ? () => authProvider.verifyOtp(
                      otpController.text.trim(), // ✅ ab string milega
                      context,
                    )
                        : null,
                    child: const Text(
                      "Verify",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
