import 'package:sallla_app/models/models_shop_app/change_favorites_models.dart';
import 'package:sallla_app/models/models_shop_app/login_model.dart';

abstract class ShopAppStates{}

class ShopInitState extends ShopAppStates{}

class ShopChangeBottomNavState extends ShopAppStates{}

class ShopLoadingHomeDataState extends ShopAppStates{}

class ShopSuccessHomeDataState extends ShopAppStates{}

class ShopErrorHomeDataState extends ShopAppStates {}

class ShopSuccessCategoriesState extends ShopAppStates{}

class ShopErrorCategoriesState extends ShopAppStates {}

class ShopChangeFavState extends ShopAppStates{}

class ShopSuccessChangeFavState extends ShopAppStates{
   final ChangeFavoritesModel model;

  ShopSuccessChangeFavState(this.model);
}

class ShopErrorChangeFavState extends ShopAppStates {}

class ShopGetFavState extends ShopAppStates{}

class ShopLoadingGetFavState extends ShopAppStates{}

class ShopSuccessGetFavState extends ShopAppStates{}

class ShopErrorGetFavState extends ShopAppStates {}

class ShopLoadingUserDataState extends ShopAppStates{}

class ShopSuccessUserDataState extends ShopAppStates{
  late ShopLoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopAppStates {}

class ShopLoadingUpdateUserState extends ShopAppStates{}

class ShopSuccessUpdateUserState extends ShopAppStates{
  late ShopLoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopAppStates {}

