import 'dart:async';
import 'package:crafty_bay/features/auth/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/widgets/show_snack_bar_message.dart';
import '../../data/models/verify_otp_model.dart';
import '../controllers/verify_otp_controller.dart';
import '../widgets/app_logo.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  final String email;

  static const String name = '/verify-otp-screen';

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final VerifyOtpController _verifyOtpController =
  Get.find<VerifyOtpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late RxInt _currentTime;

  void _startTimer() {
    _currentTime.value = 30;
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (_currentTime.value == 0) {
        timer.cancel();
      } else {
        _currentTime.value = _currentTime.value - 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),
                const AppLogo(),
                const SizedBox(height: 24),
                Text(
                 'Enter Your Otp Code',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'A Four Digit Code Has Been Sent',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 16),
                PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  controller: _otpTEController,
                  appContext: context,
                  validator: (String? value) {
                    if ((value?.length ?? 0) < 4) {
                      return 'Enter your otp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onTapVerifyOtpButton,
                  child: Text('Verify'),
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return Column(
                    children: [
                      Visibility(
                        visible: _currentTime.value == 0,
                        child: TextButton(
                          onPressed: () {
                            // RESEND OTP
                            _startTimer();
                          },
                          child: const Text('Resend Otp'),
                        ),
                      ),
                      Visibility(
                        visible: _currentTime.value != 0,
                        child: TextButton(
                          onPressed: () {},
                          child: Text('Resend Otp in ${_currentTime.value}'),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapVerifyOtpButton() {
    if (_formKey.currentState!.validate()) {
      _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    VerifyOtpModel verifyOtpModel = VerifyOtpModel(
      email: widget.email,
      otp: _otpTEController.text,
    );
    final bool isSuccess = await _verifyOtpController.verifyOtp(verifyOtpModel);
    if (isSuccess) {
      showSnackBarMessage(context, 'Otp has been verified! Please login');
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, _verifyOtpController.errorMessage!, true);
    }
  }
}