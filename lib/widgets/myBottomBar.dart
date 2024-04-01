import 'package:flutter/material.dart';
import 'package:mboacare/global/styles/colors.dart';
import '../../global/styles/assets_string.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mboacare/global/styles/appStyles.dart';

class MyBottomBar extends StatelessWidget {
  MyBottomBar({Key? key, required this.index, required this.tap})
      : super(key: key);
  Function(int) tap;
  int index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      currentIndex: index,
      onTap: tap,
      selectedItemColor: AppColors.buttonColor,
      iconSize: iconSize,
      unselectedItemColor: AppColors.grey,
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      unselectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageAssets.unSelectHome,
              width: 20.0,
              height: 20.0,
            ),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              ImageAssets.selectHome,
              width: 20.0,
              height: 20.0,
            )),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(ImageAssets.unSelectHospital,
                width: 20.0, height: 20.0),
            label: 'Hospitals',
            activeIcon: SvgPicture.asset(
              ImageAssets.selectHospital,
              width: 20.0,
              height: 20.0,
            )),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageAssets.unSelectedBlog,
              width: 20.0,
              height: 20.0,
            ),
            label: 'Blogs',
            activeIcon: SvgPicture.asset(
              ImageAssets.selectedBlog,
              width: 20.0,
              height: 20.0,
            )),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageAssets.unSelectedUser,
              width: 20.0,
              height: 20.0,
            ),
            label: 'Settings',
            activeIcon: SvgPicture.asset(
              ImageAssets.selectedUser,
              width: 20.0,
              height: 20.0,
            )),
      ],
    );
  }
}
