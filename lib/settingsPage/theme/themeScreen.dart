import 'package:flutter/material.dart';
import 'package:mboacare/colors.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  int? clickedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        value: 0,
                        groupValue: clickedOption,
                        onChanged: (value) {
                          setState(() {
                            clickedOption = value;
                          });
                        }),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          value: 1,
                          groupValue: clickedOption,
                          onChanged: (value) {
                            setState(() {
                              clickedOption = value;
                            });
                          }),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Text(
                          'Dark mode',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              // color: AppColors.textColor2,
                              fontSize: 16),
                        )),
                    Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.textColor2),
                        value: 2,
                        groupValue: clickedOption,
                        onChanged: (value) {
                          setState(() {
                            clickedOption = value;
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
