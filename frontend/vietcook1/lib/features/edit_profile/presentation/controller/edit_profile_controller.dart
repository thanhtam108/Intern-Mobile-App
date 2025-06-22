import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vietcook1/core/configs/app_colors.dart';
import 'package:vietcook1/core/configs/share_prefs_constants.dart';
import 'package:vietcook1/core/data/local/models/recipe_model.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';
import 'package:vietcook1/core/data/network/remote/user_service.dart';
import 'package:vietcook1/core/utils/shared_preferences%20_utils.dart';
import 'package:vietcook1/core/utils/upload_image_utils.dart';
import 'package:vietcook1/features/main/models/user_model.dart';

class EditProfileController extends GetxController {
  final UserService _userService;
  EditProfileController(this._userService);

  final RxList<RecipeModel> userRecipes = RxList<RecipeModel>();
  final isLoading = false.obs;

  UserModel user = UserModel();
  final Rxn<XFile>? imageFile = Rxn<XFile>();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() async {
    final result = await _userService.getUser();
    if (result.status == Status.success) {
      user = result.data!;
      await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user, user.toJson());
      update(['tochanged_info']);
    } else {
      Get.snackbar(
        'Error',
        'Failed to fetch user data',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> pickImage({required BuildContext context}) async {
    // final picked = await picker.pickImage(source: ImageSource.gallery);
    // if (picked != null) {
    //   imageFile.value = File(picked.path);
    // }
    final picked = await UpLoadImageUtil.pickImages(context: context);
    if (picked != null) {
      imageFile!.value = picked.first;
    }
  }

  Future<void> updateUser({
    required String name,
    required String bio,
    required String email,
  }) async {
    isLoading.value = true;
    try {
      final currentUser = user;

      String finalName =
          name.trim().isNotEmpty ? name.trim() : currentUser.name ?? '';
      String finalBio =
          bio.trim().isNotEmpty ? bio.trim() : currentUser.bio ?? '';
      String finalEmail =
          email.trim().isNotEmpty ? email.trim() : currentUser.email ?? '';
      String finalAvatarUrl = currentUser.avatarUrl ?? '';

      // Nếu có upload avatar mới thì upload lên cloud và lấy url
      if (imageFile != null && imageFile!.value != null) {
        final urls = await UpLoadImageUtil.uploadImagesToCloudinary(
          fileName: 'avatars/${DateTime.now().millisecondsSinceEpoch}',
          pickedFiles: [imageFile!.value!],
          uploadPreset: 'upload',
        );
        if (urls.isNotEmpty) {
          finalAvatarUrl = urls.first;
        }
      }

      // Tạo model mới
      final updatedUser = UserModel(
        id: currentUser.id,
        name: finalName,
        bio: finalBio,
        email: finalEmail,
        avatarUrl: finalAvatarUrl,
      );

      // Gửi lên backend
      final result = await _userService.updateUser(
        id: updatedUser.id,
        name: updatedUser.name,
        bio: updatedUser.bio,
        email: updatedUser.email,
        avatarUrl: updatedUser.avatarUrl,
      );

      if (result.status == Status.success) {
        user = updatedUser;
        await SharedPrefsUtils.saveObject(
          SharePrefsConstants.user,
          user.toJson(),
        );
        update(['profile_info']);
        Get.snackbar(
          'Thành công',
          'Cập nhật thông tin thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
      } else {
        Get.snackbar(
          'Lỗi',
          result.data?.id ?? 'Cập nhật thất bại',
          backgroundColor: AppColors.error,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
