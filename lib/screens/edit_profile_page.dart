import 'package:flutter/material.dart';
import 'package:prolife_service/global_widget/textfield_widget.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage('https://example.com/profile.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Neeraj Kumar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
              ],
            ),
            Expanded(
                child: Column(

              children: [
                CustomTextField(
                    hintText: "Enter Name", controller: nameController),
                CustomTextField(
                    hintText: "Enter Email", controller: emailController),
                CustomTextField(
                    hintText: "Enter Phone", controller: phoneController),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90, vertical: 12),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
