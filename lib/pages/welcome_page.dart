import 'package:flutter/material.dart';
import 'package:viva_home_mobile/utils/constants.dart';
import 'package:viva_home_mobile/widgets/custom_button.dart';
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSizes.paddingXLarge),
              Center(
                child: Container(
                  width: 220,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/image.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 500),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonKey: "welcomepage",
                        height: 60,
                        text: AppStrings.joinButton,
                        onPressed: () {
                          // Navigate to join page (later)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Coming soon..."),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingLarge),
                    Expanded(
                      child: CustomButton(
                        buttonKey: "welcomepage",
                        height: 60,
                        text: AppStrings.loginButton,
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
              const SizedBox(height: AppSizes.paddingMedium),
              // Terms and privacy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      AppStrings.privacyPolicy,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSizes.fontMedium,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      AppStrings.termsConditions,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppSizes.fontMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
