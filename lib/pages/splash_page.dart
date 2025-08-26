import 'package:flutter/material.dart';
import 'package:viva_home_mobile/pages/welcome_page.dart';
import '../utils/constants.dart';
import '../widgets/base_logo_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseLogoPage(
      heroTag: 'app_logo',
      isScrollable: false,
      logoWidth: AppSizes.padding(context, SizeCategory.xxxlarge) * 4,
      logoHeight: AppSizes.padding(context, SizeCategory.xxxlarge) * 2.5,
      child: Column(
        children: [
          SizedBox(height: AppSizes.paddingXLarge(context)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
          ),
        ],
      ),
    );
  }
}
