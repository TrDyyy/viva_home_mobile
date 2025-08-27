import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/splash_page.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        textTheme: GoogleFonts.mulishTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightGray,
          foregroundColor: AppColors.textDark,
          elevation: 0,
        ),
      ),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
