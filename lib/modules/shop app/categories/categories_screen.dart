import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/cubit/cubit.dart';
import 'package:sallla_app/layout/shop_app/cubit/states.dart';
import 'package:sallla_app/models/models_shop_app/categories_model.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(
              ShopCubit.get(context).categoryModel!.data!.data[index]),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: ShopCubit.get(context).categoryModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              model.name!.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: defaultColor,
                fontSize: 20.0,
              ),
            ),
            const Spacer(),
            const Icon(
                Icons.arrow_forward_ios,
              color: defaultColor,
            )
          ],
        ),
      );
}
