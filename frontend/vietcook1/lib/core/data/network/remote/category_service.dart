import 'package:dio/dio.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/local/models/category_model.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

class CategoryService {
  final Dio _dio;
  CategoryService(this._dio);

  Future<Result<List<CategoryModel>>> fetchCategories() async {
    try {
      final res = await _dio.get(ApiConstants.categories.getAll);
      final baseRp = BaseResponseDto.fromJson(res.data);
      List<CategoryModel> tags = <CategoryModel>[];
      final result = baseRp.data.forEach((element) {
        tags.add(CategoryModel.fromJson(element));
      });
      print('Response: $result');
      return Result.success(tags);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }
}
