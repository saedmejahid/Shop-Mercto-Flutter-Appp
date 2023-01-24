import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/shop_layout.dart';
import 'package:sallla_app/modules/shop%20app/login/cubit/cubit.dart';
import 'package:sallla_app/modules/shop%20app/login/cubit/states.dart';
import 'package:sallla_app/modules/shop%20app/register_screen/shop_register_screen.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/components/constants.dart';
import 'package:sallla_app/shared/network/local/cache_helper.dart';
import 'package:sallla_app/shared/styles/colors.dart';
class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey<FormState>();
    var loginEmailShopController = TextEditingController();
    var loginPasswordShopController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, ShopLoginStates state)
        {
          if (state is ShopLoginSuccessState)
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
        builder: (BuildContext context, ShopLoginStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        const Center(
                          child: Image(
                              image: AssetImage(
                                  'assets/images/logo.jpeg',
                              ),
                            width: 200.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color:defaultColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: defaultForm(
                            onTap: () {},
                            onChange: () {},
                            controller: loginEmailShopController,
                            type: TextInputType.emailAddress,
                            lapel: 'Email Address',
                            prefix: Icons.email_outlined,
                            validate: (String value)
                            {
                              if (value.isEmpty)
                              {
                                return 'Please Enter Your Email ';
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
                              controller: loginPasswordShopController,
                              type: TextInputType.visiblePassword,
                              lapel: 'Password',
                              prefix: Icons.lock_outline,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              isPassword:
                                  ShopLoginCubit.get(context).isPasswordShown,
                              validate: (String value)
                              {
                                if (value.isEmpty)
                                {
                                  return 'Please Enter Your Password';
                                }
                                return null;
                              },
                              onSup: (value)
                              {
                                if (formKey.currentState!.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: loginEmailShopController.text,
                                    password: loginPasswordShopController.text,
                                  );
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          builder: (BuildContext context) {
                            return defaulButton(
                              text: 'Login',
                              isUpperCase: true,
                              pressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: loginEmailShopController.text,
                                    password: loginPasswordShopController.text,
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t Have an account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              },
                              child: Text(
                                'register'.toUpperCase(),
                                style: const TextStyle(
                                  color: defaultColor
                                ),
                              ),
                            ),
                          ],
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
