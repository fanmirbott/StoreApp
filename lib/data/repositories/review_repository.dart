
import '../../core/client.dart';
import '../../core/utils/result.dart';
import '../models/review_model.dart';

class ReviewRepository {
  final ApiClient _apiClient;

  ReviewRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Result<List<ReviewModel>>> fetchReviews({required int productId}) async {
    final result = await _apiClient.get('/reviews/list/$productId');
    return result.fold(
          (error) => Result.error(Exception(error.toString())),
          (data) {
        final list = data as List;
        final reviews = list
            .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.ok(reviews);
      },
    );
  }
  Future<Result<List<ReviewModel>>> addReview({
    required int productId,
    required String comment,
    required double rating,
  }) async {
    final result = await _apiClient.post(
      '/reviews/add',
      data: {
        'productId': productId,
        'comment': comment,
        'rating': rating,
      },
    );

    return result.fold(
          (error) => Result.error(Exception(error.toString())),
          (data) {
        final list = data as List;
        final reviews = list
            .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return Result.ok(reviews);
      },
    );
  }
}
