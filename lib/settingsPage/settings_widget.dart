import 'package:flutter/material.dart';
import 'package:mboacare/colors.dart';

class SettingsPageListTiles extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final Widget trailingIcon;
  final Function()? onTap;

  const SettingsPageListTiles(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.trailingIcon,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: icon,
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textColor2,
                  fontWeight: FontWeight.w600),
            ),
            Text(subtitle,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          ]),
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 17,
          ),
        ),
      ),
    );
  }
}

class Signout extends StatelessWidget {
  final Widget icon;
  final String title;

  final Function()? onTap;
  const Signout(
      {required this.icon,
      required this.title,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: icon,
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: AppColors.textColor2,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class DeleteAccount extends StatelessWidget {
  final Widget icon;
  final String title;

  final Function()? onTap;
  const DeleteAccount(
      {required this.icon,
      required this.title,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: icon,
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.redAccent,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class RadioTile extends StatelessWidget {
  final int value;
  final int? groupValue;
  // final Function(bool?)? focusNode;
  final dynamic onchanged;
  final String text;
  const RadioTile(
      {required this.value,
      required this.groupValue,
      //required this.focusNode,
      required this.onchanged,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Radio(
                fillColor: MaterialStateColor.resolveWith(
                    (states) => AppColors.textColor2),
                value: value,
                groupValue: groupValue,
                onChanged: onchanged),
          ),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                // color: AppColors.textColor2,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}
