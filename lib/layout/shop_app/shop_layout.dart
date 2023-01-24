import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/cubit/cubit.dart';
import 'package:sallla_app/layout/shop_app/cubit/states.dart';
import 'package:sallla_app/modules/shop%20app/search/search_screen.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/styles/colors.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (BuildContext context,ShopAppStates state){},
      builder: (BuildContext context,ShopAppStates state){
       var cubit =  ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon:const Icon(
                Icons.shopping_cart,
                color: defaultColor,
              ),
              onPressed: () {},
            ),
            title:  Text(
              'mercato'.toUpperCase(),
              style: const TextStyle(
                color: defaultColor,
              ),
            ),
            actions:[
              IconButton(
                  onPressed:()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search_sharp,
                    color:defaultColor,
                  )
              ),
            ],
          ),
         body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index)
            {
               cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home_filled,
                  ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                ),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
