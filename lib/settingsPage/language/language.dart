import 'package:flutter/material.dart';
import 'package:mboacare/l10n/app_localizations.dart';
import 'package:mboacare/locale_provider.dart';
import 'package:provider/provider.dart';

class Language extends StatefulWidget {
  final BuildContext context;

  const Language({super.key, required this.context});
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String _selectedLanguage = 'en'; // Default language is English (en)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        // Wrap the entire Column with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Language:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedLanguage,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                  // Change the app's language based on the selected value
                  _changeLanguage(context, Locale(_selectedLanguage));
                },
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        Image.asset(
                          'lib/assests/images/america.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text('English'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'hi',
                    child: Row(
                      children: [
                        Image.asset(
                          'lib/assests/images/india.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text('हिन्दी'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'es',
                    child: Row(
                      children: [
                        Image.asset(
                          'lib/assests/images/spain.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text('Español'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'fr',
                    child: Row(
                      children: [
                        Image.asset(
                          'lib/assests/images/france.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text('Français'),
                      ],
                    ),
                  ),
                  // Add more language options here if needed
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to change the app's language
  // Function to change the app's language
  void _changeLanguage(BuildContext context, Locale locale) {
    print("Changing language to: ${locale.languageCode}");

    setState(() {
      Provider.of<LocaleProvider>(context, listen: false).locale = locale;
    });

    // Show a SnackBar to indicate the language change (optional)
    AppLocalizations localizations = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localizations.settingsPageTitle),
      ),
    );

    // You may want to navigate back to the previous screen or the home screen after changing the language
    // Navigator.pop(context);
    // or
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
