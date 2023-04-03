// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/models/models_shop_app/search_model.dart';
import 'package:sallla_app/modules/shop%20app/search/cubit/states.dart';
import 'package:sallla_app/shared/components/constants.dart';
import 'package:sallla_app/shared/network/end_points.dart';
import 'package:sallla_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() :super (SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model ;
  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: seaRch,
        token: token,
        data:
        {
          'text':text,
        }
    ).then((value)
    {
      model = SearchModel.fromJson(value.data);
     emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }




}