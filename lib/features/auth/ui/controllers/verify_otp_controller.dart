import 'package:get/get.dart';
import '../../../../app/app_urls.dart';
import '../../../../core/network_caller/network_caller.dart';
import '../../data/models/verify_otp_model.dart';

class VerifyOtpController extends GetxController {
  bool _inProgress = false;

  bool get verifyOtpInProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(VerifyOtpModel verifyOtpModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await Get.find<NetworkCaller>().postRequest(
      url: AppUrls.verifyOtpUrl,
      body: verifyOtpModel.toJson(),
    );
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
