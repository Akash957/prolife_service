import 'package:flutter/material.dart';
import 'package:prolife_service/global_widget/textfield_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/profile_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Consumer<ProfileProvider>(
            builder: (context, provider, child){
              if (provider.nameController.text.isEmpty && provider.emailController.text.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.userData == null) {
                return const Center(child: Text('No user data found.'));
              }
              return Column(
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(provider.userData!['photoUrl'] ?? ''),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    provider.userData!['name'] ?? '',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Column(
                      children: [
                        CustomTextField(hintText: "Enter Name", controller: provider.nameController),
                        CustomTextField(hintText: "Enter Email", controller: provider.emailController),
                        CustomTextField(hintText: "Enter Phone", controller: provider.phoneController),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 12),
                          ),
                          onPressed: provider.updateProfile,
                          child: const Text(
                            'UPDATE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } ,
          )
      ),
    );
  }
}
