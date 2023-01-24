import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sallla_app/layout/shop_app/cubit/cubit.dart';
import 'package:sallla_app/layout/shop_app/cubit/states.dart';
import 'package:sallla_app/shared/components/components.dart';
import 'package:sallla_app/shared/components/constants.dart';
class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);
   var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit,ShopAppStates>(
      listener: (BuildContext context ,ShopAppStates state){},
      builder: (BuildContext context ,ShopAppStates state)
      {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (BuildContext context)=>const Center(child: CircularProgressIndicator()),
           builder: (context) => Padding(
             padding: const EdgeInsets.all(30.0),
             child: SingleChildScrollView(
               child: Form(
                 key: formKey,
                 child: Column(
                   children: [
                     const Image(
                         image:AssetImage(
                           'assets/images/updatelogo.jpeg',
                         ),
                       width: 150.0,
                     ),
                     const SizedBox(
                       height: 20.0,
                     ),
                     Container(
                       child: defaultForm(
                           controller: nameController,
                           type: TextInputType.text,
                           lapel: 'name'.toUpperCase(),
                           prefix: Icons.person,
                           onTap: (){},
                           onChange: (){},
                           validate: (String value)
                           {
                             if(value.isEmpty)
                             {
                               return 'Name Must Not Be Empty';
                             }
                           },
                       ),
                     ),
                     const SizedBox(height: 3,),
                     if(state is ShopLoadingUpdateUserState)
                       const LinearProgressIndicator(),
                     const SizedBox(
                       height: 20.0,
                     ),
                     Container(
                       child: defaultForm(
                           controller: emailController,
                           type: TextInputType.emailAddress,
                           lapel: 'Email Address'.toUpperCase(),
                           prefix: Icons.email,
                           validate: (String value)
                           {
                             if(value.isEmpty)
                             {
                               return 'Email Must Not Be Empty';
                             }
                           },
                           onTap: (){},
                           onChange: (){}
                       ),
                     ),
                     const SizedBox(
                       height: 3,
                     ),
                     if(state is ShopLoadingUpdateUserState)
                     const LinearProgressIndicator(),
                     const SizedBox(
                       height: 20.0,
                     ),
                     Container(
                       child: defaultForm(
                           controller: phoneController,
                           type: TextInputType.phone,
                           lapel: 'Phone'.toUpperCase(),
                           prefix: Icons.phone_android_outlined,
                           validate: (String value)
                           {
                             if(value.isEmpty)
                             {
                               return 'Phone Must Not Be Empty';
                             }
                           },
                           onTap: (){},
                           onChange: (){}
                       ),
                     ),
                     const SizedBox(height: 3,),
                     if(state is ShopLoadingUpdateUserState)
                       const LinearProgressIndicator(),
                     const SizedBox(
                       height: 20.0,
                     ),
                     Container(
                       child: defaulButton(
                           text: 'Update Profile',
                           pressed: ()
                           {
                             if(formKey.currentState!.validate())
                             {
                               ShopCubit.get(context).updateUserData(
                                 name: nameController.text,
                                 email: emailController.text,
                                 phone: phoneController.text,
                               );
                             }
                           }
                       ),
                     ),
                     const SizedBox(
                       height: 30.0,
                     ),
                     Container(
                       child: defaulButton(
                           text: 'Log out',
                           pressed: ()
                           {
                             signOut(context);
                           }
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ),
        );
      },
    );
  }
}