import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../bottonNavigation/botton_nav.dart';
import '../global_widget/textfield_widget.dart';
import '../provider/profile_provider.dart';

class StoreUserDetails extends StatefulWidget {
  final String phoneNumber;
  const StoreUserDetails({super.key, required this.phoneNumber});

  @override
  State<StoreUserDetails> createState() => _StoreUserDetailsState();
}

class _StoreUserDetailsState extends State<StoreUserDetails> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
            "Create Profile",
          )),
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context, provider, _) {

            provider.phoneController.text = widget.phoneNumber;
            final imageUrl = provider.userData?['imageUrl'];
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : (imageUrl != null
                          ? NetworkImage(imageUrl)
                          : const NetworkImage(
                          'https://www.gravatar.com/avatar/default?s=200'))
                      as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Enter Name",
                    controller: provider.nameController,
                  ),
                  CustomTextField(
                    hintText: "Enter Email",
                    controller: provider.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    enabled: true,
                    hintText: "Enter Phone",
                    controller: provider.phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () async {
                        await provider.saveProfile(imageFile: _selectedImage);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavScreen(),));

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Create Now",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white, // White text color
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
