import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/utils/api_helper/dio_helper.dart';
import 'package:movie/features/home/domain/use_case/search_uc.dart';
import 'package:movie/features/home/presentation/manager/search_manager/search_event.dart';
import 'package:movie/features/home/presentation/manager/search_manager/search_state.dart';

class SearchBloc extends Bloc<SearchEventBase, SearchState> {
  final SearchUseCase searchUseCase;
  SearchBloc({required this.searchUseCase}) : super(SearchInitialState()) {
    on<SearchEvent>((event, emit) async {
      emit(SearchLoadingState());
      final result = await searchUseCase.call(event.query);
      result.fold(
              (l) => emit(SearchSuccessState(allMoviesModel: l)),
              (r) => emit(SearchErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
