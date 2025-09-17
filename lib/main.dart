import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:viva_home_mobile/cubits/checkbox_tree_cubit.dart';
import 'package:viva_home_mobile/models/tree_config.dart';
import 'package:viva_home_mobile/pages/home_page.dart';
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
      create: (context) {
        final manager = GlobalTreeManager();
        manager.initializeNodes(CheckboxTreesConfig.allTrees);
        return manager;
      },
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          textTheme: GoogleFonts.mulishTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.darkTeal,
            elevation: 0,
          ),
        ),
        home: const HomePage(username: "ABC"),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

