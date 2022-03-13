import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/component/constance.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).profileModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).profileModel!=null,
          builder: (context)=>Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              defualtTextFormField(
                controller: nameController,
                type: TextInputType.text,
                validate: (value){
                  if(value.isEmpty){
                    return'name must not be empty';
                  }
                  return null;
                },
                label: 'Name',
                prefixIcon: Icons.person,
              ),
              SizedBox(
                height: 15.0,
              ),
              defualtTextFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                validate: (value){
                  if(value.isEmpty){
                    return'email must not be empty';
                  }
                  return null;
                },
                label: 'Email',
                prefixIcon: Icons.email,
              ),
              SizedBox(
                height: 15,
              ),
              defualtTextFormField(
                controller: phoneController,
                type: TextInputType.text,
                validate: (value){
                  if(value.isEmpty){
                    return'phone must not be empty';
                  }
                  return null;
                },
                label: 'Phone',
                prefixIcon: Icons.phone,
              ),
              SizedBox(
                height: 15.0,
              ),
              defualtButton(
                  text: 'Sign Out',
                  function: (){
                    signOut(context);
                  },
                background: Colors.red,
                  ),
              
            ],
          ),
      ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
