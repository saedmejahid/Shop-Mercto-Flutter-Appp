import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/cubit/cubit.dart';
import 'package:sallla_app/layout/shop_app/cubit/states.dart';
import 'package:sallla_app/shared/components/components.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavState)
        {
          if(state.model.status!)
          {
            showToast(
                text: state.model.message!,
                state: ToastStates.success
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavState,
          builder: (BuildContext context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
                ShopCubit.get(context).favoritesModel!.data!.data![index].product!,context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}