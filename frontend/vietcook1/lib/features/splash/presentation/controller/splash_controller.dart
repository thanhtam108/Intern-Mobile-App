import 'package:get/get.dart';

import 'dart:async';
// import 'package:get/get.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/routing/routes.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/features/auth/login/models/token_model.dart';

class SplashController extends GetxController {
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    _simulateLoading();
  }

  void _simulateLoading() async {
    Map<String, dynamic>? token =
        await SharedPrefsUtils.getObject(SharePrefsConstants.token);
    if (token != null) {
      isLoading.value = true; // Set loading to false when token is found
      TokenModel tokenModel = TokenModel.fromJson(token);
      Timer(const Duration(seconds: 3), () {
        isLoading.value = false; // Simulate loading done
        // Simulate loading done -> navigate
        Get.offAllNamed(Routes.main);
      });
      print('Token: ${tokenModel.accessToken}');
    } else {
      Get.offAllNamed('/onboarding'); // Navigate to onboarding if no token
    }
  }
}
