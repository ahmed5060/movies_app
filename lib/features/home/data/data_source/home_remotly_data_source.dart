import 'package:dio/dio.dart';
import 'package:movie/core/utils/api_helper/constant_api.dart';
import 'package:movie/core/utils/api_helper/dio_helper.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';

abstract class HomeBaseRemotelyDataSource {
  Future<AllMoviesModel> getAllMovies({required String page});
  Future<AllMoviesModel> search({required String query});
}

class HomeRemotelyDataSource extends HomeBaseRemotelyDataSource {

  @override
  Future<AllMoviesModel> getAllMovies({required String page}) async {
    Map<String, String> headers = await DioHelper().header(endPoint: "getAllMovies");

    try {
      final response = await Dio().get(
        ConstantApi().getAllMovies(page),
        options: Options(
          headers: headers,
        ),
      );

      return AllMoviesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: 'getAllMovies');
    }
  }

  @override
  Future<AllMoviesModel> search({required String query}) async {
    Map<String, String> headers = await DioHelper().header(endPoint: "search");

    try {
      final response = await Dio().get(
        ConstantApi().search(query),
        options: Options(
          headers: headers,
        ),
      );

      return AllMoviesModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioHelper.handleDioError(dioError: e, endpointName: 'search');
    }
  }

}
