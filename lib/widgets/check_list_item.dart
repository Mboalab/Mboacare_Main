import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/widgets/extensions.dart';

import '../global/styles/colors.dart';
import '../utils/constants.dart';

class CheckItemList extends StatefulWidget {
  const CheckItemList({super.key,
    required this.onCloseIconClicked,
    required this.onItemClicked,
    required this.listItems,
    required this.pageTitle
  });

  final Function() onCloseIconClicked;
  final Function(String?, bool?) onItemClicked;
  final List<String> listItems;
  final String pageTitle;

  @override
  State<CheckItemList> createState() => _CheckItemListState();
}

class _CheckItemListState extends State<CheckItemList> {
  String? selectedItem;

  void handleItemSelected(String? title) {
    setState(() {
      selectedItem = title;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 250,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.pageTitle,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: widget.onCloseIconClicked,
                  child: SvgPicture.asset(
                    AppImages.closeIcon,
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.borderColor,),
          SizedBox(height: AppFontSizes.fontSize8,),
          Column(
            children: [
              SizedBox(
                height: context.getHeight() * 0.2,
                child: ListView.builder(
                    itemCount: widget.listItems.length,
                    itemBuilder: (context, index) {
                      final items = widget.listItems[index];

                      return CheckItems(
                        title: items,
                        onItemClicked: widget.onItemClicked,
                        isSelected: selectedItem == items,
                        onItemSelected: (selected) {
                          if (selected) {
                            handleItemSelected(items);
                          } else {
                            handleItemSelected(null);
                          }
                        },
                      );
                    }
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


class CheckItems extends StatelessWidget {
  const CheckItems({super.key,
    required this.onItemClicked,
    required this.title,
    required this.isSelected,
    required this.onItemSelected,
  });

  final Function(String?, bool?) onItemClicked;
  final Function(bool) onItemSelected;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          onItemSelected(true);
          onItemClicked(title, isSelected);
          Navigator.pop(context);
        },
        child: Container(
          width: 242,
          height: 32,
          decoration: BoxDecoration(color:
          isSelected ? const Color(0xFFE6EAEE) : Colors.white
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Image.asset(
                  isSelected
                      ? AppImages.checkRingIcon
                      : AppImages.uncheckRingIcon,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.07,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
