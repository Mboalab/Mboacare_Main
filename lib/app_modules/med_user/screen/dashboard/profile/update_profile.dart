import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/settings.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/auth_provider/update_profileProvider.dart';
import 'package:mboacare/widgets/blog_input.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var provider = Provider.of<UpdateProfileProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        titleSpacing: 0.0,
        title: Text(
          'Update Profile',
          style: GoogleFonts.inter(
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const Settings(),
                duration: const Duration(
                  milliseconds: 800,
                ),
                curve: Curves.easeInCirc,
                transition: Transition.fadeIn);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 25.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Form(
          key: provider.profileFormKey,
          child: Column(
            children: [
              SizedBox(height: height * 0.04),
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.navbar,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.cardbg, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ClipOval(
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: 130,
                              height: 130,
                            )
                          : InkWell(
                              onTap: () {
                                _pickImage();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Icon(Iconsax.document_upload),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Upload Image',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 53, 52, 52)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              blogTextFormField(
                  'Full Name', 'Enter full name', provider.nameController),
              SizedBox(height: height * 0.02),
              blogTextFormField('Phone Number', 'Enter valid phone number',
                  provider.phoneController),
              SizedBox(height: height * 0.08),
              Consumer<UpdateProfileProvider>(builder: (
                context,
                profile,
                child,
              ) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (profile.reqMessage != '') {
                    profile.clear();
                  }
                });
                return AppButton(
                  onPressed: () {
                    if (provider.profileFormKey.currentState!.validate()) {
                      String name = provider.nameController.text;
                      String phone = provider.phoneController.text;

                      profile.updateProfile(
                        name,
                        phone,
                        _selectedImage,
                        context,
                      );
                    }
                  },
                  title: "Update Profile",
                  enabled: true,
                  status: profile.isLoading,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
