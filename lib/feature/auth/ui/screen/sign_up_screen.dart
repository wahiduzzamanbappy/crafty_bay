import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/feature/auth/ui/widgets/app_logo.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildForm(textTheme),
        ),
      ),
    );
  }

  Widget _buildForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 60),
          AppLogo(),
          const SizedBox(height: 16),
          Text('Complete Profile', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Get Started with us with your details',
              style: textTheme.titleMedium),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailTEController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _firstNameTEController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'First Name',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _lastNameTEController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Last Name',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileTEController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Mobile',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordTEController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingAddressTEController,
            decoration: InputDecoration(
              labelText: 'Shipping Address',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('Complete'),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
                text: 'Already have an account! ',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                    text: 'Sign In',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.themeColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = _onTapSignUpButton,
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void _onTapSignUpButton() {
    Navigator.pop(context);
  }
}
