import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/cubit/states.dart';
import 'package:sallla_app/models/models_shop_app/categories_model.dart';
import 'package:sallla_app/models/models_shop_app/change_favorites_models.dart';
import 'package:sallla_app/models/models_shop_app/favorites_model.dart';
import 'package:sallla_app/models/models_shop_app/home_model.dart';
import 'package:sallla_app/models/models_shop_app/login_model.dart';
import 'package:sallla_app/modules/shop%20app/categories/categories_screen.dart';
import 'package:sallla_app/modules/shop%20app/favorites/favorites_screen.dart';
import 'package:sallla_app/modules/shop%20app/products/products_screen.dart';
import 'package:sallla_app/modules/shop%20app/settings/settings_screen.dart';
import 'package:sallla_app/shared/components/constants.dart';
import 'package:sallla_app/shared/network/end_points.dart';
import 'package:sallla_app/shared/network/remote/dio_helper.dart';
class ShopCubit extends Cubit<ShopAppStates>{
  ShopCubit():super (ShopInitState());
  static ShopCubit get (context) => BlocProvider.of(context);
  int currentIndex =0;
  List<Widget> bottomScreens=
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int,bool> favorite = {};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url: hoMe,
      token: token
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
       for (var element in homeModel!.data.products)
       {
        favorite.addAll({
          element.id! : element.inFavorites!,
        });
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      printFullText(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

   CategoriesModel? categoryModel;
  void getCategoryData()
  {
    DioHelper.getData(
        url: getCategories,
        lang: 'en',
      token: token,
    ).then((value)
    {
      categoryModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      printFullText(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

   ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorite[productId] = favorite[productId]!;
    emit(ShopChangeFavState());
    DioHelper.postData(
        url: favorites,
        data:
        {
          'product_id':productId,
        },
      token: token,
    ).then((value){
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if(!changeFavoritesModel!.status!)
      {
        favorite[productId] = !favorite[productId]!;
      }else
      {
        getFavorites();
      }
      emit(ShopSuccessChangeFavState(changeFavoritesModel!));
      favorite[productId] = !favorite[productId]!;
    }).catchError((error){
      emit(ShopErrorChangeFavState());
      print(error.toString());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavState());
    DioHelper.getData(
      url: favorites,
      lang: 'en',
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavState());
    }).catchError((error)
    {
      printFullText(error.toString());
      emit(ShopErrorGetFavState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: proFile,
      lang: 'en',
      token: token,
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: upDateUser,
      lang: 'en',
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone,
      },
    ).then((value)
    {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

}