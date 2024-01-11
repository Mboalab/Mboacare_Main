import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboacare/global/styles/appStyles.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/facilities_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/custom_textfield.dart';

class AddFacilitiesPage extends StatefulWidget {
  const AddFacilitiesPage({super.key});

  @override
  State<AddFacilitiesPage> createState() => _AddFacilitiesPageState();
}

class _AddFacilitiesPageState extends State<AddFacilitiesPage> {
  String selectedSize = 'Select hospital type';
  List<String> size = [
    'Public',
    'Private',
    'Other',
  ];
  String selectedType = 'Select hospital size';
  List<String> type = [
    'Small',
    'Medium',
    'Large',
  ];
  String selectedOwnership = 'Select hospital ownership';
  List<String> ownership = [
    'Individual',
    'Corporate',
    'Government',
  ];

  bool isSize = false;
  bool isType = false;
  bool isOwnership = false;
  int selectedIndex = 0;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
        log(_selectedImage.toString());
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  List<String> facilitiesTags = [];
  List<String> medicalTags = [];
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();
  TextEditingController medicalTagsController = TextEditingController();
  TextEditingController facilitiesTagsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final facilitiesProvider = Provider.of<FacilitiesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.registerCard,
        leading: IconButton(
            color: AppColors.secondaryTextColor,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
        title: Text(
          'Back',
          style: AppTextStyles.bodyOne.copyWith(
              fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.grey),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Hospital Information',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.buttonColor),
                ),
                const Divider(
                  color: AppColors.buttonColor,
                  thickness: 2.5,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Hospital name *',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Central Park Hospital',
                  controller: _nameController,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Hospital Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.grey300, width: 1.5)),
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          height: 150,
                        )
                      : InkWell(
                          onTap: () {
                            _pickImage();
                          },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SvgPicture.asset('lib/assests/icons/upload.svg'),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Click to upload your hospital image',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'SVG, PNG, JPG or GIF (max. 800x400px)',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.grey),
                              )
                            ],
                          ),
                        ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // facilitiesProvider.addFacilities(
                        //     name: _nameController.text,
                        //     email: _emailController.text,
                        //     website: _websiteController.text,
                        //     phoneno: _phoneNoController.text,
                        //     latitude: '20.00',
                        //     longitude: '30.00',
                        //     hospitalAddress: _addressController.text,
                        //     serviceType: medicalTags,
                        //     context: context,
                        //     facilitiesType: facilitiesTags,
                        //     hospitalType: selectedType,
                        //     hospitalOwner: selectedOwnership,
                        //     hospitalSize: selectedSize,
                        //     hospitalImage: _selectedImage!);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      foregroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: const Size(150, 45),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
