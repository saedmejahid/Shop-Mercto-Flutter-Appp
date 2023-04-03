import 'package:flutter/material.dart';
import 'package:sallla_app/modules/shop%20app/login/shop_login_screen.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/network/local/cache_helper.dart';
import 'package:sallla_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoradingModel
{
  final String image;
  final String title;
  final String body;
  BoradingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget
{
  const OnBoardingScreen({Key? key}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
  var bordController = PageController();
  void supMit()
  {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value)
      {
        navigateAndFinsh(context, const ShopLoginScreen());
      }
    });
  }

  List<BoradingModel> borading =
  [
    BoradingModel(
      image: 'assets/images/cart_1.jpeg',
      title: 'Mercato Shop Hot Offers',
      body: 'Discounts of up to 20% in Black Friday Deals',
    ),
    BoradingModel(
      image: 'assets/images/cart_2.jpeg',
      title: 'Mercato Shop ',
      body: 'With the bank payment service discounts of up to 5% Buy Now',
    ),
    BoradingModel(
      image: 'assets/images/cart_3.jpeg',
      title: 'Mercato Shop',
      body: 'Fast delivery service within 48 hours',
    ),
  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
            onPressed: supMit,
            child: const Text(
              'Skip',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == borading.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: bordController,
                itemBuilder: (context, index) => buildBorading(borading[index]),
                itemCount: borading.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: bordController,
                  count: borading.length,
                  onDotClicked: (index) {},
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotWidth: 15,
                    dotHeight: 15,
                    expansionFactor: 3,
                    spacing: 7,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: defaultColor,
                  onPressed: ()
                  {
                    if (isLast)
                    {
                      supMit();
                    } else
                    {
                      bordController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBorading(BoradingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image,
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
        ],
      );
}
