import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/shop_layout.dart';
import 'package:sallla_app/modules/shop%20app/register_screen/cubit/cubit.dart';
import 'package:sallla_app/modules/shop%20app/register_screen/cubit/register_states.dart';
import 'package:sallla_app/modules/shop%20app/settings/settings_screen.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/components/constants.dart';
import 'package:sallla_app/shared/network/local/cache_helper.dart';
import 'package:sallla_app/shared/styles/colors.dart';
class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var registerNameShopController = TextEditingController();
  var registerEmailShopController = TextEditingController();
  var registerPasswordShopController = TextEditingController();
  var registerPhoneShopController = TextEditingController();
  ShopRegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is ShopRegisterSuccessState)
          {
            if (state.loginModel.status!)
            {
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token.toString()
              ).then((value)
              {
                token = state.loginModel.data!.token!;
                navigateAndFinsh(context,const ShopLayout());
              }).catchError((error)
              {
                print(error.toString());
              });
              showToast(state: ToastStates.success, text: state.loginModel.message!);
            } else
            {
              showToast(
                state: ToastStates.errorr,
                text: state.loginModel.message!,
              );
            }
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
          appBar: AppBar(
            actions:  [
              IconButton(
                color: defaultColor,
                onPressed: () {

                },
                icon: const Icon(
                    Icons.app_registration_outlined
                ),
              ),
            ],
            title:  Text(
              'Register'.toUpperCase(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: defaultColor
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child:  Image(
                          image:AssetImage(
                            'assets/images/accountlogo.jpeg',
                          ),
                          width: 150.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'register'.toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(
                            color:defaultColor
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Register Now To Browse our Hot Offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                              fontSize: 20.0,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        child: defaultForm(
                          onTap: () {},
                          onChange: () {},
                          controller: registerNameShopController,
                          type: TextInputType.name,
                          lapel: 'User Name',
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Name ';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        child: defaultForm(
                            onTap: () {},
                            onChange: () {},
                            controller: registerEmailShopController,
                            type: TextInputType.emailAddress,
                            lapel: 'Email'.toUpperCase(),
                            prefix: Icons.lock_outline,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please Enter Your Email';
                              }
                              return null;
                            },
                            ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        child: defaultForm(
                          onTap: () {},
                          onChange: () {},
                          controller: registerPasswordShopController,
                          type: TextInputType.visiblePassword,
                          lapel: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPasswordShown,
                          suffixPressed: () {
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        child: defaultForm(
                          onTap: () {},
                          onChange: () {},
                          controller: registerPhoneShopController,
                          type: TextInputType.phone,
                          lapel: 'Phone'.toUpperCase(),
                          prefix: Icons.phone_android_outlined,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        builder: (BuildContext context) {
                          return defaulButton(
                            text: 'Register'.toUpperCase(),
                            isUpperCase: true,
                            pressed: ()
                            {
                              if (formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  name:registerNameShopController.text ,
                                  phone:registerPhoneShopController.text ,
                                  email: registerEmailShopController.text,
                                  password: registerPasswordShopController.text,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        },
      ),
    );
  }
}
