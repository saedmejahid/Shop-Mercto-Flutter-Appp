import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/bloc_observer.dart';
import 'package:sallla_app/layout/shop_app/cubit/cubit.dart';
import 'package:sallla_app/layout/shop_app/shop_layout.dart';
import 'package:sallla_app/modules/shop%20app/login/shop_login_screen.dart';
import 'package:sallla_app/modules/shop%20app/on_boarding/on_boarding_screen.dart';
import 'package:sallla_app/shared/components/constants.dart';
import 'package:sallla_app/shared/cubit/cubit.dart';
import 'package:sallla_app/shared/cubit/states.dart';
import 'package:sallla_app/shared/network/local/cache_helper.dart';
import 'package:sallla_app/shared/network/remote/dio_helper.dart';
import 'package:sallla_app/shared/styles/themes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token  = CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null)
  {
    if (token != null)
    {
      widget = const ShopLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key, this.isDark, this.startWidget});
  bool? isDark;
  Widget? startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoryData()
              ..getFavorites()
              ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
