import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/validation.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../pages/home_page.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        Navigator.pop(context); // Close bottom sheet
        // Navigate to home page with username from email
        String username = _emailController.text.isNotEmpty 
            ? _emailController.text.split('@').first 
            : "User";
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(username: username),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSizes.paddingMedium),
              
              // Email field
              CustomTextField(
                controller: _emailController,
                hintText: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
              ),
              
              const SizedBox(height: AppSizes.paddingMedium),
              
              // Password field
              CustomTextField(
                controller: _passwordController,
                hintText: AppStrings.passwordHint,
                obscureText: _obscurePassword,
                validator: ValidationUtils.validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.darkGray,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              
              const SizedBox(height: AppSizes.paddingSmall),
              
              // Forgot password
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: const Text(
                    AppStrings.forgotPassword,
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: AppSizes.fontMedium,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: AppSizes.paddingSmall),
              
              // Connect surveyor text
              const Text(
                AppStrings.connectSurveyor,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.darkTeal,
                  fontSize: AppSizes.fontMedium,
                ),
              ),
              
              const SizedBox(height: AppSizes.paddingLarge),
              
              // Login button
              CustomButton(
                buttonKey: "loginpage",
                text: AppStrings.loginButton,
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleLogin,
              ),
              
              const SizedBox(height: AppSizes.paddingLarge),
              
              // Terms and conditions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
                child: Text(
                  AppStrings.agreeToTerms,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.darkGray,
                    fontSize: AppSizes.fontSmall,
                    height: 1.4,
                  ),
                ),
              ),
              
              const SizedBox(height: AppSizes.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }
}
