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

class CheckBoxTile extends StatelessWidget {
  final bool value;
  // final Function(bool?)? focusNode;
  final Function(bool?) onchanged;
  final String text;
  const CheckBoxTile(
      {required this.value,
      //required this.focusNode,
      required this.onchanged,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 19),
      child: Row(
        children: [
          Checkbox(
            //focusNode: focusNode,
            value: value,
            onChanged: onchanged,
          ),
          Text(text,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17)),
        ],
      ),
    );
  }
}
