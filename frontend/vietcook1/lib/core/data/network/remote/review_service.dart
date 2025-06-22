import 'package:dio/dio.dart';
import 'package:vietcook1/core/configs/api_constants.dart';
import 'package:vietcook1/core/data/local/models/review_model.dart';
import 'package:vietcook1/core/data/network/exceptions/app_exception.dart';
import 'package:vietcook1/core/data/network/model/base_response_dto.dart';
import 'package:vietcook1/core/data/network/model/result_dto.dart';

class ReviewService {
  final Dio _dio;
  ReviewService(this._dio);

  Future<Result<List<ReviewModel>>> fetchReviewsByRecipeId(
      String recipeId) async {
    try {
      final res = await _dio.get('${ApiConstants.reviews.common}/$recipeId');
      final baseRp = BaseResponseDto.fromJson(res.data);

      List<ReviewModel> reviews = <ReviewModel>[];
      baseRp.data.forEach((element) {
        reviews.add(ReviewModel.fromJson(element));
      });
      return Result.success(reviews);
    } on DioException catch (e) {
      return Result.error(AppException.parse(e));
    }
  }
}
