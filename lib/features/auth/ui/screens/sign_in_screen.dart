import 'package:crafty_bay/features/auth/ui/screens/sign_up_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/app_color.dart';
import '../../../../core/widgets/cenetred_circular_progress_indicator.dart';
import '../../../../core/widgets/show_snack_bar_message.dart';
import '../../../common/ui/screens/main_bottom_nav_bar_screen.dart';
import '../../data/models/sign_in_request_model.dart';
import '../controllers/sign_in_controller.dart';
import '../widgets/app_logo.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final SignInController _signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const AppLogo(),
              const SizedBox(height: 24),
              Text(
                'Welcome Back',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Enter Your Email And Password',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailTEController,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                  String email = value ?? '';
                  if (!EmailValidator.validate(email)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordTEController,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (String? value) {
                  if ((value?.isEmpty ?? true) || value!.length < 6) {
                    return 'Enter a password more than 6 letters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GetBuilder<SignInController>(builder: (controller) {
                return Visibility(
                  visible: controller.inProgress == false,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapSignInButton,
                    child: Text('Sign In'),
                  ),
                );
              }),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                  children: [
                    TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _onTapSignUpButton),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignInButton() async {
    SignInRequestModel signInRequestModel = SignInRequestModel(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );
    final bool isSuccess = await _signInController.signIn(signInRequestModel);
    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainBottomNavBarScreen.name, (value) => false);
    } else {
      showSnackBarMessage(context, _signInController.errorMessage!, true);
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
