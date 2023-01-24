import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/shared/cubit/states.dart';
import 'package:sallla_app/shared/network/local/cache_helper.dart';
class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppInitialState());
  static AppCubit get (context) => BlocProvider.of(context);

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetSate({
    required bool isShow,
    required IconData icon,
}){
    isBottomSheetShown = isShow;
    fabIcon = icon;
   emit(AppChangeBottomSheetSate());
  }

  bool isDark=false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark =fromShared;
      emit(AppChangeModeSate());


    }else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key:'isDark', value:isDark).then((value)
      {
        emit(AppChangeModeSate());
      });
    }
  }
}


