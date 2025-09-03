import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/pages/details/details_propeties_page.dart';
import 'pages/splash_page.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GlobalTreeManager(),
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          textTheme: GoogleFonts.mulishTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.lightGray,
            foregroundColor: AppColors.textDark,
            elevation: 0,
          ),
        ),
        home: const DetailsPage(username: "Abc"),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
