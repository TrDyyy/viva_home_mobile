import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/validation.dart';
import '../utils/custom_text_field.dart';
import '../utils/custom_button.dart';
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
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
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
          MaterialPageRoute(builder: (context) => HomePage(username: username)),
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
              SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),

              // Email field
              CustomTextField(
                controller: _emailController,
                hintText: AppStrings.emailHint,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
              ),

              SizedBox(height: AppSizes.padding(context, SizeCategory.medium)),

              // Password field
              CustomTextField(
                controller: _passwordController,
                hintText: AppStrings.passwordHint,
                obscureText: _obscurePassword,
                validator: ValidationUtils.validatePassword,
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.done,
                maxLines: 1,
                onFieldSubmitted: (_) {
                  _handleLogin();
                },
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
                prefixIcon: null,
              ),

              SizedBox(height: AppSizes.padding(context, SizeCategory.small)),

              // Forgot password
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text(
                    AppStrings.forgotPassword,
                    style: TextStyle(
                      color: AppColors.darkGray,
                      fontSize: AppSizes.font(context, SizeCategory.small),
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppSizes.padding(context, SizeCategory.small)),

              // Connect surveyor text
              Text(
                AppStrings.connectSurveyor,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.darkTeal,
                  fontSize: AppSizes.font(context, SizeCategory.medium),
                ),
              ),

              SizedBox(height: AppSizes.padding(context, SizeCategory.large)),

              // Login button
              CustomButton(
                text: AppStrings.loginButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkTeal,
                  foregroundColor: AppColors.white,
                ),
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleLogin,
              ),

              SizedBox(height: AppSizes.padding(context, SizeCategory.large)),

              // Terms and conditions
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding(context, SizeCategory.medium),
                ),
                child: Text(
                  AppStrings.agreeToTerms,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.darkGray,
                    fontSize: AppSizes.font(context, SizeCategory.small),
                    height: 1.4,
                  ),
                ),
              ),

              SizedBox(height: AppSizes.padding(context, SizeCategory.large)),
            ],
          ),
        ),
      ),
    );
  }
}
