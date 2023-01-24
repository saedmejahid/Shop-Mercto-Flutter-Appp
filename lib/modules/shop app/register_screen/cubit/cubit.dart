import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/models/models_shop_app/login_model.dart';
import 'package:sallla_app/modules/shop%20app/register_screen/cubit/register_states.dart';
import 'package:sallla_app/shared/network/end_points.dart';
import 'package:sallla_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  late ShopLoginModel loginModel;
  static ShopRegisterCubit get (context) => BlocProvider.of(context);
  ShopRegisterCubit():super(ShopRegisterInitialState());
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: register,
      data:
      {
        'email':email,
        'password':password,
        'name':name,
        'phone':phone,
      },
    ).then((value)
    {
      print(value.data);
      loginModel =  ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changePasswordVisibility()
  {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_off_outlined :Icons.visibility_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}