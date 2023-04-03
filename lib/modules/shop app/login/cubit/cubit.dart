// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/models/models_shop_app/login_model.dart';
import 'package:sallla_app/modules/shop%20app/login/cubit/states.dart';
import 'package:sallla_app/shared/network/end_points.dart';
import 'package:sallla_app/shared/network/remote/dio_helper.dart';
class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  late ShopLoginModel loginModel;
  static ShopLoginCubit get (context) => BlocProvider.of(context);
  ShopLoginCubit():super(ShopLoginInitialState());
  void userLogin({
  required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: loGin,
        data:
        {
          'email':email,
          'password':password,
        },
    ).then((value)
    {
      print(value.data);
     loginModel =  ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility()
  {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_off_outlined :Icons.visibility_outlined;
    emit(ShopChangePasswordVisState());
  }
}

