import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/utils/custom_button.dart';
import 'package:viva_home_mobile/widgets/custom_bottom_sheet.dart';
import 'package:viva_home_mobile/widgets/login_form.dart';
import 'package:viva_home_mobile/widgets/base_logo_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseLogoPage(
      heroTag: 'app_logo',
      logoWidth: AppSizes.padding(context, SizeCategory.xxxlarge) * 4.5,
      logoHeight: AppSizes.padding(context, SizeCategory.xxxlarge) * 4,
      child: Column(
        children: [
          SizedBox(height: AppSizes.padding(context, SizeCategory.xxxlarge) * 10),
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
    );
  }
}