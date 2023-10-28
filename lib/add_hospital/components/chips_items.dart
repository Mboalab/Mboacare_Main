import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/colors.dart';

import '../../utils/constants.dart';

class ChipListView extends StatefulWidget {
  const ChipListView({
    super.key,
    required this.onRemoveClicked,
    required this.listItems,
    required this.textController,
  });

  final Function() onRemoveClicked;
  final List<String> listItems;
  final TextEditingController textController;

  @override
  State<ChipListView> createState() => _ChipListViewState();
}

class _ChipListViewState extends State<ChipListView> {

  void removeChip(int index) {
    setState(() {
      widget.listItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.listItems.asMap().entries.map((entry) {
        final index = entry.key;
        final items = entry.value;
        debugPrint("Chips title: $items");
        return ChipItem(
          chipTitle: items,
          onRemoveClicked: ()=> removeChip(index),
        );
      }).toList(),
    );
  }
}


class ChipItem extends StatelessWidget {
  const ChipItem({super.key, required this.chipTitle, required this.onRemoveClicked});

  final String chipTitle;
  final Function() onRemoveClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFA6A6A6)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            chipTitle,
            style: GoogleFonts.inter(
              color: AppColors.primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 9),
          InkWell(
            onTap: onRemoveClicked,
            child: SvgPicture.asset(
              AppImages.closeIcon,
            ),
          )
        ],
      ),
    );
  }
}