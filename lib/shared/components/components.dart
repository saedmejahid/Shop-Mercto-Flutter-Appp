import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sallla_app/layout/shop_app/cubit/cubit.dart';
import 'package:sallla_app/shared/styles/colors.dart';
Widget defaulButton({
  double width = double.infinity,
  Color backround = defaultColor,
  double radius = 10.0,
  double heghit = 50.0,
  bool isUpperCase = true,
  required String text,
   Function? pressed,
}) =>
    Container(
      height: heghit,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backround,
      ),
      child: MaterialButton(
        onPressed: () {
          pressed!();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text.toLowerCase(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaulTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: function(),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Colors.blue,
        ),
      ),
    );

Widget defaultForm({
  required TextEditingController controller,
  required TextInputType type,
  required String lapel,
  required IconData prefix,
  required Function validate,
  required Function onTap,
  required Function onChange,
  Function? onSup,
  IconData? suffix,
  Function? suffixPressed,
  bool isPassword = false,
  bool isCalickable = true,
  double radius = 10.0,
}) =>
    TextFormField(
      validator: (value) => validate(value),
      enabled: isCalickable,
      onChanged: onChange(),
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: () => onTap(),
      onFieldSubmitted: (value) => onSup!(value),
      decoration: InputDecoration(
        labelText: lapel,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: () => suffixPressed!(),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );

Widget tasksBuilder({
  required List<Map> tasks,
}) {
  return ConditionalBuilder(
    condition: tasks.isNotEmpty,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
      separatorBuilder: (context, index) {
        return myDivider();
      },
      itemCount: tasks.length,
    ),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.menu,
            color: Colors.grey,
            size: 80,
          ),
          Text(
            'No Tasks Yet Please Add A New Tasks',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 0.5 ,
      color: defaultColor,
    );

Widget buildArticleItem(articles, context) => InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            SizedBox(
              width: 120.0,
              height: 120.0,
              child: CachedNetworkImage(
                imageUrl: "${articles['urlToImage']}",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) => const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
                errorWidget: (context, url, error) => const Image(
                  image: AssetImage(
                    'assets/images/occupation.png',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        '${articles['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${articles['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return buildArticleItem(list[index], context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return myDivider();
        },
        itemCount: 10,
      ),
      fallback: (context) => isSearch
          ? const Text(
              'Search',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: defaultColor,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );

Widget buildListProduct(model ,context, {bool isOldPrice = true}
    ) => Padding(
  padding: const EdgeInsets.all(30.0),
  child: SizedBox(
    height: 120,
    child: Row(
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                    model.image!
                ),
                width: 120.0,
                height: 120.0,
              ),
              if (model.discount != 0 && isOldPrice)
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
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.3),
                ),
                const Spacer(),
                Row(children: [
                  Text(
                    model.price!.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
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
        ]),
  ),
);

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinsh(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) {
      return false;
    },
  );
}

void showToast({
required String text,
  required ToastStates state,
}) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor:chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0);

enum ToastStates {success,errorr,warning}
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch (state)
  {
    case ToastStates.success:
      color = defaultColor;
      break;
    case ToastStates.errorr:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = defaultColor
      ;
      break;
  }
  return color;
}


