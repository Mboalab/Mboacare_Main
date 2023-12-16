import 'package:flutter/material.dart';
import 'package:mboacare/appStyles.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/settingsPage/theme/themeConstants.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      //final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final themeMode = themeProvider.themeMode;
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 25,
                  ),
                ),
                const Text(
                  'Back',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'App theme',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor2,
                          fontSize: 16),
                    ),
                  ),
                  const Text(
                    ' Set application theme',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor2,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'System settings',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                // color: AppColors.textColor2,
                                fontSize: 16),
                          )),
                      Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.textColor2),
                          value: ThemeMode.system,
                          groupValue: themeMode,
                          onChanged: (selectedTheme) async {
                            await themeProvider.toggleTheme(selectedTheme);
                          }),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Text(
                              'Light mode',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  // color: AppColors.textColor2,
                                  fontSize: 16),
                            )),
                        Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.textColor2),
                            focusColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.textColor2),
                            // toggleable: ,
                            value: ThemeMode.light,
                            groupValue: themeMode,
                            onChanged: (selectedTheme) async {
                              await themeProvider.toggleTheme(selectedTheme);
                              //clickedOption = value;
                            }),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Dark mode',
                            style: AppTextStyles.bodyOne.copyWith(
                                fontWeight: FontWeight.w400,
                                // color: AppColors.textColor2,
                                fontSize: 16),
                          )),
                      Radio(
                          fillColor: MaterialStateColor.resolveWith(
                              (states) => AppColors.textColor2),
                          value: ThemeMode.dark,
                          groupValue: themeMode,
                          onChanged: (selectedTheme) async {
                            await themeProvider.toggleTheme(selectedTheme);
                            //clickedOption = value;
                          }),
                    ],
                  )
                ],
              ),
            ),
          ]),
        )),
      );
    });
  }
}
