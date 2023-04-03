// ignore_for_file: avoid_print

import 'package:sallla_app/modules/shop%20app/login/shop_login_screen.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/network/local/cache_helper.dart';
void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    if(value)
    {
      navigateAndFinsh(context, const ShopLoginScreen());
    }
  }).catchError((error)
  {
    print(error.toString());
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

dynamic token = '';