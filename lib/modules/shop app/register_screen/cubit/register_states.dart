import 'package:sallla_app/models/models_shop_app/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates
{
  late ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  late String error;
  ShopRegisterErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopRegisterStates{}


