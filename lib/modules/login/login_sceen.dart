
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/component/constance.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              // print(state.loginModel.message);
              // print(state.loginModel.data!.token);
              showShortToast(
                  text: state.loginModel.message!, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data?.token,
              ).then((value) {
                token =state.loginModel.data?.token;
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              // print(state.loginModel.message);
              showLongToast(
                  text: state.loginModel.message!, state: ToastStates.WARNING);
            }
          }
        },
        builder: (context, state) {
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
                          'LOGIN',
                          style:
                          Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login Now To Browse Our Offers',
                          style:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
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
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopLoginCubit.get(context).changePassVisi();
                            },
                            icon: Icon(
                              ShopLoginCubit.get(context).suffix,
                            ),
                          ),
                          suffixPressed: () {},
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => defualtButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'LOGIN',
                            ),
                            fallback: (context) => const CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t Have An Account? || ',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, RegisterScreen(),);
                              },
                              child: Text('Register Now'.toUpperCase(),),
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
