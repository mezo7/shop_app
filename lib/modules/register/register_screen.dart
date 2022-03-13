import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/login_sceen.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../shared/component/components.dart';
import '../../shared/component/constance.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopRegisterCubit(),
      child:BlocConsumer<ShopRegisterCubit,RegisterStates>(
        listener: (context,state){
          if (state is RegisterSuccessState) {
            if (state.registerModel.status!) {
              showShortToast(
                  text: state.registerModel.message!, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data?.token,
              ).then((value) {
                token =state.registerModel.data?.token;
                navigateAndFinish(
                  context,
                  LoginScreen(),
                );
              });
            } else {
              showLongToast(
                  text: state.registerModel.message!, state: ToastStates.WARNING);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register Now To Browse Our Offers',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defualtTextFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Name';
                            }
                          },
                          label: 'Name',
                          prefixIcon: Icons.person,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defualtTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Email';
                            }
                          },
                          label: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defualtTextFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Password';
                            }
                          },
                          onSubmit: (value) {
                            // if (formKey.currentState!.validate()) {
                            //   // ShopLoginCubit.get(context).userLogin(
                            //   //   email: emailController.text,
                            //   //   password: passwordController.text,
                            //   // );
                            // }
                          },
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopRegisterCubit.get(context).changePassVisi();
                            },
                            icon: Icon(
                              ShopRegisterCubit.get(context).suffix,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defualtTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value.toString().isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                          },
                          label: 'Phone Number'
                              '',
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => defualtButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'REGISTER',
                            ),
                            fallback: (context) => const CircularProgressIndicator(),
                          ),
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
