import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mboacare/global/styles/colors.dart';
import 'package:mboacare/services/blog_provider/delete_blogProvider.dart';
import 'package:mboacare/services/blog_provider/edit_blogProvider.dart';

import 'package:mboacare/widgets/blog_input.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:provider/provider.dart';

class EditBlog extends StatefulWidget {
  const EditBlog(
      {Key? key,
      required this.id,
      required this.author,
      required this.catergory,
      required this.title,
      required this.weblink,
      required this.image})
      : super(key: key);
  final String id, title, author, catergory, weblink, image;

  @override
  _EditBlogState createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
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
    var provider = Provider.of<EditBlogProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        titleSpacing: 0.0,
        title: Text(
          widget.title,
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
        actions: [
          IconButton(
              onPressed: () {
                _showDialog(context);
              },
              icon: const Icon(
                Icons.delete_outline_outlined,
                color: Color.fromARGB(255, 225, 82, 82),
              ))
        ],
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
                    'Title *', widget.title, provider.titleController),
                const SizedBox(height: 16.0),
                blogTextFormField(
                    'Author *', widget.author, provider.authorController),
                const SizedBox(height: 16.0),
                blogTextFormField('Category *', widget.catergory,
                    provider.categoryController),
                const SizedBox(height: 16.0),
                blogTextFormField(
                    'Web Link *', widget.weblink, provider.webLinkController),
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
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Image.network(
                                widget.image,
                                fit: BoxFit.cover,
                                height: 40,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Click to update your blog header image',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 53, 52, 52)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
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
                Consumer<EditBlogProvider>(builder: (
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
                        String id = widget.id;
                        blog.editBlog(
                          title,
                          author,
                          category,
                          webLink,
                          _selectedImage,
                          id,
                          context,
                        );
                      }
                    },
                    title: "Update Blog",
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 40),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 50),
          title: const Text(
            textAlign: TextAlign.center,
            "Delete Blog",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: const Text(
            textAlign: TextAlign.center,
            "Are you sure you want to delete Blog?",
            style: TextStyle(
              fontSize: 14,
              color: AppColors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Consumer<DeleteBlogProvider>(builder: (context, blog, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (blog.reqMessage != '') {}
                      blog.clear();
                    });
                    return blog.isLoading
                        ? const SpinKitThreeBounce(
                            color: AppColors.cardbg,
                          )
                        : TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.cardbg),
                            ),
                            onPressed: () {
                              print(widget.id);
                              blog.deleteBlog(
                                  blogId: widget.id, context: context);
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ));
                  }),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
