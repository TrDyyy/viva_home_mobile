import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_button.dart';
import 'package:viva_home_mobile/widgets/custom_bottom_sheet.dart';
import 'package:viva_home_mobile/widgets/login_form.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: AppSizes.paddingXLarge(context)),
                Center(
                  child: Container(
                    width: AppSizes.padding(context, SizeCategory.xxxlarge) * 4.5, // ~216 responsive
                    height: AppSizes.padding(context, SizeCategory.xxxlarge) * 4, // ~192 responsive
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/image.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSizes.padding(context, SizeCategory.xxxlarge) * 10), // Responsive spacer
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding(context, SizeCategory.xlarge),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: AppStrings.joinButton,
                          style: CustomButtonStyle.secondary,
                          onPressed: () {
                            // Navigate to join page (later)
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Coming soon...")),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: AppSizes.paddingLarge(context)),
                      Expanded(
                        child: CustomButton(
                          text: AppStrings.loginButton,
                          style: CustomButtonStyle.primary,
                          onPressed: () {
                            CustomBottomSheet.show(
                              context: context,
                              title: AppStrings.loginTitle,
                              child: const LoginForm(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.paddingMedium(context)),
                // Terms and privacy
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.privacyPolicy,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppSizes.fontMedium(context),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.termsConditions,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: AppSizes.fontMedium(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
