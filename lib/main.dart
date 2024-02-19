import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mboacare/app_modules/auth/forgotPassword.dart';
import 'package:mboacare/app_modules/auth/auth_messages/checkMail.dart';
import 'package:mboacare/app_modules/med_user/med_dashboard.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/home.dart';

import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/edit_facilities_page.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/hospital/manageFacilities.dart';
import 'package:mboacare/app_modules/med_user/screen/dashboard/profile/user_profile_page.dart';
import 'package:mboacare/app_modules/notifications/delete_notification_provider.dart';
import 'package:mboacare/app_modules/user/screens/inner_screen/aboutUs.dart';
import 'package:mboacare/app_modules/user/user_dashboard.dart';
import 'package:mboacare/global/theme/themeConstants.dart';
import 'package:mboacare/global/theme/themeScreen.dart';
import 'package:mboacare/services/auth_provider/chagePasswordProvider.dart';
import 'package:mboacare/services/auth_provider/update_profileProvider.dart';
import 'package:mboacare/services/blog_provider/delete_blogProvider.dart';
import 'package:mboacare/services/databaseProvider.dart';
import 'package:mboacare/services/auth_provider/forgotPasswordProvider.dart';
import 'package:mboacare/services/auth_provider/loginProvider.dart';
import 'package:mboacare/services/hospital_provider/delete_hospitalProvider.dart';
import 'package:mboacare/services/hospital_provider/edit_hospitalProvider.dart';
import 'package:mboacare/services/map_services/locationProvider.dart';
import 'package:mboacare/services/auth_provider/registerProvider.dart';
import 'package:mboacare/app_modules/splashscreen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mboacare/services/auth_provider/user_provider.dart';
import 'package:mboacare/services/map_services/map_provider.dart';
import 'package:provider/provider.dart';
import 'services/blog_provider/add_blogProvider.dart';
import 'services/hospital_provider/add_hospital_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'global/l10n/app_localizations.dart';
import 'services/blog_provider/edit_blogProvider.dart';
import 'services/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      //ChangeNotifierProvider(create: (_) => HospitalProvider()),
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ChangeNotifierProvider(create: (_) => EditBlogProvider()),
      ChangeNotifierProvider(create: (_) => UpdateProfileProvider()),
      ChangeNotifierProvider(create: (_) => DeleteBlogProvider()),
      //ChangeNotifierProvider(create: (_) => SignUpProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => AddBlogProvider()),
      ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ChangeNotifierProvider(create: (_) => AddHospitalProvider()),
      // ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ChangeNotifierProvider(create: (_) => DeleteNotificationProvider()),
      ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
      ChangeNotifierProvider(create: (_) => DeleteHospitalProvider()),
      ChangeNotifierProvider(create: (_) => EditHospitalProvider()),
      // Add other providers here if needed.
      //ChangeNotifierProvider(create: (_) => MapProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Mboacare',
        debugShowCheckedModeBanner: false,
        // themeMode: Provider.of<ThemeProvider>(context).themeMode,
        theme: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
            ? ThemeData.dark().copyWith(
                // colorScheme: ,
                scaffoldBackgroundColor: DarkThemeColors.background,
                cardColor: DarkThemeColors.cardBackground,
                primaryColor: DarkThemeColors.primaryText,
                //accentColor: DarkThemeColors.accentColor,
                //buttonColor: DarkThemeColors.buttonBackground,
                textTheme: const TextTheme(
                  headlineSmall: TextStyle(
                    color: DarkThemeColors.primaryText,
                  ),
                  bodyMedium: TextStyle(
                    color: DarkThemeColors.secondaryText,
                  ),
                ),
              )
            : ThemeData.light(),
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
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
          ('/home'): (context) => Home(),
          ('/aboutUs'): (context) => AboutUs(),
          ('/themeScreen'): (context) => ThemeScreen(),
          ('/profilePage'): (context) => ProfilePage(),
          ('/resetPassword'): (context) => CheckMailScreen(),
          ('/forgotPassword'): (context) => ForgotPasswordScreen(),
          ('/editFacilities'): (context) => EditFacilitiesPage(),
          ('/manageFacilities'): (context) => ManageFacilities(),
        });
  }
}
