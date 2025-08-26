import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/validation.dart';
import '../utils/custom_text_field.dart';
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
  final _passwordFocusNode = FocusNode();

  // Common widgets
  Widget get _mediumSpacing => const SizedBox(height: AppSizes.paddingMedium);
  Widget get _largeSpacing => const SizedBox(height: AppSizes.paddingLarge);
  Widget get _smallSpacing => const SizedBox(height: AppSizes.paddingSmall);

  TextStyle get _grayTextStyle => const TextStyle(
    color: AppColors.darkGray,
    fontSize: AppSizes.fontMedium,
  );

  TextStyle get _smallGrayTextStyle => const TextStyle(
    color: AppColors.darkGray,
    fontSize: AppSizes.fontSmall,
    height: 1.4,
  );

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
              _mediumSpacing,

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

              _mediumSpacing,

              // Password field
              CustomTextField(
                controller: _passwordController,
                hintText: AppStrings.passwordHint,
                obscureText: _obscurePassword,
                validator: ValidationUtils.validatePassword,
                focusNode: _passwordFocusNode,
                textInputAction: TextInputAction.done,
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

              _smallSpacing,

              // Forgot password
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text(
                    AppStrings.forgotPassword,
                    style: _grayTextStyle,
                  ),
                ),
              ),

              _smallSpacing,

              // Connect surveyor text
              Text(
                AppStrings.connectSurveyor,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.darkTeal,
                  fontSize: AppSizes.fontMedium,
                ),
              ),

              _largeSpacing,

              // Login button
              CustomButton(
                buttonKey: "loginpage",
                text: AppStrings.loginButton,
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleLogin,
              ),

              _largeSpacing,

              // Terms and conditions
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                ),
                child: Text(
                  AppStrings.agreeToTerms,
                  textAlign: TextAlign.center,
                  style: _smallGrayTextStyle,
                ),
              ),

              _largeSpacing,
            ],
          ),
        ),
      ),
    );
  }
}
