import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mboacare/services/blog_provider/add_blogProvider.dart';
import 'package:mboacare/widgets/blog_input.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:provider/provider.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
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
    var provider = Provider.of<AddBlogProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        titleSpacing: 0.0,
        title: Text(
          'Submit Blog',
          style: GoogleFonts.inter(
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 25.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blogTextFormField(
                    'Title *', 'Enter Blog Title', provider.titleController),
                const SizedBox(height: 16.0),
                blogTextFormField(
                    'Author *', 'Enter Blog Author', provider.authorController),
                const SizedBox(height: 16.0),
                blogTextFormField('Category *', 'Enter Category',
                    provider.categoryController),
                const SizedBox(height: 16.0),
                blogTextFormField('Web Link *', 'Enter web address',
                    provider.webLinkController),
                const SizedBox(height: 20.0),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1.5)),
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
                          child: const Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(Iconsax.document_upload),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Click to upload your blog header image',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 53, 52, 52)),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'PNG, JPG',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(115, 7, 7, 7)),
                              )
                            ],
                          ),
                        ),
                ),
                SizedBox(height: height * 0.08),
                Consumer<AddBlogProvider>(builder: (
                  context,
                  blog,
                  child,
                ) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (blog.reqMessage != '') {
                      blog.clear();
                    }
                  });
                  return AppButton(
                    onPressed: () {
                      if (provider.formKey.currentState!.validate()) {
                        String title = provider.titleController.text;
                        String author = provider.authorController.text;
                        String category = provider.categoryController.text;
                        String webLink = provider.webLinkController.text;
                        blog.addBlog(
                          title,
                          author,
                          category,
                          webLink,
                          _selectedImage,
                          context,
                        );
                      }
                    },
                    title: "Submit",
                    enabled: true,
                    status: blog.isLoading,
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
