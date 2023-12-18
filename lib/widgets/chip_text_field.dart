import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/colors.dart';

class ChipTextFieldScreen extends StatefulWidget {
  final String hintText;
  List<String> tag;
  final Function(String)? onFieldSubmitted;

  ChipTextFieldScreen({
    super.key,
    required this.hintText,
    required this.tag,
    this.onFieldSubmitted,
  });

  @override
  State<ChipTextFieldScreen> createState() => _ChipTextFieldScreenState();
}

class _ChipTextFieldScreenState extends State<ChipTextFieldScreen> {
  TextEditingController tagsController = TextEditingController();
  List<String> tags = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tags.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                itemCount: tags.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 45,
                ),
                itemBuilder: (context, index) => Chip(
                  backgroundColor: Colors.white,
                  label: Text(
                    tags[index],
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 17),
                  ),
                  deleteIconColor: Colors.black,
                  padding: const EdgeInsets.all(0),
                  onDeleted: () {
                    setState(() {
                      tags.remove(tags[index]);
                    });
                  },
                ),
              )
            : const SizedBox.shrink(),
        TextFormField(
          controller: tagsController,
          cursorColor: Colors.teal,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.grey300, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.grey300, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.grey300, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            hintText: widget.hintText,
          ),
          onFieldSubmitted: (_) {
            setState(() {
              tags.add(tagsController.text);
              widget.tag = tags;
              print(tags);
              print('gg${widget.tag}');
              tagsController.text = '';
            });
          },
        ),
      ],
    );
  }
}
