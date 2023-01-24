import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/cubit/cubit.dart';
import 'package:sallla_app/layout/shop_app/cubit/states.dart';
import 'package:sallla_app/models/models_shop_app/categories_model.dart';
import 'package:sallla_app/models/models_shop_app/home_model.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavState)
        {
          if(state.model.status == true)
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
          // ignore: unnecessary_null_comparison
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel != null,
          builder: (context) => productsBuilder(
             ShopCubit.get(context).homeModel!,
            ShopCubit.get(context).categoryModel!,
            context,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel categoryModel,context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: model.data.banners
                      .map(
                        (e) => Image(
                          image: NetworkImage(
                            '${e.image}',
                          ),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 250,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(milliseconds: 400),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: defaultColor,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 100.0,
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index) => buildCategoryItem(categoryModel.data!.data[index]),
                          separatorBuilder: (context,index)=>const SizedBox(width: 8.0,),
                          itemCount: categoryModel.data!.data.length,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text(
                      'New Products',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: defaultColor,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.6,
                    children: List.generate(
                      model.data.products.length,
                      (index) => buildGridProduct(model.data.products[index],context),
                    )),
              ),
            ],
          ),
        ),
      );
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage(
          model.image!,
        ),
        height: 120.0,
        width: 120.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.7),
        width: 120.0,
        child:  Text(
          model.name!.toUpperCase(),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
  Widget buildGridProduct(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.imAge!,
                  ),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.disCount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'Discount',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.naMe!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  Row(
                      children:
                      [
                    Text(
                      '${model.prIce.round()}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    if (model.disCount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                        IconButton(
                        onPressed: ()
                        {
                          ShopCubit.get(context).changeFavorites(model.id!);
                        },
                        icon:  CircleAvatar(
                          radius: 15,
                          backgroundColor:ShopCubit.get(context).favorite[model.id]! ? defaultColor: Colors.grey,
                          child: const Icon(
                            Icons.favorite,
                            size: 15.0,
                            color: Colors.white,
                          ),
                        )),
                  ]),
                ],
              ),
            ),
          ],
        ),
      );
}