import 'package:get/get.dart';
import '../../../app/app_urls.dart';
import '../../../core/network_caller/network_caller.dart';
import '../../common/date/models/product_model.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  late ProductModel _productModel;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  ProductModel get product => _productModel;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: AppUrls.productDetailsUrl(productId),
    );
    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.responseData!['data']);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}