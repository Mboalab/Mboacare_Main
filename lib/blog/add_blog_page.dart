import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mboacare/appStyles.dart';
import 'package:mboacare/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'blog_data.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _webLinkController = TextEditingController();
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.registerCard,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.primaryColor,
              )),
          centerTitle: true,
          title: Text(
            "New Blog",
            style: AppTextStyles.headerThree.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.primaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(
              _formKey,
              _titleController,
              _categoryController,
              _webLinkController,
              _selectedImage,
              _pickImage,
            ),
          ),
        ));
  }
}

Widget _buildForm(
  GlobalKey<FormState> formKey,
  TextEditingController titleController,
  TextEditingController categoryController,
  TextEditingController webLinkController,
  File? selectedImage,
  Function() pickImage,
) {
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTextFormField('Title *', 'Enter Blog Title', titleController),
        const SizedBox(height: 16.0),
        _buildTextFormField('Category', 'Enter Category', categoryController),
        const SizedBox(height: 16.0),
        _buildTextFormField(
            'Web Link *', 'Enter web address', webLinkController),
        const SizedBox(height: 16.0),
        const SizedBox(
          height: 20,
        ),
        _buildImagePicker(selectedImage, pickImage),
        const SizedBox(height: 32.0),
        _buildSubmitButton(
          formKey,
          titleController,
          categoryController,
          webLinkController,
          selectedImage,
        )
      ],
    ),
  );
}

Widget _buildTextFormField(
    String label, String hintText, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              border: InputBorder.none),
        ),
      )
    ],
  );
}

Widget _buildImagePicker(
  File? selectedImage,
  Function() pickImage,
) {
  return Container(
    height: 150,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey, width: 1.5)),
    child: selectedImage != null
        ? Image.file(
            selectedImage,
            fit: BoxFit.cover,
            height: 150,
          )
        : InkWell(
            onTap: () {
              pickImage();
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
                      fontSize: 16, color: Color.fromARGB(115, 7, 7, 7)),
                )
              ],
            ),
          ),
  );
}

Widget _buildSubmitButton(
  GlobalKey<FormState> formKey,
  TextEditingController titleController,
  TextEditingController categoryController,
  TextEditingController webLinkController,
  File? selectedImage,
) {
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController webLinkController = TextEditingController();

  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState!.validate()) {
        String title = titleController.text;
        String category = categoryController.text;
        String webLink = webLinkController.text;
        addBlog(title, category, webLink, selectedImage);
      }
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.cardbg,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
    child: const Text('Submit',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
  );
}
