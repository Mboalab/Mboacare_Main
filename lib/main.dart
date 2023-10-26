import 'package:flutter/material.dart';
import 'package:mboacare/settingsPage/aboutUs/aboutUs.dart';
import 'package:mboacare/settingsPage/settings.dart';
import 'package:mboacare/settingsPage/theme/themeConstants.dart';
import 'package:mboacare/settingsPage/theme/themeScreen.dart';
import 'package:mboacare/colors.dart';
import 'package:mboacare/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mboacare/user_provider.dart';
import 'package:mboacare/view_model/signup_view_model.dart';
import 'package:provider/provider.dart';
import 'hospital_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'user_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HospitalProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ChangeNotifierProvider(create: (_) => SignUpProvider()),
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      // Add other providers here if needed.
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //builder: (context, child) =>
    return Consumer<ThemeProvider>(
        builder: (BuildContext context, themeProvider, child) {
      final themeMode = themeProvider.themeMode;

      return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          //notifier.darkTheme ? themeLight : themeDark,
          //     ThemeData(
          //   colorScheme:
          //       ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          //   useMaterial3: true,
          // ),
          // Add supported locales and localizations delegates
          supportedLocales: const [
            Locale('en', 'US'), // English
            Locale('hi', 'IN'), // Hindi
            Locale('es', 'ES'), // Spanish
            Locale('fr', 'FR'), // French
            // Add more locales here for other languages
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          home: const SplashScreen(),
          routes: {
            '/themeScreen': (context) => ThemeScreen(),
            //'/deleteDialog': (context) => DeleteAccountDialog(),
            '/profilePage': (context) => ProfilePage(),
            '/aboutUs': (context) => AboutUs(),
            // '/signoutDialog': (context) => SignoutDialog(),
            // '/languageDialog': (context) => LanguageDialog(),
          });
    });
  }
}
